import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/controller/base/base_controller.dart';

/// 对 SmartRefresher 和 Controller 进行封装
class RefreshWidget<T extends BaseController> extends StatefulWidget {
  final T controller;
  final RefreshController refreshController;
  bool enablePullDown = true;
  bool enablePullUp = true;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final VoidCallback onPressed;
  final Widget child;

  RefreshWidget(
      {Key? key,
      bool? enablePullDown,
      bool? enablePullUp,
      required this.controller,
      required this.refreshController,
      required this.onRefresh,
      required this.onLoading,
      required this.onPressed,
      required this.child})
      : super(key: key) {
    this.enablePullDown = enablePullDown ?? true;
    this.enablePullUp = enablePullUp ?? true;
  }

  @override
  State<StatefulWidget> createState() {
    return _RefreshWidget();
  }
}

class _RefreshWidget extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.refreshController,
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoading,
      child: widget.child,
    );
  }
}

/// 对于页面状态的封装
class StateWidget<T extends BaseController> extends StatefulWidget {
  final T controller;
  final Widget child;
  final Widget? loadingDialog;
  final Widget? loadingPage;
  final Widget? failurePage;
  final Widget? emptyPage;

  const StateWidget(
      {Key? key,
      required this.controller,
      required this.child,
      this.loadingDialog,
      this.loadingPage,
      this.emptyPage,
      this.failurePage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StateWidgetState();
  }
}

class _StateWidgetState extends State<StateWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.loadState.value == LoadState.LOADING) {
        return widget.loadingPage ?? widget.child;
      } else if (widget.controller.loadState.value == LoadState.FAILURE) {
        return widget.failurePage ?? widget.child;
      } else if (widget.controller.loadState.value == LoadState.EMPTY) {
        return widget.emptyPage ?? widget.child;
      } else {
        return widget.child;
      }
    });
  }
}

/// 默认的加载页面
class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: const AlwaysStoppedAnimation(Colors.blue),
      ),
    );
  }
}

/// 默认的数据为空页面
class EmptyPage extends StatelessWidget {
  String tip = "数据为空!";
  final VoidCallback? onRetry;

  EmptyPage({Key? key, String? tip, this.onRetry}) : super(key: key) {
    if (tip != null) {
      this.tip = tip;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 100,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
              onPressed: () {
                if (onRetry != null) {
                  onRetry!();
                }
              },
              child: const Text(
                "点击重试",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 默认的加载失败页面
class FailurePage extends StatelessWidget {
  String tip = "加载失败！";
  VoidCallback? onRetry;

  FailurePage({Key? key, String? tip, this.onRetry}) : super(key: key) {
    if (tip != null) {
      this.tip = tip;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 100,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
              onPressed: () {
                if (onRetry != null) {
                  onRetry!();
                }
              },
              child: const Text(
                "点击重试",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
