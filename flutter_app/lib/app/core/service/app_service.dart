import 'package:get/get.dart';

class AppService extends GetxService {
  Future<AppService> init() async {
    print('$runtimeType delays 2 sec');
    await 2.delay();
    print('$runtimeType ready!');
    return this;
  }
}