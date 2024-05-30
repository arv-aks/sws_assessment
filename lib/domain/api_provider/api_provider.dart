import 'package:dio/dio.dart';

class ApiProvider {
  static Dio getDio() {
    Dio dio = Dio(BaseOptions());

    return dio;
  }
}