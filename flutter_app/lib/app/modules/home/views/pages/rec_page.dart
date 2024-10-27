import 'package:flutter/material.dart';

import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../controllers/rec_page_controller.dart';

class RecPage extends GetView<RecPageController> {
  const RecPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            children: [
              bannerView(controller),
              SizedBox(
                height: 20.sp,
              ),
              menuView(controller),
              ...listviews(),
              Container(
                alignment: Alignment.center,
                child: const TDLoading(
                  size: TDLoadingSize.small,
                  icon: TDLoadingIcon.circle,
                  text: '加载中…',
                  axis: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bannerView(RecPageController controller) {
    return SizedBox(
      height: 350.sp,
      child: controller.bannerList.value.isNotEmpty
          ? Swiper(
              autoplay: true,
              itemCount: controller.bannerList.value.length,
              loop: true,
              duration: 600,
              pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: TDSwiperPagination.dotsBar,
              ),
              itemBuilder: (BuildContext context, int index) {
                return TDImage(
                  imgUrl: controller.bannerList.value[index].image!,
                );
              },
            )
          : Container(),
    );
  }

  Widget menuView(RecPageController controller) {
    return GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: 10.sp,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: controller.menuList.value
          .map(
            (item) => Column(
              children: [
                item.iconimage!
                    .toCachedNetworkImageRemote(width: 110.sp, height: 110.sp),
                Text(
                  item.name!,
                  style: TextStyle(fontSize: 26.sp),
                )
              ],
            ),
          )
          .toList(),
    );
  }

  List<ListTile> listviews() {
    List<ListTile> list = [];
    for (int i = 0; i < 20; i++) {
      list.add(ListTile(
        title: Text("Item $i"),
      ));
    }
    return list;
  }
}
