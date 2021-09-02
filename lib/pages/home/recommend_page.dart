import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid/bean/article.dart';
import 'package:wanandroid/controller/recommend_controller.dart';
import 'package:wanandroid/pages/webview/webview_page.dart';
import 'package:wanandroid/widgets/rectangle_background_text.dart';
import 'package:wanandroid/widgets/state_widget.dart';

class RecommendPage extends GetView<RecommendController> {
  RecommendPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => RecommendController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => RefreshWidget(
        controller: controller,
        refreshController: controller.refreshController,
        onRefresh: () {
          controller.getRecommend(refresh: true);
        },
        onLoading: () {
          controller.getRecommend();
        },
        onPressed: () {},
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => _getItemContainer(context, index),
                    childCount: controller.articles.length),
                itemExtent: 140),
          ],
        )));
  }

  Widget _getItemContainer(BuildContext context, int index) {
    return Card(
        elevation: 3,
        child: GestureDetector(
          onTap: () {
            Article article = controller.articles[index];
            Get.to(WebViewPage(),
                arguments: {"title": article.title, "url": article.link});
          },
          child: Container(
            height: 140,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Text(controller.articles[index].niceDate),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:
                                _getTags(controller.articles[index]).toList(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        controller.articles[index].title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Text(_getAuthorLab(controller.articles[index])),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                        const Padding(padding: EdgeInsets.all(2)),
                        Text("${controller.articles[index].zan}"),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  String _getAuthorLab(Article article) {
    String authorLab = "";
    if (article.author != null && article.author != "") {
      authorLab = "作者：${article.author!}";
    } else if (article.shareUser != null && article.shareUser != "") {
      authorLab = "分享者：${article.shareUser!}";
    } else {
      authorLab = "作者：匿名";
    }
    return authorLab;
  }

  List<Widget> _getTags(Article article) {
    List<Tag> tags = article.tags;
    List<Widget> list = [];
    if (tags.isNotEmpty) {
      for (var element in tags) {
        list.add(RectangleBackgroundText(tag: element.name));
      }
    }
    return list;
  }
}
