import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class DioHelper {
  static Dio? dio;
  static var cookieJar;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
    cookieJar = CookieJar();
    dio!.interceptors
      ..add(LogInterceptor())
      ..add(CookieManager(cookieJar));
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) async {
    // print(cookieJar.loadForRequest(Uri.parse(url)));
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}
