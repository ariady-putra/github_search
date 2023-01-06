import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'issues.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class Issues {
  final String title;
  final String updatedAt;
  final String state;
  final String htmlUrl;
  final User user;

  const Issues({
    required this.title,
    required this.updatedAt,
    required this.state,
    required this.htmlUrl,
    required this.user,
  });

  factory Issues.fromJson(Map<String, dynamic> json) => _$IssuesFromJson(json);

  Map<String, dynamic> toJson() => _$IssuesToJson(this);
}
