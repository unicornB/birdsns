<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\app\Banner;
use app\common\model\app\Menu;

/**
 * 首页接口
 */
class Index extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    /**
     * 首页
     *
     */
    public function index()
    {
        $banners=Banner::where("position","home")->where("displayswitch",1)->order("weigh desc")->select();
        $menus=Menu::where("position","home")->where("displayswitch",1)->order("weigh desc")->select();
        $data=[
            "banners"=>$banners,
            "menus"=>$menus
        ];
        $this->success('请求成功',$data);
    }
}
