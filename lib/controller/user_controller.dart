import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:wanandroid/common/global.dart';
import 'package:wanandroid/controller/base/base_controller.dart';
import 'package:wanandroid/http/api.dart';
import 'package:wanandroid/http/http.dart';

class UserController extends BaseController {
  //私有构造函数
  UserController._internal();

  //工厂构造函数
  factory UserController() => _instance;

  //保存单例
  static final UserController _instance = UserController._internal();

  static UserController get instance {
    return _instance;
  }

  var isLogin = false.obs;
  var userName = "".obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  void login() {
    showLoadingDialog();

    Map<String, String> params = {
      "username": userNameController.text,
      "password": passwordController.text
    };

    Future future = Http.instance.postForm(Api.login, params);
    handleRequest(future, (value) {
      Map<String, dynamic> jsonMap = json.decode(value);

      int errorCode = jsonMap["errorCode"];
      String errorMsg = jsonMap["errorMsg"];

      if (errorCode == 0) {
        toast("登录成功！");
        isLogin.value = true;
        userName.value = userNameController.text;
        Get.back();
      } else {
        isLogin.value = false;
        toast(errorMsg);
      }
    }, failure: (error) {
      isLogin.value = false;
      toast("$error");
      print("$error");
    }, done: () {
      Get.back();
    });
  }

  void register() {
    showLoadingDialog();

    Map<String, String> params = {
      "username": userNameController.text,
      "password": passwordController.text,
      "repassword": repasswordController.text
    };

    Future future = Http.instance.postForm(Api.register, params);
    handleRequest(future, (value) {
      Map<String, dynamic> jsonMap = json.decode(value);
      int errorCode = jsonMap["errorCode"];
      String errorMsg = jsonMap["errorMsg"];

      if (errorCode == 0) {
        toast("注册成功！");
        Get.back();
      } else {
        toast(errorMsg);
      }
    }, failure: (error) {
      toast("$error");
      print("$error");
    }, done: () {
      Get.back();
    });
  }

  void logout() {
    showLoadingDialog();

    Future future = Http.instance.get(Api.logout);
    handleRequest(future, (value) {
      Map<String, dynamic> jsonMap = json.decode(value);
      int errorCode = jsonMap["errorCode"];
      String errorMsg = jsonMap["errorMsg"];
      if (errorCode == 0) {
        toast("退出成功！");
        isLogin.value = false;
      } else {
        toast(errorMsg);
      }
    }, failure: (error) {
      toast("$error");
      print("$error");
    }, done: () {
      Get.back();
    });
  }

}
