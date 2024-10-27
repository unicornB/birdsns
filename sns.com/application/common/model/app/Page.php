<?php

namespace app\common\model\app;

use think\Model;


class Page extends Model
{

    

    

    // 表名
    protected $name = 'page';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    

    







}
