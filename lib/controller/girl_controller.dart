import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:wanandroid/bean/girl.dart';
import 'package:wanandroid/http/api.dart';
import 'package:wanandroid/controller/base/base_refresh_controller.dart';
import 'package:wanandroid/http/http.dart';

class GirlController extends BaseRefreshController {
  final _girls = <Girl>[].obs;

  List<Girl> get girls => _girls;

  int _page = 1;


  void getGirls({bool refresh = false}) {
    Future future = Http.instance.get(Api.girlUrl(refresh ? 1 : ++_page));

    handleRequest(future, (value) {
      Map<String, dynamic> jsonMap = json.decode(value);
      int state = jsonMap["status"];
      _page = jsonMap["page"];

      //请求成功
      if (state == 100) {
        List<dynamic> list = jsonMap["data"];

        if (list.isNotEmpty) {
          List<Girl> data = [];
          for (var element in list) {
            data.add(Girl.fromJson(element));
          }

          if (refresh) {
            _girls.clear();
            _girls.addAll(data);
            refreshController.refreshCompleted();
          } else {
            _girls.addAll(data);
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
        //todo 这里是业务逻辑错误，后续添加具体的操作
        if (refresh) {
          refreshController.refreshFailed();
        } else {
          refreshController.loadFailed();
        }
      }
    }, failure: (error) {
      //todo 这里是网络请求出错，后续添加具体的操作
      if (refresh) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    }, done: () {});
  }
}
