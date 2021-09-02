# 一、项目简介

此项目为学习 Flutter 做的一个简单的 WanAndroid 客户端



# 二、项目截图

![截图1](/pics/1.jpg)

![截图2](/pics/2.jpg)

![截图3](/pics/3.jpg)

![截图4](/pics/4.jpg)

![截图5](/pics/5.jpg)




# 三、需要注意的地方

## 3.1 GetX

[状态管理框架GetX](https://github.com/jonataslaw/getx)

GetX 是 Flutter 上的一个轻量且强大的解决方案：
1. 高性能的状态管理
2. 智能的依赖注入
3. 便捷的路由管理

目前，Flutter有几种状态管理器。但是，它们中的大多数都涉及到使用ChangeNotifier来更新widget，
这对于中大型应用的性能来说是一个很糟糕的方法。
你可以在Flutter的官方文档中查看到，ChangeNotifier应该使用1个或最多2个监听器，这使得它们实际上无法用于任何中等或大型应用。

刚从 Android 学习 Flutter 的同学，一开始对 Flutter 中的状态管理可能会一头雾水，强烈建议在了解
了 InheritedWidget 和 Provider 后，使用 GetX 库


## 3.2 Flutter 中的异步编程

[Flutter 最详细的异步总结](https://juejin.cn/post/6844904049288937486)


## 3.3 json_serializable 使用说明

1. 首先在 pubspec.yaml 添加如下依赖：
```
dependencies:
  json_annotation: ^4.1.0


dev_dependencies:
  build_runner: ^2.0.0
  json_serializable: ^5.0.0
```

2. 新建 model 类, 例如：
```
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(this.name, this.password);

  String name = "";
  String password = "";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

这里有几个地方需要注意：
- 在文件顶部添加 part 'user.g.dart'，此时会报错，先不用管
- 在需要转换的实体 dart 类 前加入 @JsonSerializable 注解，标识需要 json序列化处理
- fromJson()、toJson() 方法的写法是固定模式，按模板修改即可
- User.g.dart 和 文件名 需要保持一致，否则执行以下命令无效

> 如果对 fromJson()、toJson() 用法不了解的话，建议查看 [Json转Dart Model类](https://book.flutterchina.club/chapter11/json_model.html)

3. 在 Terminal 或者 windows 的命令行中, 切换到项目的根目录, 然后执行：

> flutter packages pub run build_runner build

执行成功后可以看到，在 user.dart 的同级目录中自动生成了 user.g.dart 文件




# 四、 项目中用到的开源框架

-[状态管理框架GetX](https://github.com/jonataslaw/getx)

-[网络请求框架 DIO](https://github.com/flutterchina/dio)

-[DIO的Cookie管家 dio_cookie_manager](https://github.com/flutterchina/dio/tree/master/plugins/cookie_manager)

-[Cookie持久化 CookieJar](https://github.com/flutterchina/cookie_jar)

-[数据持久化工具 shared_preferences ](https://pub.dev/packages/shared_preferences#-example-tab-)

-[图片加载框架 Cached network image](https://github.com/Baseflow/flutter_cached_network_image)

-[下拉刷新上拉加载框架 flutter_pulltorefresh](https://github.com/peng8350/flutter_pulltorefresh)

-[访问设备文件系统插件 PathProvider](https://pub.dev/packages/path_provider) 









