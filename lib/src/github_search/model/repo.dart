import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'repo.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class Repo {
  final String fullName;
  final String createdAt;
  final int watchersCount;
  final int stargazersCount;
  final int forksCount;
  final String htmlUrl;
  final User owner;

  const Repo({
    required this.fullName,
    required this.createdAt,
    required this.watchersCount,
    required this.stargazersCount,
    required this.forksCount,
    required this.htmlUrl,
    required this.owner,
  });

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
