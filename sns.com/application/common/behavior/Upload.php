<?php

namespace app\common\behavior;

use think\Config;
use think\Log;

class Upload
{
    public function uploadAfter(&$params){
        //Log::record("上传监听".json_encode($params),'info');
        if($params['storage']=='wfs'){
            //文件路径
            $destDir = ROOT_PATH . 'public'.$params['url'];
            if($params['mimetype']=='video/mp4'){
                $outFile=$destDir.".jpg";
                //视频截图
                $ffmpegRoot=ROOT_PATH.'ffmpeg/ffmpeg';
                $command = $ffmpegRoot." -i $destDir -ss 00:00:01 -vframes 1 $outFile";
                $res=exec($command);
                Log::record("视频截图：".$res,'info');
                $wfsUploadUrl=Config::get("upload.wfsurl")."/append".$params['url'] . ".jpg";
                wfs_upload($wfsUploadUrl,$outFile);
                unlink($outFile);
            }
            //删除本地图片
            unlink($destDir);

        }

    }
    public function uploadDelete(&$params){
        if($params['storage']=='wfs'){
            if($params['mimetype']=='video/mp4'){
                $delCoverUrl=Config::get("upload.wfsurl")."/delete".$params['url'] . ".jpg";
                wfs_delete($delCoverUrl);
            }
            $delUrl=Config::get("upload.wfsurl")."/delete".$params['url'];
            wfs_delete($delUrl);

        }
    }

}