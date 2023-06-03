import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post {
  final List comments;
  final String? userImage;
  final String? userName;
  final String imagUrl;
  final String description;
  final DateTime time;
  final List likes;

  Post(
      {required this.likes,
      required this.comments,
      required this.userImage,
      required this.userName,
      required this.description,
      required this.imagUrl,
      required this.time});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
