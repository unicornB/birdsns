<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\posts\Commentlike;
use think\Db;
use think\Exception;
use app\common\model\posts\Comment as CommentModel;

class Comment extends Api
{
    protected $noNeedLogin = ['index'];
    protected $noNeedRight = '*';

    public function add(){
        $pid=$this->request->param("pid",0);
        $posts_id=$this->request->param("posts_id");
        $user=$this->auth->getUser();
        $type=$this->request->param("type","text");
        $file_url=$this->request->param("file_url","");
        $content=$this->request->param("content","");
        $posts=\app\common\model\posts\Posts::get($posts_id);
        if(!$posts){
            $this->error("帖子不存在");
        }
        if(mb_strlen($content,"UTF-8")>50){
            $this->error("不能超过50个字符");
        }
        $data=[
            'pid'=>$pid,
            'posts_id'=>$posts_id,
            'user_id'=>$user->id,
            'type'=>$type,
            'fa_user_id'=>$posts->user_id,
            'createtime'=>time(),
            'content'=>$content
        ];
        if($type=='audio'||$type=='image'){
            $data['file_url']=$file_url;
        }
        $region=ip_search($this->request->ip());

        if($region!=null){
            $arr = explode("|", $region);
            $data['city']=$arr[3];
            $data['country']=$arr[0];
            $data['province']=$arr[2];
        }
        Db::startTrans();
        try{
            $model=new \app\common\model\posts\Comment;
            $newId=$model->insertGetId($data);
            $posts->com_num=$posts->com_num+1;
            $posts->save();
            if($pid>0){
                $comment=\app\common\model\posts\Comment::get($pid);
                $comment->comm_num=$comment->comm_num+1;
                $comment->save();
            }
            if($user->id!=$posts->user_id){
                $json=$user->nickname."评论你的帖子";
                send_notification($user->id,$posts->user_id,"comment",$posts_id,$json);
            }
            Db::commit();
            $this->success("评论成功",$model->find($newId));
        }catch (Exception $e){
            Db::rollback();
            $this->error("评论失败");
        }
    }

    public function index(){
        $posts_id=$this->request->param("posts_id");
        if(empty($posts_id)){
            $this->error("");
        }
        $model=new \app\common\model\posts\Comment;
        $model=$model->alias("c")->where("c.posts_id",$posts_id)->where("c.pid",0);
        $user=$this->auth->getUser();
        $list=$model->field("c.*,u.nickname,u.avatar")
            ->join("user u","u.id=c.user_id")
            ->order("c.createtime desc")->paginate()->each(function ($item)use ($posts_id,$user){
                if($item->comm_num>0){
                    $item->children=\app\common\model\posts\Comment::alias("c")
                        ->field("c.*,u.nickname,u.avatar")
                        ->where("c.posts_id",$posts_id)
                        ->where("c.type","<>","audio")
                        ->where("c.pid",$item->id)
                        ->join("user u","u.id=c.user_id")
                        ->limit(2)->select();
                }
                if($this->auth->isLogin()){
                    $like=Commentlike::where("comment_id",$item->id)->where("user_id",$user->id)->find();
                    if($like){
                        $item->liked=true;
                    }else{
                        $item->liked=false;
                    }
                }else{
                    $item->liked=false;

                }
                return $item;
            });
        $this->success("",$list);
    }

    public function sublist(){
        $pid=$this->request->param("pid");
        if(empty($pid)){
            $this->error("");
        }
        $model=new \app\common\model\posts\Comment;
        $model=$model->alias("c")->where("c.pid",$pid);
        $list=$model->field("c.*,u.nickname,u.avatar")
            ->join("user u","u.id=c.user_id")
            ->order("c.createtime desc")->paginate();
        $this->success("",$list);
    }
    public function like(){
        $id=$this->request->param("id");
        $user=$this->auth->getUser();
        $checklike=Commentlike::where("comment_id",$id)->where("user_id",$user->id)->find();
        if($checklike){
            $checklike->delete();
            //更新点赞数
            $num=update_comment_like_num($id,2);
            $this->success("取消点赞",["num"=>$num,"type"=>"cancel"]);
        }else{
            $detail=CommentModel::get($id);
            if($detail){
                $data=["comment_id"=>$id,"user_id"=>$user->id,"fa_user_id"=>$detail['user_id'],"createtime"=>time(),'posts_id'=>$detail->posts_id];
                Commentlike::create($data);
                //更新点赞数
                $num=update_comment_like_num($id,1);
                //发送通知
                if($user->id!=$detail->user_id){
                    $json=$user->nickname."给你的评论点赞了";
                    send_notification($user->id,$detail->user_id,"comment_like",$detail->posts_id,$json);
                }
                $this->success("点赞成功",["num"=>$num,"type"=>"add"]);
            }else{
                $this->success("点赞失败");
            }
        }
    }
}