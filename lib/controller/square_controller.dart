import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:wanandroid/bean/article.dart';
import 'package:wanandroid/controller/base/base_refresh_controller.dart';
import 'package:wanandroid/http/api.dart';
import 'package:wanandroid/http/http.dart';

class SquareController extends BaseRefreshController {
  final _articles = <Article>[].obs;

  List<Article> get articles => _articles;

  int _page = 0;


  void getSquare({bool refresh = false}) {
    Future future = Http.instance.get(Api.square(refresh ? 0 : ++_page));

    handleRequest(future, (value) {
      refreshController.refreshCompleted();

      Map<String, dynamic> jsonMap = json.decode(value);

      Map<String, dynamic> dataMap = jsonMap["data"];
      List<dynamic> dataList = dataMap["datas"];
      _page = dataMap["curPage"] - 1; //这个参数比实际的页码多了1，所以此处-1

      int errorCode = jsonMap["errorCode"];
      String errorMsg = jsonMap["errorMsg"];

      if (errorCode == 0) {
        if (dataList.isNotEmpty) {
          List<Article> data = [];
          for (var element in dataList) {
            data.add(Article.fromJson(element));
          }
          if (refresh) {
            _articles.clear();
            _articles.addAll(data);
            refreshController.refreshCompleted();
          } else {
            _articles.addAll(data);
            refreshController.loadComplete();
          }
        } else {
          //没有更多了
          if (refresh) {
            refreshController.refreshFailed();
          } else {
            refreshController.loadFailed();
          }
        }
      } else {
        //业务错误
        if (refresh) {
          refreshController.refreshFailed();
        } else {
          refreshController.loadFailed();
        }
      }
    }, failure: (error) {
      print("getSquare error: $error");
      // 网络请求出错
      if (refresh) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    });
  }
}
