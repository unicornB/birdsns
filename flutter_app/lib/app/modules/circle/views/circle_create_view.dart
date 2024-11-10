import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/login_input/login_input.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';

import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../core/utils/tool/app_util.dart';
import '../controllers/circle_create_controller.dart';

class CircleCreateView extends GetView<CircleCreateController> {
  const CircleCreateView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: Text('circle_create'.tr),
          centerTitle: true,
          surfaceTintColor: AppColor.white,
          elevation: 0,
          shadowColor: AppColor.subBg,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 20.rpx,
                color: Colors.white,
              ),
              _title("circle_title_cate".tr, notnull: true),
              Obx(() => _selectCategory()),
              _title("circle_title_head".tr, notnull: true),
              Obx(() => _selectHead()),
              _title("circle_title_banner".tr, notnull: true),
              Obx(() => _selectBanner()),
              _title("circle_title_title".tr, notnull: true),
              _inputView("circle_enter_title".tr,
                  controller: controller.titleEditingController),
              _title("circle_title_desc".tr, notnull: true),
              _descView(),
              _bottomView(),
              Container(
                height: 100.rpx,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String title, {bool? notnull = false}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.rpx, vertical: 20.rpx),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 28.rpx,
              fontWeight: FontWeight.bold,
            ),
          ),
          notnull!
              ? const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _selectCategory() {
    List<TDRadio> radios = [];
    controller.circleList.value.forEach((element) {
      radios.add(TDRadio(
        id: "${element.id}",
        title: element.title,
        cardMode: true,
      ));
    });

    return Container(
      color: AppColor.white,
      child: TDRadioGroup(
        selectId: "${controller.pid.value}",
        cardMode: true,
        direction: Axis.horizontal,
        rowCount: 4,
        directionalTdRadios: radios,
        onRadioGroupChange: (selectedId) {
          controller.pid.value = int.parse(selectedId!);
        },
      ),
    );
  }

  Widget _selectHead() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.rpx),
      alignment: Alignment.centerLeft,
      child: controller.iconimage.value.isEmpty
          ? Row(
              children: [
                Container(
                  width: 220.rpx,
                  height: 220.rpx,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.subBg,
                    borderRadius: BorderRadius.circular(10.rpx),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      AppUtil.showActionSheet(
                        List<String>.from(
                            ["common_camera".tr, "common_album".tr]),
                        onSelected: (index) {
                          if (index == 0) {
                            AppUtil.takePhoto((entity) {
                              controller.uploadIconimage(entity, 1);
                            });
                          } else {
                            AppUtil.selectPhotos(
                              (files) {
                                controller.uploadIconimage(files[0], 1);
                              },
                            );
                          }
                        },
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add),
                        Text(
                          'circle_add_head'.tr,
                          style: TextStyle(fontSize: 24.rpx),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : GestureDetector(
              onTap: () {
                AppUtil.showActionSheet(
                  List<String>.from(["common_camera".tr, "common_album".tr]),
                  onSelected: (index) {
                    if (index == 0) {
                      AppUtil.takePhoto((entity) {
                        controller.uploadIconimage(entity, 1);
                      });
                    } else {
                      AppUtil.selectPhotos(
                        (files) {
                          controller.uploadIconimage(files[0], 1);
                        },
                      );
                    }
                  },
                );
              },
              child: controller.iconimage.value.toCircleCachedNetworkImage(
                width: 220.rpx,
                height: 220.rpx,
                radius: 10.rpx,
              ),
            ),
    );
  }

  Widget _selectBanner() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.rpx),
      alignment: Alignment.centerLeft,
      child: controller.bannerimage.value.isEmpty
          ? Row(
              children: [
                Container(
                  width: 220.rpx,
                  height: 220.rpx,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.subBg,
                    borderRadius: BorderRadius.circular(10.rpx),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      AppUtil.showActionSheet(
                        List<String>.from(
                            ["common_camera".tr, "common_album".tr]),
                        onSelected: (index) {
                          if (index == 0) {
                            AppUtil.takePhoto((entity) {
                              controller.uploadIconimage(
                                entity,
                                2,
                                width: 750,
                                height: 560,
                                ratioX: 4,
                                ratioY: 3,
                              );
                            });
                          } else {
                            AppUtil.selectPhotos(
                              (files) {
                                controller.uploadIconimage(
                                  files[0],
                                  2,
                                  width: 750,
                                  height: 560,
                                  ratioX: 4,
                                  ratioY: 3,
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add),
                        Text(
                          'circle_add_banner'.tr,
                          style: TextStyle(fontSize: 24.rpx),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : GestureDetector(
              onTap: () {
                AppUtil.showActionSheet(
                  List<String>.from(["common_camera".tr, "common_album".tr]),
                  onSelected: (index) {
                    if (index == 0) {
                      AppUtil.takePhoto((entity) {
                        controller.uploadIconimage(
                          entity,
                          2,
                          width: 750,
                          height: 560,
                          ratioX: 4,
                          ratioY: 3,
                        );
                      });
                    } else {
                      AppUtil.selectPhotos(
                        (files) {
                          controller.uploadIconimage(
                            files[0],
                            2,
                            width: 750,
                            height: 560,
                            ratioX: 4,
                            ratioY: 3,
                          );
                        },
                      );
                    }
                  },
                );
              },
              child: controller.bannerimage.value.toCircleCachedNetworkImage(
                width: 220.rpx,
                height: 220.rpx,
                radius: 10.rpx,
              ),
            ),
    );
  }

  Widget _inputView(String hint, {TextEditingController? controller}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.rpx),
      child: LoginInput(
        hintText: hint,
        controller: controller,
      ),
    );
  }

  Widget _descView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.rpx),
      child: TDTextarea(
        hintText: 'circle_enter_desc'.tr,
        controller: controller.descEditingController,
        maxLines: 4,
        minLines: 4,
        onChanged: (value) {},
        backgroundColor: AppColor.subBg,
        hintTextStyle: TextStyle(
          fontSize: 28.rpx,
          color: const Color(0xff999999),
        ),
        textStyle: TextStyle(fontSize: 28.rpx),
        decoration: BoxDecoration(
          color: const Color(0xffF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(10.rpx)),
        ),
      ),
    );
  }

  Widget _bottomView() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.rpx),
      color: Colors.white,
      child: TDButton(
        text: 'circle_create_circle'.tr,
        size: TDButtonSize.large,
        type: TDButtonType.fill,
        shape: TDButtonShape.rectangle,
        theme: TDButtonTheme.primary,
        onTap: () {
          controller.submit();
        },
      ),
    );
  }
}
