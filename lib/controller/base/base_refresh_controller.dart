import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'base_controller.dart';

abstract class BaseRefreshController extends BaseController {
  late final RefreshController _refreshController;

  RefreshController get refreshController => _refreshController;

  @override
  void onInit() {
    super.onInit();
    _refreshController = RefreshController(initialRefresh: true);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
