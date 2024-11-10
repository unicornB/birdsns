<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\Attachment;
use app\common\model\circle\Circle as CircleModel;
use app\common\model\circle\Follow;
use think\Db;
use think\Exception;
use think\Log;

class Circle extends Api
{
    protected $noNeedLogin = ['reclist'];
    protected $noNeedRight = '*';

    public function index(){
        $list = CircleModel::where('status',1)->where('pid',0)->order('weigh','desc')->select();
        foreach ($list as $key=>$val){
            $list[$key]['children'] = CircleModel::where('status',1)
                ->where('pid',$val['id'])
                ->order('weigh','desc')->select();
        }
        $this->success("success",$list);
    }
    public function add(){
        $iconimage = $this->request->post('iconimage');
        $pid = $this->request->post('pid',0);
        $title = $this->request->post('title');
        $bannerimage = $this->request->post('bannerimage');
        $desc=$this->request->post('desc');
        if(empty($iconimage)){
            $this->error(__('Iconimage Not Empty'));
        }
        if($pid==0){
            $this->error(__('Pid Not Empty'));
        }
        if(empty($title)){
            $this->error(__('Title Not Empty'));
        }
        if(empty($bannerimage)){
            $this->error(__('Bannerimage Not Empty'));
        }
        if(empty($desc)){
            $this->error(__('Desc Not Empty'));
        }
        if (CircleModel::getByTitle($title)) {
            $this->error(__('Title already exist'));
        }
        $user=$this->auth->getUser();
        $data = [
            'iconimage' => $iconimage,
            'pid' => $pid,
            'title'=> $title,
            'bannerimage' => $bannerimage,
            'desc' => $desc,
            'status'=>0,
            'weigh'=>99,
            'user_id'=>$user->id
        ];
        Db::startTrans();
        try{
            $circle=CircleModel::create($data);
            if($circle){
                //设置图片为永久
                Attachment::where("url",$iconimage)->update(['forever'=>1]);
                Attachment::where("url",$bannerimage)->update(['forever'=>1]);
                Db::commit();
                $this->success(__('Add Success'));
            }else{
                Db::rollback();
                $this->error(__('Add Fail'));
            }
        }catch (Exception $e) {
            Log::record('添加圈子失败：'.$e->getMessage());
            Db::rollback();
            $this->error(__('Add Fail'));
        }

    }

    //加入圈子
    public function follow(){
        $circle_id=$this->request->post('circle_id',0);
        $circle=CircleModel::get($circle_id);
        if(!$circle){
            $this->error(__("Circle Not Exist"));
        }
        $user=$this->auth->getUser();
        $followExit=Follow::where("circle_id",$circle_id)->where("user_id",$user->id)->find();
        if($followExit){
            $this->error(__("Circle Already Join"));
        }
        $manageswitch=$circle->user_id==$user->id?1:0;
        $data=[
            "circle_id"=>$circle_id,
            "user_id"=>$user->id,
            "createtime"=>time(),
            "manageswitch"=>$manageswitch
        ];
        Db::startTrans();
        try{
            Follow::create($data);
            $circle->follow_num=$circle->follow_num+1;
            $circle->save();
            Db::commit();
            $this->success(__("Join Success"));
        }catch (Exception $e){
            Db::rollback();
            $this->error(__("Join Fail").$e->getMessage());
        }
    }

    //取消关注
    public function followcancel(){
        $circle_id=$this->request->post('circle_id',0);
        $circle=CircleModel::get($circle_id);
        if(!$circle){
            $this->error(__("Circle Not Exist"));
        }
        $user=$this->auth->getUser();
        $followExit=Follow::where("circle_id",$circle_id)->where("user_id",$user->id)->find();
        if(!$followExit){
            $this->error(__("You Not Join Circle"));
        }
        Db::startTrans();
        try{
            $followExit->delete();
            $circle->follow_num=$circle->follow_num-1;
            $circle->save();
            Db::commit();
            $this->success(__("Cancel Success"));
        }catch (Exception $e){
            Db::rollback();
            $this->error(__("Cancel Fail").$e->getMessage());
        }
    }
    //我关注的圈子
    public function myfollows(){
        $user=$this->auth->getUser();
        $list=Follow::where("user_id",$user->id)->field("circle_id")->select();
        $this->success("",$list);
    }

    //首页推荐
    public function reclist(){
        $list=CircleModel::where("pid",'>',0)->where('recswitch',1)->order("weigh desc")->select();
        $this->success("",$list);
    }

    public function mycirclelist(){
        $user=$this->auth->getUser();
        $list=CircleModel::where("user_id",$user->id)->where('recswitch',1)->order("weigh desc")->select();
        $this->success("",$list);
    }
}