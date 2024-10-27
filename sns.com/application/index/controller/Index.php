<?php

namespace app\index\controller;

use app\common\controller\Frontend;
use app\common\model\app\Page;

class Index extends Frontend
{

    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';
    protected $layout = '';

    public function index()
    {
        return $this->view->fetch();
    }

    public function article(){
        $name=$this->request->param("pageid");
        $article=Page::where("name",$name)->where("displayswitch",1)->find();
        $this->view->assign("article",$article);
        return $this->view->fetch();
    }


}
