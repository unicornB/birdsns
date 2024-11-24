<?php

namespace app\common\behavior;

class User
{
    public function userRegisterSuccessed(&$params){
        $region=ip_search($params['joinip']);
        if($region!=null){
            $arr = explode("|", $region);
            $data['city']=$arr[3];
            $data['country']=$arr[0];
            $data['province']=$arr[2];
        }
    }
}