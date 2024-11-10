import 'package:flutter_app/app/core/api/circle.dart';
import 'package:flutter_app/app/core/models/circle.m.dart';
import 'package:get/get.dart';

class CirclePageController extends GetxController {
  final recList = <Circle>[].obs;
  final mylist = <Circle>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyCircleList();
    getRecList();
  }

  Future<void> getRecList() async {
    var res = await CircleApi.getRecList();
    recList.value = List<Circle>.from(
        res['data'].map((item) => Circle.fromJson(item)).toList());
    recList.refresh();
  }

  Future<void> getMyCircleList() async {
    var res = await CircleApi.getMyList();
    if (res['data'] != null) {
      mylist.value = List<Circle>.from(
          res['data'].map((item) => Circle.fromJson(item)).toList());
      mylist.refresh();
    }
  }
}
