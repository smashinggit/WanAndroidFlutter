// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      author: json['author'] as String,
      chapterId: json['chapterId'] as int,
      chapterName: json['chapterName'] as String,
      collect: json['collect'] as bool,
      courseId: json['courseId'] as int,
      id: json['id'] as int,
      link: json['link'] as String,
      niceDate: json['niceDate'] as String,
      niceShareDate: json['niceShareDate'] as String,
      publishTime: json['publishTime'] as int,
      realSuperChapterId: json['realSuperChapterId'] as int,
      shareDate: json['shareDate'] as int,
      shareUser: json['shareUser'] as String,
      superChapterId: json['superChapterId'] as int,
      superChapterName: json['superChapterName'] as String,
      title: json['title'] as String,
      type: json['type'] as int,
      userId: json['userId'] as int,
      visible: json['visible'] as int,
      zan: json['zan'] as int,
      tags:
          (json['tags'] as List<dynamic>).map((e) => Tag.fromJson(e)).toList(),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'niceShareDate': instance.niceShareDate,
      'publishTime': instance.publishTime,
      'realSuperChapterId': instance.realSuperChapterId,
      'shareDate': instance.shareDate,
      'shareUser': instance.shareUser,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
      'tags': instance.tags,
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
