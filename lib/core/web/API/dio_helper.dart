import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

//---------- Dio --> Initialization ------------
  static init() {
    BaseOptions options = BaseOptions(
      //عنوان api من ال back-end
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  //----------------------------Post Data----------------------------------------
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

//----------------------------Get Data----------------------------------------
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    //لما اعوز احط headers
    //وبيلغوا اللي متعرفين فوق في dio

    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}
