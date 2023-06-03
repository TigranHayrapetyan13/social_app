// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      comments: json['comments'] as List<dynamic>,
      likes: json['likes'] as List<dynamic>,
      userImage: json['userImage'] as String?,
      userName: json['userName'] as String?,
      description: json['description'] as String,
      imagUrl: json['imagUrl'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'userImage': instance.userImage,
      'userName': instance.userName,
      'imagUrl': instance.imagUrl,
      'description': instance.description,
      'time': instance.time.toIso8601String(),
      'likes': instance.likes,
      'comments': instance.comments,
    };
