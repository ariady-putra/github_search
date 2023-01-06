// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issues _$IssuesFromJson(Map<String, dynamic> json) => Issues(
      title: json['title'] as String,
      updatedAt: json['updated_at'] as String,
      state: json['state'] as String,
      htmlUrl: json['html_url'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IssuesToJson(Issues instance) => <String, dynamic>{
      'title': instance.title,
      'updated_at': instance.updatedAt,
      'state': instance.state,
      'html_url': instance.htmlUrl,
      'user': instance.user.toJson(),
    };
