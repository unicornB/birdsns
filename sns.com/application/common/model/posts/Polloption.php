<?php

namespace app\common\model\posts;

use think\Model;


class Polloption extends Model
{

    

    

    // 表名
    protected $name = 'posts_poll_option';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    

    







}