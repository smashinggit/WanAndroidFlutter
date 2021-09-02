import 'package:flutter/material.dart';
import 'package:wanandroid/pages/home/question_page.dart';
import 'package:wanandroid/pages/home/square_page.dart';

import 'home/recommend_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List _taps = ["问答", "推荐", "广场"];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 1, length: _taps.length, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _taps.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: _buildTopBar(context),
          body: TabBarView(
              controller: _tabController,
              children: [QuestionPage(), RecommendPage(), SquarePage()]),
        ));
  }

  /// 自定义顶部的标题栏
  /// 注意：需要使用 PreferredSizeWidget
  PreferredSizeWidget _buildTopBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size(double.infinity, 56),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Theme.of(context).primaryColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildTabItem(),
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 26,
                ),
              )
            ],
          ),
        ));
  }

  /// 顶部的Tab
  Widget _buildTabItem() {
    return TabBar(
      //isScrollable属性会使Tab居中
      isScrollable: true,
      controller: _tabController,
      indicator: const BoxDecoration(),
      labelStyle: const TextStyle(fontSize: 20, height: 2),
      unselectedLabelStyle: const TextStyle(
        fontSize: 15,
      ),
      tabs: _taps.map((e) => Tab(text: e)).toList(),
    );
  }
}
