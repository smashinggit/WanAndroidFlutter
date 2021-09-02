import 'package:json_annotation/json_annotation.dart';

part 'girl.g.dart';

@JsonSerializable()
class Girl {
  // int _id;
  // String author;
  // String createAt;
  // String desc;
  // List<String> images;
  // int likeCounts;
  // String publishedAt;
  String url;

  // String views;

  Girl({required this.url});

  factory Girl.fromJson(dynamic json) {
    return _$GirlFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GirlToJson(this);
  }
}
