<?php

namespace app\common\model\circle;

use think\Model;


class Circle extends Model
{

    

    

    // 表名
    protected $name = 'circle';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'status_text',
        'privpostdata_text',
        'privcomdata_text'
    ];
    

    protected static function init()
    {
        self::afterInsert(function ($row) {
            if (!$row['weigh']) {
                $pk = $row->getPk();
                $row->getQuery()->where($pk, $row[$pk])->update(['weigh' => $row[$pk]]);
            }
        });
    }

    
    public function getStatusList()
    {
        return ['0' => __('Status 0'), '1' => __('Status 1'), '2' => __('Status 2')];
    }

    public function getPrivpostdataList()
    {
        return ['everyone' => __('Everyone'), 'admin' => __('Admin')];
    }

    public function getPrivcomdataList()
    {
        return ['everyone' => __('Everyone'), 'forbid' => __('Forbid')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPrivpostdataTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['privpostdata']) ? $data['privpostdata'] : '');
        $list = $this->getPrivpostdataList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPrivcomdataTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['privcomdata']) ? $data['privcomdata'] : '');
        $list = $this->getPrivcomdataList();
        return isset($list[$value]) ? $list[$value] : '';
    }




}
