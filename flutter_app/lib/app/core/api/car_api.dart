import '../utils/dio/request.dart';

class CarApi {
  static Future<dynamic> carlist(Map<String, dynamic> params) async {
    return Request.get('/base/car/index', queryParameters: params);
  }
}
