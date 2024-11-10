<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\library\Ip2region;
use app\common\model\app\Banner;
use app\common\model\app\Menu;
use app\common\model\circle\Circle;
use Exception;

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
    //圈子列表
    public function circlelist(){
       $pid=$this->request->param("pid",0);
       $list=Circle::where("status",1)->where("pid",$pid)->order("weigh desc")->select();
       $this->success('请求成功',$list);
    }

    public function test(){
        $this->success("",ip_search($this->request->ip()));
    }
}
