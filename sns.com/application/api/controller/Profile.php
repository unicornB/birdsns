<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\posts\Collect;
use app\common\model\posts\Like;
use app\common\model\posts\Polloption;
use app\common\model\posts\Pollrecord;
use app\common\model\posts\Posts as PostsModel;

class Profile extends Api
{
    protected $noNeedLogin = ['index','postslist'];
    protected $noNeedRight = '*';

    public function index(){
        $id=$this->request->param("id");
        $model=new \app\common\model\User;
        $user=$model->field("id,nickname,email,avatar,gender,birthday,bio,bg_img,jointime,fans_num as fans,see_followswitch as follows_see,see_fansswitch as fans_see,city,country,province")
            ->find($id);
        $this->success("",$user);
    }

    public function postslist(){
        $type=$this->request->param("type");
        $hot=$this->request->param("hot");
        $nearby=$this->request->param("nearby");
        $userId=$this->request->param("userId");
        $model=new PostsModel;
        $model=$model->alias("p");
        $orders=["p.createtime"=>"desc"];
        if(!empty($type)){
            $model=$model->where("p.type",$type);
        }
        if(!empty($hot)){
            $orders['p.view_num']="desc";
        }
        if(!empty($userId)){
            $orders['p.user_id']=$userId;
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
}