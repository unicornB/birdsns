<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\Attachment;
use app\common\model\posts\Polloption;
use think\Db;
use think\Exception;
use app\common\model\posts\Posts as PostsModel;
use think\Log;

class Posts extends Api
{
    protected $noNeedLogin = ['reclist','index'];
    protected $noNeedRight = '*';
    //推荐列表
    public function index(){
        $type=$this->request->param("type");
        $model=new PostsModel;
        $model=$model->alias("p");
        if(!empty($type)){
            $model=$model->where("p.type",$type);
        }
        $list=$model->field("p.*,u.nickname,u.avatar,c.title")
        ->join("user u","u.id=p.user_id")
        ->join("circle c","c.id=p.circle_id")
        ->order("p.createtime desc")->paginate();
        $this->success("",$list);
    }

    //发布帖子
    public function publish(){
        $user=$this->auth->getUser();
        $type = $this->request->post('type','text');
        $circle_id=$this->request->post('circle_id');
        $images=$this->request->post('images','');
        $file_url=$this->request->post('file_url','');
        $poll_data=$this->request->post('poll_data','');
        $content=$this->request->post('content','');
        if(empty($type)){
            $this->error("请确定帖子类型");
        }
        if(empty($circle_id)){
            $this->error("请选择圈子");
        }
        $circle=\app\common\model\circle\Circle::where("status",1)->where("id",$circle_id)->find();
        if(!$circle){
            $this->error("圈子不存在");
        }
        if($type=='text'&&empty($content)){
            $this->error("请上传内容");
        }
        if($type=='image'&&empty($images)){
            $this->error("请上传图片");
        }
        if($type=='video'&&empty($file_url)){
            $this->error("请上传视频");
        }
        if($type=='audio'&&empty($file_url)){
            $this->error("请上传音频");
        }
        if($type=='poll'&&empty($poll_data)){
            $this->error("请上传投票数据");
        }
        $region=ip_search($this->request->ip());
        $ip_city="";
        if($region!=null){
            $arr = explode("|", $region);
            $ip_city=$arr[3];
        }
        $data=[
            'user_id'=>$user->id,
            'circle_id'=>$circle_id,
            'type'=>$type,
            'content'=>$content,
            'status'=>0,
            'createtime'=>time(),
            'updatetime'=>time(),
            'ip_city'=>$ip_city
        ];
        if($type=='image'){
            $data['images']=$images;
        }
        if($type=='video'||$type=='audio'){
            $data['file_url']=$file_url;
            //获取附件信息
            $attachment=Attachment::where("url",$file_url)->find();
            if($attachment){
                if($attachment['media_width']>0){
                    $data['media_width']=$attachment['media_width'];
                }
                if($attachment['media_height']>0){
                    $data['media_height']=$attachment['media_height'];
                }
                if($attachment['duration']>0){
                    $data['duration']=$attachment['duration'];
                }
            }
        }
        Db::startTrans();
        try{
            $post=PostsModel::create($data);
            $circle->post_num=$circle->post_num+1;
            $circle->save();
            if($type=='video'||$type=='audio'){
                $this->setFileForever($file_url);
            }
            if($type=='image'){
                $arr=explode(",", $images);
                foreach ($arr as $img){
                    $this->setFileForever($img);
                }
            }
            if($type=='poll'){
                $poll_options=json_decode($poll_data);
                Log::record("poll_options1：".json_encode($poll_options,JSON_UNESCAPED_UNICODE));
                foreach ($poll_options as $option){
                    $optionData=[
                        'title'=>$option['title'],
                        'posts_id'=>$post->id,
                        'createtime'=>time(),
                    ];
                    Polloption::create($optionData);
                }
            }
            Db::commit();
            $this->success("发布成功");
        }catch (Exception $e){
            Db::rollback();
            Log::record("帖子发布错误：".$e->getMessage());
            $this->error("发布失败");
        }
    }
}