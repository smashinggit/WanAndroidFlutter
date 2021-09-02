import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid/controller/user_controller.dart';
import 'package:wanandroid/pages/login/register_page.dart';
import 'package:wanandroid/widgets/state_widget.dart';

class LoginPage extends GetView<UserController> {
  LoginPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => UserController.instance);
  }

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
              style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
              onPressed: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: const Text("用户登录"),
        ),
        body: StateWidget(
            controller: controller,
            loadingPage: LoadingPage(),
            emptyPage: EmptyPage(),
            failurePage: FailurePage(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: controller.userNameController,
                      validator: (v) {
                        if (v != null && v.trim().length > 6) {
                          return null; //代表校验通过
                        } else {
                          return "用户名不能少于6位";
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "用户名",
                          hintText: "请输入用户名",
                          prefixIcon: Icon(Icons.person)),
                    ),
                    TextFormField(
                      autofocus: true,
                      obscureText: true,
                      controller: controller.passwordController,
                      validator: (v) {
                        if (v != null && v.trim().length > 6) {
                          return null; //代表校验通过
                        } else {
                          return "密码不能少于6位";
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "密码",
                          hintText: "请输入密码",
                          prefixIcon: Icon(Icons.lock)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "登录",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              //在这里不能通过此方式获取FormState，context不对
                              //print(Form.of(context));

                              // 通过_formKey.currentState 获取FormState后，
                              // 调用validate()方法校验用户名密码是否合法，校验
                              // 通过后再提交数据。

                              if ((_formKey.currentState as FormState)
                                  .validate()) {
                                //验证通过提交数据
                                controller.login();
                              } else {
                                //todo
                              }
                            },
                          )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(RegisterPage());
                            },
                            child: const Text(
                              "没有账号？去注册",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
