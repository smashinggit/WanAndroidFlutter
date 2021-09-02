// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroid/http/proxy.dart';

class Http {
  static final Http _instance = Http._internal();

  static Http get instance {
    return _instance;
  }

  //工厂构造方法，每次返回同一个对象
  factory Http() {
    return _instance;
  }

  //实际构造,被私有化,避免被外部访问
  Http._internal() {
    HttpOverrides.global =
        MyHttpOverrides(); //解决加载图片时 CERTIFICATE_VERIFY_FAILED: unable to get local issuer certificate Error

    _dio.options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {"version": "1.0.0"},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain);

    //禁用HTTPS证书校验
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      if (PROXY_ENABLE) {
        //在调试模式下需要抓包调试，所以我们使用代理
        client.findProxy = (uri) {
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
      }
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  /// 在程序启动时调用此方法
  void init() async {
    // PersistCookieJar 将cookie保存在文件中
    Directory tempDir = await getTemporaryDirectory();
    PersistCookieJar _cookieJar =
        PersistCookieJar(storage: FileStorage(tempDir.path));
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  final Dio _dio = Dio();
  final CancelToken _cancelToken = CancelToken();
  final String baseUrl = "https://www.wanandroid.com";

  Future get(String url,
      {Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      Response<dynamic> response = await _dio.get(url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioError catch (e) {
      print("DioError $e");
      throw DioException.create(e);
    }
  }

  Future post(String url,
      {Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      Response<dynamic> response = await _dio.post(url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioError catch (e) {
      throw DioException.create(e);
    }
  }

  Future postForm(String url, Map<String, dynamic> params,
      {Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      Response<dynamic> response = await _dio.post(url,
          data: FormData.fromMap(params),
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      print("response $response");
      return response;
    } on DioError catch (e) {
      throw DioException.create(e);
    }
  }

  Future put(String url,
      {Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      Response<dynamic> response = await _dio.put(url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioError catch (e) {
      throw DioException.create(e);
    }
  }

  Future patch(String url,
      {data,
      Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      Response<dynamic> response = await _dio.patch(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioError catch (e) {
      throw DioException.create(e);
    }
  }

  Future delete(String url,
      {data,
      Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      Response<dynamic> response = await _dio.delete(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw DioException.create(e);
    }
  }

  /// 取消请求
  /// 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消
  void cancel({CancelToken? token}) {
    token ?? _cancelToken.cancel("canceled");
  }

  /// 增加认证header
  Map<String, dynamic> getAuthorizationHeader(String accessToken) {
    return {
      'Authorization': 'Bearer $accessToken',
    };
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// 处理 Dio异常
class DioException {
  final int code;
  final String message;

  DioException(this.code, this.message);

  @override
  String toString() {
    return "$code $message";
  }

  factory DioException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        {
          return BadRequestException(-1, "连接超时");
        }
      case DioErrorType.sendTimeout:
        {
          return BadRequestException(-1, "请求超时");
        }
      case DioErrorType.receiveTimeout:
        {
          return BadRequestException(-1, "响应超时");
        }
      case DioErrorType.cancel:
        {
          return BadRequestException(-1, "请求取消");
        }
      case DioErrorType.other:
        {
          return BadRequestException(-1, "未知错误");
        }

      case DioErrorType.response:
        {
          var errCode = error.response?.statusCode;
          var errMessage = error.response?.statusMessage;

          switch (errCode) {
            case 400:
              {
                return UnauthorisedException(errCode!, "请求语法错误");
              }
            case 401:
              {
                return UnauthorisedException(errCode!, "没有权限");
              }
            case 403:
              {
                return UnauthorisedException(errCode!, "服务器拒绝执行");
              }
            case 404:
              {
                return UnauthorisedException(errCode!, "无法连接服务器");
              }
            case 405:
              {
                return UnauthorisedException(errCode!, "请求方法被禁止");
              }
            case 500:
              {
                return UnauthorisedException(errCode!, "服务器内部错误");
              }
            case 502:
              {
                return UnauthorisedException(errCode!, "无效的请求");
              }
            case 503:
              {
                return UnauthorisedException(errCode!, "服务器未响应");
              }
            case 505:
              {
                return UnauthorisedException(errCode!, "不支持HTTP协议请求");
              }
            default:
              {
                return DioException(errCode ?? -1, errMessage ?? "未知错误");
              }
          }
        }

      default:
        {
          return DioException(-1, error.message);
        }
    }
  }
}

/// 请求错误
class BadRequestException extends DioException {
  BadRequestException(int code, String message) : super(code, message);
}

/// 认证错误
class UnauthorisedException extends DioException {
  UnauthorisedException(int code, String message) : super(code, message);
}
