import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

///{
///     "apkLink": "",
///     "audit": 1,
///     "author": "",
///     "canEdit": false,
///     "chapterId": 502,
///     "chapterName": "自助",
///     "collect": false,
///     "courseId": 13,
///     "desc": "",
///     "descMd": "",
///     "envelopePic": "",
///     "fresh": true,
///     "host": "",
///     "id": 19605,
///     "link": "https://juejin.cn/post/7001839784289108005",
///     "niceDate": "12小时前",
///     "niceShareDate": "12小时前",
///     "origin": "",
///     "prefix": "",
///     "projectLink": "",
///     "publishTime": 1630278342000,
///     "realSuperChapterId": 493,
///     "selfVisible": 0,
///     "shareDate": 1630278342000,
///     "shareUser": "RicardoMJiang",
///     "superChapterId": 494,
///     "superChapterName": "广场Tab",
///     "tags": [],
///     "title": "【知识点】HTTP协议8连问",
///     "type": 0,
///     "userId": 13971,
///     "visible": 1,
///     "zan": 0
/// }
///
///  首页文章列表
@JsonSerializable()
class Article {
  String? author;  //作者
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  int id;
  String link;
  String niceDate;
  String niceShareDate;
  int publishTime;
  int realSuperChapterId;
  int shareDate;
  String? shareUser;   //分享人
  int superChapterId;
  String superChapterName;
  String title;
  int type;
  int userId;
  int visible;
  int zan;
  List<Tag> tags;

  Article({
    required this.author,
    required this.chapterId,
    required this.chapterName,
    required this.collect,
    required this.courseId,
    required this.id,
    required this.link,
    required this.niceDate,
    required this.niceShareDate,
    required this.publishTime,
    required this.realSuperChapterId,
    required this.shareDate,
    required this.shareUser,
    required this.superChapterId,
    required this.superChapterName,
    required this.title,
    required this.type,
    required this.userId,
    required this.visible,
    required this.zan,
    required this.tags,
  });

  factory Article.fromJson(dynamic json) {
    return _$ArticleFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ArticleToJson(this);
  }
}

@JsonSerializable()
class Tag {
  String name;
  String url;

  Tag({required this.name, required this.url});

  factory Tag.fromJson(dynamic json) {
    return _$TagFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TagToJson(this);
  }
}
