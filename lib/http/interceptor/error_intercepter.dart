import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/http/http.dart';

/// 错误处理拦截器
/// 把 DioError 转换自己定义的异常
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var dioException = DioException.create(err);
    err.error = dioException;

    debugPrint("DioError===: ${dioException.toString()}");
    return super.onError(err, handler);
  }
}
