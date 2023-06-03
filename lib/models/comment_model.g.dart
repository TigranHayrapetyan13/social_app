// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      comment: json['comment'] as String,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'comment': instance.comment,
      'time': instance.time.toIso8601String(),
    };
