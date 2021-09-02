import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid/common/global.dart';
import 'package:wanandroid/controller/user_controller.dart';
import 'package:wanandroid/widgets/circle_image.dart';

import 'login/login_page.dart';

class MinePage extends GetView<UserController> {
  MinePage({Key? key}) : super(key: key) {
    Get.lazyPut(() => UserController.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: 220,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      child:
                          CircleImage(path: "assets/images/pic.jpg", width: 80),
                      top: 100,
                      left: 20,
                    ),
                    Positioned(
                      child:
                          CircleImage(path: "assets/images/pic.jpg", width: 80),
                      top: 100,
                      left: 20,
                    ),
                    if (controller.isLogin.value)
                      Positioned(
                        child: Text(
                          "${controller.userName}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                        top: 110,
                        left: 110,
                      ),
                    if (controller.isLogin.value)
                      const Positioned(
                        child: Text(
                          "积分：2000",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        top: 150,
                        left: 110,
                      ),
                    if (!controller.isLogin.value)
                      Positioned(
                        top: 120,
                        left: 110,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(LoginPage());
                            },
                            child: const Text("登录",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      ),
                    const Positioned(
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      top: 30,
                      right: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          "我的收藏",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        color: Colors.grey.shade300,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.share,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          "我的分享",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        color: Colors.grey.shade300,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          "积分排行",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        color: Colors.grey.shade300,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                    if (controller.isLogin.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  controller.logout();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "退出登录",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
