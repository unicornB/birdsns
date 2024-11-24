import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as mDio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/config/app_env.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/interactiveviewer/video_item.dart';

import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:interactiveviewer_gallery_plus/hero_dialog_route.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';
import '../../components/interactiveviewer/image_item.dart';
import '../../entity/source_entity.dart';
import 'perm_util.dart';
import 'package:path/path.dart' as p;
import 'package:interactiveviewer_gallery_plus/interactiveviewer_gallery_plus.dart';

class AppUtil {
  //底部安全区域高度
  static double getSafeAreaHeight() {
    return MediaQuery.of(Get.context!).padding.bottom;
  }

  static void toPriva() {
    String url = "${AppConfig.host}/index/index/article?pageid=privacy";
    Get.toNamed(Routes.WEB, arguments: {"url": url, "title": "隐私政策"});
  }

  static void toUserAgree() {
    String url = "${AppConfig.host}/index/index/article?pageid=useragreement";
    Get.toNamed(Routes.WEB, arguments: {"url": url, "title": "用户协议"});
  }

  static String getFileUrl(String url) {
    if (url.startsWith("http")) {
      return url;
    }
    return AppConfig.staticHost + url;
  }

  static void showLoading(String text) {
    // if (text.isEmpty) {
    //   TDToast.showLoadingWithoutText(context: Get.context!);
    // } else {
    //   TDToast.showLoading(context: Get.context!, text: text);
    // }
    EasyLoading.show(status: text);
  }

  static void hideLoading() {
    // TDToast.dismissLoading();
    EasyLoading.dismiss();
  }

  static void showToast(String text) {
    //TDToast.showText(text, context: Get.context!);
    EasyLoading.showToast(text);
  }

  static void showActionSheet(
    List<String> items, {
    String? title,
    String? message,
    Function(int)? onSelected,
  }) {
    List<Widget> actions = [];
    for (int i = 0; i < items.length; i++) {
      actions.add(CupertinoActionSheetAction(
        child: Text(
          items[i],
          style: TextStyle(fontSize: 28.rpx),
        ),
        onPressed: () {
          Get.back();
          onSelected!(i);
        },
      ));
    }
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) {
          return CupertinoActionSheet(
            title: title == null ? null : Text(title),
            message: message == null ? null : Text(message),
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                'common_cancel'.tr,
                style: TextStyle(color: Colors.red, fontSize: 28.rpx),
              ),
              onPressed: () {
                Navigator.of(context).pop('cancel');
              },
            ),
          );
        });
  }

  static void permissionDialog({
    IconData? icon,
    String? title,
    String? message,
    required String perName,
    required String use,
    Function()? onNext,
  }) {
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 40.rpx, vertical: 0),
      content: SizedBox(
        height: 350.rpx,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.rpx,
            ),
            Text(
              message ?? "permission_message".tr,
              style: TextStyle(fontSize: 28.rpx, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20.rpx,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 34.rpx,
                  color: AppColor.subTitle,
                ),
                SizedBox(
                  width: 20.rpx,
                ),
                Text(
                  perName,
                  style: TextStyle(fontSize: 28.rpx),
                ),
              ],
            ),
            SizedBox(
              height: 20.rpx,
            ),
            Text(
              use,
              style: TextStyle(fontSize: 28.rpx),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Get.back();
                  if (onNext != null) {
                    onNext();
                  }
                },
                child: Text('permission_next'.tr),
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  static Future<mDio.MultipartFile> multipartFileFromAssetEntity(
      AssetEntity entity) async {
    mDio.MultipartFile mf;
    final file = await entity.file;
    if (file == null) {
      throw StateError('Unable to obtain file of the entity ${entity.id}.');
    }
    var filename = p.basename(file.path);
    log("文件路径${file.path}");
    mf = await mDio.MultipartFile.fromFile(
      file.path,
      filename: filename,
    );
    // final bytes = await entity.originBytes;
    // if (bytes == null) {
    //   throw StateError('Unable to obtain bytes of the entity ${entity.id}.');
    // }
    // mf = mDio.MultipartFile.fromBytes(bytes);
    return mf;
  }

  static Future<mDio.MultipartFile> multipartFileFromCroppedFile(
      CroppedFile file) async {
    var filename = p.basename(file.path);
    return await mDio.MultipartFile.fromFile(
      file.path,
      filename: filename,
    );
  }

  static Future<mDio.MultipartFile> multipartFileFromPath(String path,
      {String? contentType = "image/jpeg"}) async {
    var filename = p.basename(path);
    return await mDio.MultipartFile.fromFile(
      path,
      filename: filename,
      contentType: mDio.DioMediaType.parse(contentType!),
    );
  }

  //跳转设置页面弹窗
  static void gotoSetting(String perDesc) {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.white,
      content: Text(
        perDesc,
        style: TextStyle(fontSize: 32.rpx),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'permission_cancel'.tr,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            openAppSettings();
          },
          child: Text('permission_ok'.tr),
        )
      ],
    ));
  }

  //拍照
  static void takePhoto(Function(AssetEntity entity) onGet) {
    PermUtil.cameraPerm((status) async {
      if (status) {
        final AssetEntity? entity = await CameraPicker.pickFromCamera(
          Get.context!,
          pickerConfig: CameraPickerConfig(
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light, // 状态栏图标为暗色调
                  statusBarBrightness: Brightness.light,
                  statusBarColor: Colors.black, // 状态栏背景为白色
                  systemNavigationBarColor: Colors.black,
                ),
              ),
            ),
          ),
        );
        if (entity != null) {
          onGet(entity);
        }
      }
    });
  }

  //拍视频
  static void takeVideo(
      {Function(AssetEntity entity)? onGet, int second = 10}) {
    PermUtil.cameraPerm((status) async {
      if (status) {
        final AssetEntity? entity = await CameraPicker.pickFromCamera(
          Get.context!,
          pickerConfig: CameraPickerConfig(
            enableRecording: true,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light, // 状态栏图标为暗色调
                  statusBarBrightness: Brightness.light,
                  statusBarColor: Colors.black, // 状态栏背景为白色
                  systemNavigationBarColor: Colors.black,
                ),
              ),
            ),
          ),
        );
        if (entity != null) {
          onGet!(entity);
        }
      }
    });
  }

  //选择图片
  static void selectPhotos(Function(List<AssetEntity> files) onGet,
      {int? count = 1}) {
    PermUtil.photoPerm((status) async {
      if (status) {
        log("调用相册");
        final List<AssetEntity>? result = await AssetPicker.pickAssets(
          Get.context!,
          pickerConfig: AssetPickerConfig(maxAssets: count!),
        );
        if (result != null) {
          onGet(result);
        }
      } else {
        log("调用相册无权限");
      }
    });
  }

  static void selectVideo({Function(AssetEntity entity)? onGet}) {
    PermUtil.photoPerm((status) async {
      if (status) {
        final List<AssetEntity>? result = await AssetPicker.pickAssets(
          Get.context!,
          pickerConfig: const AssetPickerConfig(
            maxAssets: 1,
            requestType: RequestType.video,
          ),
        );
        if (result != null) {
          onGet!(result[0]);
        }
      } else {
        log("调用相册无权限");
      }
    });
  }

  static void openGallery(List<SourceEntity> sourceList, int index) {
    Navigator.of(Get.context!).push(
      HeroDialogRoute<void>(
        builder: (BuildContext context) => ColoredStatusBar(
          color: Colors.black,
          child: InteractiveviewerGalleryPlus<SourceEntity>(
            sources: sourceList,
            initIndex: index,
            itemBuilder: (BuildContext context, int index, bool isFocus) {
              SourceEntity sourceEntity = sourceList[index];
              log("测试：${sourceEntity.type}:${sourceEntity.url}");
              if (sourceEntity.type == 'video') {
                return VideoItem(
                  source: sourceEntity,
                  isFocus: isFocus,
                );
              } else {
                return ImageItem(
                  source: sourceEntity,
                );
              }
            },
            onPageChanged: (int pageIndex) {},
          ),
        ),
      ),
    );
  }
}
