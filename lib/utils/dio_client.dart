import 'package:dio/dio.dart';
import 'interceptpr.dart';

class DioClient {
  // 创建一个 dio 实例
  final Dio _dio = Dio(
    // 设置全局配置
    BaseOptions(
      baseUrl: 'https://reqres.in/api/',
      connectTimeout: 5000 as Duration,
      receiveTimeout: 3000 as Duration,
    ),
  );

  DioClient() {
    // 在 dio 实例中添加拦截器类
    _dio.interceptors.add(CustomInterceptor());
  }

  // 定义一个 get 方法
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    // 使用 dio 发送 get 请求，并返回响应
    return await _dio.get(endpoint, queryParameters: queryParameters);
  }

  // 定义一个 post 方法
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    // 使用 dio 发送 post 请求，并返回响应
    return await _dio.post(endpoint, data: data);
  }

  // 定义一个 delete 方法
  Future<Response> delete(String endpoint) async {
    // 使用 dio 发送 delete 请求，并返回响应
    return await _dio.delete(endpoint);
  }
}


/** 
 * 使用
 * 引入文件
 * final DioClient _dioClient = DioClient();
 * var response = await _dioClient.get()
 */