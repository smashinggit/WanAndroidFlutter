import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/controller/user_controller.dart';
import 'package:wanandroid/pages/girl_page.dart';
import 'package:wanandroid/pages/home_page.dart';
import 'package:wanandroid/pages/mine_page.dart';

import 'common/global.dart';
import 'http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const MaterialClassicHeader(),
      footerBuilder: () =>
          const ClassicFooter(loadStyle: LoadStyle.ShowWhenLoading),
      child: GetMaterialApp(
        title: 'WanAndroid',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainRoute(),
      ),
    );
  }
}

class MainRoute extends StatefulWidget {
  const MainRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainRouteState();
  }
}

class _MainRouteState extends State<MainRoute> {
  DateTime? _lastPressedAt;

  final List _routes = [const HomePage(), GirlPage(), MinePage()];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Http.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: _routes[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
              BottomNavigationBarItem(icon: Icon(Icons.face), label: "妹纸"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的")
            ],
            currentIndex: _currentIndex,
            fixedColor: Colors.blue,
            onTap: _onTab,
          ),
        ),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt ?? DateTime.now()) >
                  const Duration(seconds: 1)) {
            _lastPressedAt = DateTime.now();
            //两次点击间隔超过1秒则重新计时
            return false;
          }
          return true;
        });
  }

  // 底部菜单被点击
  void _onTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
