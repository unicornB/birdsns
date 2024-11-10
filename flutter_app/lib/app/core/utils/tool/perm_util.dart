import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/custom_icons/app_icon.dart';
import 'app_util.dart';

/// 权限申请相关方法
class PermUtil {
// granted：权限已授予。
// denied：权限被拒绝，但可以再次请求。
// restricted：系统限制了访问权限。
// permanentlyDenied：权限被永久拒绝，只能通过系统设置更改。
// limited：权限有限授予。
// provisional：临时权限。
  /// 基础权限申请
  static Future<void> initPermissions() async {
    if (await Permission.contacts.request().isGranted) return;

    await [
      Permission.storage,
      Permission.camera,
    ].request();
  }

  /// 存储权限申请
  static Future<bool> storagePerm() async {
    PermissionStatus status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final statuses = await [Permission.storage].request();
      return statuses[Permission.storage] == PermissionStatus.granted;
    }
    return true;
  }

  /// 相机权限申请
  static Future<void> cameraPerm(Function(bool)? onGranted) async {
    PermissionStatus status = await Permission.camera.status;
    if (status == PermissionStatus.permanentlyDenied) {
      AppUtil.gotoSetting("permission_setting_tips_camera".tr);
      return;
    }
    log("相机权限状态：$status");
    if (status != PermissionStatus.granted) {
      if (Platform.isAndroid) {
        AppUtil.permissionDialog(
          perName: "permission_camera_perm".tr,
          use: "permission_camera_use".tr,
          icon: AppIcon.camera,
          onNext: () async {
            final statuses = await [Permission.camera].request(); // 请求权限
            bool agree =
                statuses[Permission.camera] == PermissionStatus.granted;
            if (onGranted != null) {
              onGranted(agree);
            }
          },
        );
      } else if (Platform.isIOS) {
        final statuses = await [Permission.camera].request(); // 请求权限
        bool agree = statuses[Permission.camera] == PermissionStatus.granted;
        if (onGranted != null) {
          onGranted(agree);
        }
      }
    } else {
      if (onGranted != null) {
        onGranted(true);
      }
    }
  }

  /// 相册权限申请
  static Future<void> photoPerm(Function(bool)? onGranted) async {
    PermissionStatus status = await Permission.photos.status;
    log("photoPerm: $status");
    if (status == PermissionStatus.permanentlyDenied) {
      AppUtil.gotoSetting("permission_setting_tips_photo".tr);
      return;
    }
    if (status != PermissionStatus.granted) {
      if (Platform.isAndroid) {
        AppUtil.permissionDialog(
          perName: "permission_photo_perm".tr,
          use: "permission_photo_use".tr,
          icon: AppIcon.pubImage,
          onNext: () async {
            final statuses = await [Permission.photos].request(); // 请求权限
            bool agree =
                statuses[Permission.photos] == PermissionStatus.granted;
            log("photoPerm: $agree");
            if (onGranted != null) {
              onGranted(agree);
            }
          },
        );
      } else if (Platform.isIOS) {
        final statuses = await [Permission.photos].request(); // 请求权限
        log("ios statuses: $statuses");
        bool agree = statuses[Permission.photos] == PermissionStatus.granted;

        if (onGranted != null) {
          onGranted(agree);
        }
      }
    } else {
      if (onGranted != null) {
        onGranted(true);
      }
    }
  }

  static Future<void> audioPerm(Function(bool)? onGranted) async {
    PermissionStatus status = await Permission.audio.status;
    if (status == PermissionStatus.permanentlyDenied) {
      AppUtil.gotoSetting("permission_setting_tips_audio".tr);
      return;
    }
    if (status != PermissionStatus.granted) {
      if (Platform.isAndroid) {
        AppUtil.permissionDialog(
          perName: "permission_audio_perm".tr,
          use: "permission_audio_use".tr,
          icon: AppIcon.pubImage,
          onNext: () async {
            final statuses = await [Permission.audio].request(); // 请求权限
            bool agree = statuses[Permission.audio] == PermissionStatus.granted;
            log("audioPerm: $agree");
            if (onGranted != null) {
              onGranted(agree);
            }
          },
        );
      } else if (Platform.isIOS) {
        final statuses = await [Permission.audio].request(); // 请求权限
        log("ios statuses: $statuses");
        bool agree = statuses[Permission.audio] == PermissionStatus.granted;
        if (onGranted != null) {
          onGranted(agree);
        }
      }
    } else {
      if (onGranted != null) {
        onGranted(true);
      }
    }
  }
}
