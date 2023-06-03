import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class Comment {
  final String imageUrl;
  final String name;
  final String comment;
  final DateTime time;

  Comment(
      {required this.comment,
      required this.imageUrl,
      required this.name,
      required this.time});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
