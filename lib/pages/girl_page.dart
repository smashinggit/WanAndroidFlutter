import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid/controller/girl_controller.dart';
import 'package:wanandroid/widgets/state_widget.dart';

class GirlPage extends GetView<GirlController> {
  GirlPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => GirlController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("妹纸"),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Obx(() {
      return RefreshWidget(
          controller: controller,
          refreshController: controller.refreshController,
          onRefresh: () {
            controller.getGirls(refresh: true);
          },
          onLoading: () {
            controller.getGirls();
          },
          onPressed: () {},
          child: GridView.builder(
              itemCount: controller.girls.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, //单个子Widget的水平最大宽度
                  mainAxisSpacing: 5.0, //垂直单个子Widget之间间距
                  crossAxisSpacing: 5.0, //水平单个子Widget之间间距
                  childAspectRatio: 0.56), //宽高比
              itemBuilder: (context, index) {
                return _getItemContainer(index);
              }));
    });
  }

  Widget _getItemContainer(int index) {
    return Card(
      child: CachedNetworkImage(
        imageUrl: controller.girls[index].url,
        fit: BoxFit.cover,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
    );
  }
}
