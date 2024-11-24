<?php

namespace app\api\controller;

use app\common\controller\Api;

class Profile extends Api
{
    protected $noNeedLogin = ['index'];
    protected $noNeedRight = '*';

    public function index(){
        $id=$this->request->param("id");
        $model=new \app\common\model\User;
        $user=$model->field("id,nickname,email,avatar,gender,birthday,bio,bg_img,jointime,fans_num as fans,see_followswitch as follows_see,see_fansswitch as fans_see,city,country,province")
            ->find($id);
        $this->success("",$user);
    }
}