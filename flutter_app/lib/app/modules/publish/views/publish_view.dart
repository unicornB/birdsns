import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/components/login_input/login_input.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../../../core/components/close_button/close_button.dart';
import '../../../core/entity/source_entity.dart';
import '../controllers/publish_controller.dart';

class PublishView extends GetView<PublishController> {
  const PublishView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: Text('publish_title'.tr),
          leading: IconButton(
            icon: const Icon(AppIcon.close),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          actions: [
            Obx(() {
              bool disabled = controller.content.value.isEmpty &&
                  controller.images.value.isEmpty;
              return TDButton(
                text: '发布',
                size: TDButtonSize.extraSmall,
                type: TDButtonType.fill,
                shape: TDButtonShape.round,
                theme: TDButtonTheme.primary,
                disabled: disabled,
                textStyle: TextStyle(fontSize: 24.rpx),
                disableTextStyle: TextStyle(fontSize: 24.rpx),
                onTap: () => controller.save(),
              );
            }),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Obx(() => _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      height: Get.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1,
                  color: AppColor.line,
                ),
                TDCell(
                  arrow: true,
                  title: controller.circle.value.title != null
                      ? '${controller.circle.value.title}'
                      : '选择圈子',
                  note: '合适的话题，会有更多关注',
                  leftIcon: AppIcon.topic,
                  style: TDCellStyle(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.white,
                    leftIconColor: AppColor.primaryColor,
                    titleStyle: const TextStyle(
                      color: AppColor.primaryColor,
                    ),
                    noteStyle: const TextStyle(
                      color: AppColor.subTitle,
                    ),
                  ),
                  onClick: (cell) {
                    Get.toNamed("${Routes.CIRCLE}?from=publish");
                  },
                ),
                _inputView(),
                ..._publistViews(),
                Container(
                  color: AppColor.white,
                  height: 10,
                ),
              ],
            ).paddingOnly(bottom: 60),
          ),
          Positioned(
            bottom: controller.showRecord.value
                ? 460.rpx
                : controller.showEmoji.value
                    ? 600.rpx
                    : 0,
            left: 0,
            right: 0,
            child: _publishButton(),
          ),
          controller.showRecord.value
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _recordView(),
                )
              : Container(),
          controller.showEmoji.value
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _emojiView(),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _inputView() {
    return Container(
      color: Get.isDarkMode ? Colors.black : AppColor.white,
      child: TDTextarea(
        hintText: '分享你的想法...',
        maxLines: 4,
        minLines: 4,
        onChanged: (value) {
          controller.content.value = value;
        },
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: AppColor.white,
        textInputBackgroundColor: AppColor.white,
        padding: const EdgeInsets.all(20),
        bordered: false,
        controller: controller.contentEditingController,
      ),
    );
  }

  Widget _publishButton() {
    const Color color = AppColor.primaryColor;
    Color disableColor = AppColor.primaryColor.withAlpha(900);
    final double size = 50.rpx;
    return Container(
      padding: EdgeInsets.only(
        bottom: controller.showRecord.value ? 0 : AppUtil.getSafeAreaHeight(),
      ),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColor.subBg,
            width: 2.rpx,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            color: (controller.type.value == "text" ||
                    controller.type.value == "image")
                ? color
                : disableColor,
            onPressed: () {
              if (controller.type.value == "text" ||
                  controller.type.value == "image") {
                //controller.type.value = "image";
                controller.selectImage();
              }
            },
            icon: Icon(
              AppIcon.pubImage,
              size: size,
            ),
          ),
          IconButton(
            onPressed: () {
              if (controller.type.value == "text" ||
                  controller.type.value == "video") {
                controller.selectVideo();
              }
            },
            icon: Icon(
              AppIcon.pubVideo,
              size: size,
            ),
            color: (controller.type.value == "text" ||
                    controller.type.value == "video")
                ? color
                : disableColor,
          ),
          IconButton(
            onPressed: () {
              if ((controller.type.value == "text" ||
                      controller.type.value == "audio") &&
                  controller.fileUrl.value == "") {
                //controller.recordAudio();
                controller.showRecord.value = !controller.showRecord.value;
              }
            },
            icon: Icon(
              AppIcon.pubAudio,
              size: size,
            ),
            color: ((controller.type.value == "text" ||
                        controller.type.value == "audio") &&
                    controller.fileUrl.value == "")
                ? color
                : disableColor,
          ),
          IconButton(
            onPressed: () {
              if (controller.type.value == "text") {
                controller.onPollTap();
              }
            },
            icon: Icon(
              AppIcon.pubPoll,
              size: size,
            ),
            color: (controller.type.value == "text") ? color : disableColor,
          ),
          IconButton(
            onPressed: () {
              controller.showEmoji.value = !controller.showEmoji.value;
            },
            icon: Icon(
              AppIcon.pubEmoj,
              size: size,
            ),
            color: color,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              AppIcon.pubLink,
              size: size,
            ),
            color: (controller.type.value == "text" ||
                    controller.type.value == "link")
                ? color
                : disableColor,
          ),
        ],
      ),
    );
  }

  List<Widget> _publistViews() {
    List<Widget> list = [];
    if (controller.type.value == "image") {
      list.add(_imageListView());
    } else if (controller.type.value == "video") {
      list.add(_videoView());
    } else if (controller.type.value == "audio" &&
        controller.fileUrl.value.isNotEmpty) {
      list.add(_audioPlayerView());
    } else if (controller.type.value == "poll" &&
        controller.pollData.value.isNotEmpty) {
      list.add(_pollView());
    }
    return list;
  }

  Widget _imageListView() {
    List<Widget> children = [];
    for (int i = 0; i < controller.images.value.length; i++) {
      children.add(_imageItem(controller.images.value[i], i));
    }
    return Container(
      color: Get.isDarkMode ? Colors.black : AppColor.white,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: children,
      ),
    );
  }

  Widget _imageItem(String url, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            List<SourceEntity> sourceEntities = [];
            for (int i = 0; i < controller.images.value.length; i++) {
              sourceEntities.add(SourceEntity(index, "image",
                  AppUtil.getFileUrl(controller.images.value[i])));
            }
            AppUtil.openGallery(sourceEntities, index);
          },
          child: url.toCircleCachedNetworkImage(
            radius: 10,
            width: (Get.width - 40) / 3,
            height: (Get.width - 40) / 3,
          ),
        ),
        Positioned(
          right: 3,
          top: 3,
          child: CustomCloseButton(
            onPressed: () {
              controller.images.value.remove(url);
              controller.images.refresh();
            },
          ),
        )
      ],
    );
  }

  Widget _videoView() {
    var imageUrl = "${controller.fileUrl.value}.jpg";
    return GestureDetector(
      onTap: () {
        List<SourceEntity> sourceEntities = [];
        sourceEntities.add(SourceEntity(
            0, "video", AppUtil.getFileUrl(controller.fileUrl.value)));
        AppUtil.openGallery(sourceEntities, 0);
      },
      child: Container(
        width: 300.rpx,
        height: 300.rpx,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20.rpx),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            imageUrl.toCircleCachedNetworkImage(
              radius: 20.rpx,
              width: 300.rpx,
              height: 300.rpx,
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                AppIcon.play,
                size: 80.rpx,
                color: Colors.white,
              ),
            ),
            Positioned(
              right: 3,
              top: 3,
              child: CustomCloseButton(
                onPressed: () {
                  controller.fileUrl.value = "";
                  controller.type.value = "text";
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recordView() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      height: 460.rpx,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${controller.recordTime.value} s",
            style: TextStyle(fontSize: 30.rpx),
          ),
          SizedBox(height: 20.rpx),
          GestureDetector(
            onTap: () {
              controller.handleRecord();
            },
            child: Container(
              height: 100.rpx,
              width: 100.rpx,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(50.rpx),
              ),
              child: controller.recording.value
                  ? Icon(
                      AppIcon.microphoneStop,
                      color: Colors.white,
                      size: 40.rpx,
                    )
                  : Icon(
                      AppIcon.microphone,
                      color: Colors.white,
                      size: 50.rpx,
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _audioPlayerView() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(20.rpx),
          child: controller.fileUrl.value.toAudioPlayer(),
        ),
        Positioned(
          right: 3,
          top: 3,
          child: CustomCloseButton(
            onPressed: () {
              controller.fileUrl.value = "";
              controller.type.value = "text";
            },
          ),
        )
      ],
    );
  }

  Widget _emojiView() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      height: 600.rpx,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {},
        onBackspacePressed: () {},
        textEditingController: controller
            .contentEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
        config: Config(
          height: 600.rpx,
          checkPlatformCompatibility: true,
          emojiViewConfig: EmojiViewConfig(
            emojiSizeMax: 28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.20
                    : 1.0),
          ),
          viewOrderConfig: const ViewOrderConfig(
            top: EmojiPickerItem.categoryBar,
            middle: EmojiPickerItem.emojiView,
            bottom: EmojiPickerItem.searchBar,
          ),
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: const CategoryViewConfig(),
          bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
          searchViewConfig: const SearchViewConfig(),
        ),
      ),
    );
  }

  Widget _pollView() {
    List<Widget> options = [];
    for (int i = 0; i < controller.pollData.value.length; i++) {
      options.add(_pollOptionItem(i));
    }
    return Container(
      padding: EdgeInsets.all(20.rpx),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20.rpx),
            decoration: BoxDecoration(
              color: AppColor.subBg,
              borderRadius: BorderRadius.circular(20.rpx),
            ),
            child: Column(
              children: [
                ...options,
                if (controller.pollData.value.length < 4)
                  TextButton(
                    onPressed: () {
                      controller.pollData.value.add({"title": ""});
                      controller.pollData.refresh();
                    },
                    child: const Text(
                      "添加选项",
                      style: TextStyle(color: AppColor.primaryColor),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CustomCloseButton(
              onPressed: () {
                controller.type.value = "text";
                controller.pollData.value = [];
                controller.pollData.refresh();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _pollOptionItem(int index) {
    return Container(
      margin: EdgeInsets.only(top: 10.rpx),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              child: LoginInput(
                hintText: "选项${index + 1} (20字以内)",
                onChanged: (value) {
                  controller.pollData.value[index]["title"] = value;
                },
              ),
            ),
          ),
          if (controller.pollData.value.length > 2)
            GestureDetector(
              onTap: () {
                controller.pollData.value.removeAt(index);
                controller.pollData.refresh();
              },
              child: Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
                size: 50.rpx,
              ),
            ),
          SizedBox(width: 20.rpx),
        ],
      ),
    );
  }
}
