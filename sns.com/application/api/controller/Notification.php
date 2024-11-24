<?php

namespace app\api\controller;


use app\common\controller\Api;
use app\common\model\Notifications;

class Notification extends Api
{
    protected $noNeedLogin = [''];
    protected $noNeedRight = '*';
    public function getCount(){
        $user=$this->auth->getUser();
        $unreadCount=Notifications::where("recipient_id",$user->id)->where("status","0")->count();
        $this->success("",$unreadCount);
    }
    public function index(){
        $user=$this->auth->getUser();
        $model=new Notifications();
        $list=$model->alias("n")
            ->field("n.*,u.avatar,u.nickname")
            ->where("n.recipient_id",$user->id)
            ->join("user u","u.id=n.notifier_id")
            ->order("n.createtime desc")
            ->paginate();
        $this->success("",$list);
    }
    public function read(){
        $id=$this->request->param("id");
        read_notification($id);
        $this->success("");
    }
    public function readall(){
        $user=$this->auth->getUser();
        Notifications::where("recipient_id",$user->id)->update(["status"=>"1"]);
        $this->success("");
    }
}