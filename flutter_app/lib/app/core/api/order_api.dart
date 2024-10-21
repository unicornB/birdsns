import '../utils/dio/request.dart';

class OrderApi {
  static Future<dynamic> getOrderList(Map<String, dynamic> data) async {
    return Request.get('/order/order/index', queryParameters: data);
  }

  static Future<dynamic> getStatusList(Map<String, dynamic> data) async {
    return Request.get('/order/order/getStatusList', queryParameters: data);
  }
}
