// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) => Repo(
      fullName: json['full_name'] as String,
      createdAt: json['created_at'] as String,
      watchersCount: json['watchers_count'] as int,
      stargazersCount: json['stargazers_count'] as int,
      forksCount: json['forks_count'] as int,
      htmlUrl: json['html_url'] as String,
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'created_at': instance.createdAt,
      'watchers_count': instance.watchersCount,
      'stargazers_count': instance.stargazersCount,
      'forks_count': instance.forksCount,
      'html_url': instance.htmlUrl,
      'owner': instance.owner.toJson(),
    };
