<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\Attachment;
use app\common\model\posts\Collect;
use app\common\model\posts\Like;
use app\common\model\posts\Polloption;
use app\common\model\posts\Pollrecord;

use think\Db;
use think\Exception;
use app\common\model\posts\Posts as PostsModel;
use think\Log;

class Posts extends Api
{
    protected $noNeedLogin = ['reclist','index','detail'];
    protected $noNeedRight = '*';
    //推荐列表
    public function index(){
        $type=$this->request->param("type");
        $hot=$this->request->param("hot");
        $nearby=$this->request->param("nearby");
        $model=new PostsModel;
        $model=$model->alias("p");
        $orders=["p.createtime"=>"desc"];
        if(!empty($type)){
            $model=$model->where("p.type",$type);
        }
        if(!empty($hot)){
            $orders['p.view_num']="desc";
        }
        if(!empty($nearby)){
            $region=ip_search($this->request->ip());
            $ip_city="";
            if($region!=null){
                $arr = explode("|", $region);
                $ip_city=$arr[3];
            }
            if($ip_city!=""){
                $model=$model->where("p.ip_city",$ip_city);
            }
        }
        $user=$this->auth->getUser();
        $list=$model->field("p.*,u.nickname,u.avatar,c.title")
        ->join("user u","u.id=p.user_id")
        ->join("circle c","c.id=p.circle_id")
        ->order($orders)->paginate()->each(function ($item)use($user){
            if($item->type=='poll'){
                $item->poll=Polloption::where('posts_id',$item->id)->select();
                if($this->auth->isLogin()){
                    //判断是投票
                    //$user=$this->auth->getUser();
                    $record=Pollrecord::where("posts_id",$item->id)->where("user_id",$user->id)->find();
                    if($record){
                        $item->polled=$record->id;
                    }else{
                        $item->polled=0;
                    }
                }else{
                    $item->polled=0;
                }
            }
            if($this->auth->isLogin()){
                $like=Like::where("posts_id",$item->id)->where("user_id",$user->id)->find();
                if($like){
                    $item->liked=true;
                }else{
                    $item->liked=false;
                }
                $collect=Collect::where("posts_id",$item->id)->where("user_id",$user->id)->find();
                if($collect){
                    $item->collected=true;
                }else{
                    $item->collected=false;
                }
            }else{
                $item->liked=false;
                $item->collected=false;
            }

            return $item;
        });
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
        if(mb_strlen($content,"UTF-8")>200){
            $this->error("不能超过200个字符");
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
        $data=[
            'user_id'=>$user->id,
            'circle_id'=>$circle_id,
            'type'=>$type,
            'content'=>$content,
            'status'=>0,
            'createtime'=>time(),
            'updatetime'=>time(),
        ];
        $region=ip_search($this->request->ip());
        if($region!=null){
            $arr = explode("|", $region);
            $data['ip_city']=$arr[3];
            $data['country']=$arr[0];
            $data['province']=$arr[2];
        }
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
                $poll_options=json_decode(html_entity_decode($poll_data),true);
                foreach ($poll_options as $option){
                    $optionData=[
                        'title'=>$option['title'],
                        'posts_id'=>$post->id,
                        'createtime'=>time(),
                    ];
                    Polloption::create($optionData);
                }
            }
            //更新圈子下的帖子数
            $circle=\app\common\model\circle\Circle::get($circle_id);
            if($circle){
                $circle->post_num=$circle->post_num+1;
                $circle->save();
            }
            Db::commit();
            $this->success("发布成功");
        }catch (Exception $e){
            Db::rollback();
            Log::record("帖子发布错误：".$e->getMessage());
            $this->error("发布失败");
        }
    }

    public function poll(){
        $option_id=$this->request->post("option_id");
        $option=Polloption::get($option_id);
        if(!$option){
            $this->error("选项不存在");
        }
        //判断是否投过
        $user=$this->auth->getUser();
        $record=Pollrecord::where("posts_id",$option['posts_id'])->where("user_id",$user->id)->find();
        if($record){
            $this->error("你已经投过票，请不要重复");
        }
        Db::startTrans();
        try{
            $data=[
                'option_id'=>$option_id,
                'user_id'=>$user->id,
                'posts_id'=>$option['posts_id'],
                'createtime'=>time()
            ];
            Pollrecord::create($data);
            $option->tickets=$option->tickets+1;
            $option->save();
            Db::commit();
            $this->success("投票成功");
        }catch (Exception $e){
            Db::rollback();
            $this->error("投票失败");
        }
    }

    public function detail(){
        $id=$this->request->param("id");
        $detail=PostsModel::get($id);
        if($detail){
            $user=\app\common\model\User::get($detail->user_id);
            $detail['nickname']=$user->nickname;
            $detail['avatar']=$user->avatar;
            $circle=\app\common\model\circle\Circle::get($detail->circle_id);
            $detail['title']=$circle->title;
            if($detail->type=='poll'){
                $detail->poll=Polloption::where('posts_id',$detail->id)->select();
                if($this->auth->isLogin()){
                    //判断是投票
                    //$user=$this->auth->getUser();
                    $record=Pollrecord::where("posts_id",$detail->id)->where("user_id",$user->id)->find();
                    if($record){
                        $detail->polled=$record->id;
                    }else{
                        $detail->polled=0;
                    }
                }else{
                    $detail->polled=0;
                }
            }
            if($this->auth->isLogin()){
                $like=Like::where("posts_id",$detail->id)->where("user_id",$user->id)->find();
                if($like){
                    $detail->liked=true;
                }else{
                    $detail->liked=false;
                }
                $collect=Collect::where("posts_id",$detail->id)->where("user_id",$user->id)->find();
                if($collect){
                    $detail->collected=true;
                }else{
                    $detail->collected=false;
                }
            }else{
                $detail->liked=false;
                $detail->collected=false;
            }
            $this->success("",$detail);
        }
        $this->error("");
    }
    //点赞
    public function like(){
        $id=$this->request->param("id");
        $user=$this->auth->getUser();
        $checklike=Like::where("posts_id",$id)->where("user_id",$user->id)->find();
        if($checklike){
            $checklike->delete();
            //更新点赞数
            $num=update_posts_like_num($id,2);
            $this->success("取消点赞",["num"=>$num,"type"=>"cancel"]);
        }else{
            $detail=PostsModel::get($id);
            if($detail){
                $data=["posts_id"=>$id,"user_id"=>$user->id,"fa_user_id"=>$detail['user_id'],"createtime"=>time()];
                Like::create($data);
                //更新点赞数
                $num=update_posts_like_num($id,1);
                //发送通知
                if($user->id!=$detail->user_id){
                    $json=$user->nickname."点赞了你的帖子";
                    send_notification($user->id,$detail->user_id,"posts_like",$id,$json);
                }
                $this->success("点赞成功",["num"=>$num,"type"=>"add"]);
            }else{
                $this->success("点赞失败");
            }
        }
    }
    public function collect(){
        $id=$this->request->param("id");
        $user=$this->auth->getUser();
        $checkCollect=Collect::where("posts_id",$id)->where("user_id",$user->id)->find();
        if($checkCollect){
            $checkCollect->delete();
            //更新点赞数
            $posts=\app\common\model\posts\Posts::get($id);
            $posts->collect_num=$posts->collect_num-1;
            $posts->save();
            $this->success("取消收藏",["num"=>$posts->collect_num,"type"=>"cancel"]);
        }else{
            $detail=PostsModel::get($id);
            if($detail){
                $data=["posts_id"=>$id,"user_id"=>$user->id,"fa_user_id"=>$detail['user_id'],"createtime"=>time()];
                Collect::create($data);
                //更新点赞数
                $posts=\app\common\model\posts\Posts::get($id);
                $posts->collect_num=$posts->collect_num+1;
                $posts->save();
                $this->success("收藏成功",["num"=>$posts->collect_num,"type"=>"add"]);
            }else{
                $this->success("收藏失败");
            }
        }
    }
}