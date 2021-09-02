import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class BaseController extends GetxController {
  Rx<LoadState> loadState = LoadState.DONE.obs;

  /// 统一对网络请求进行处理
  /// 主要是处理网络请求中的错误
  /// 具体的业务逻辑处理下沉到各个具体的 Controller 处理
  handleRequest(Future<dynamic> future, Success success,
      {Failure? failure, Done? done}) {
    future.then((value) {
      success(value.toString());
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      if (failure != null) {
        failure(error);
      }
    }).whenComplete(() {
      if (done != null) {
        done();
      }
    });
  }

  void showLoadingDialog() {
    Get.dialog(SizedBox(
      width: double.infinity,
      height: 80,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
        ),
      ),
    ));
  }

  void toast(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.BOTTOM);
  }
}

typedef Success = Function(dynamic value);
typedef Failure = Function(dynamic value);
typedef Done = Function();

enum LoadState { LOADING, SUCCESS, FAILURE, EMPTY, DONE }
