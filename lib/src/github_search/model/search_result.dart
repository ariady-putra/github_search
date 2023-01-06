import 'package:json_annotation/json_annotation.dart';

part 'search_result.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  genericArgumentFactories: true,
  includeIfNull: false,
)
class SearchResult<T> {
  // on success
  final int? totalCount;
  final bool? incompleteResults;
  final List<T>? items;

  // on error
  final String? message;

  const SearchResult({
    this.totalCount,
    this.incompleteResults,
    this.items,
    this.message,
  });

  factory SearchResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$SearchResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$SearchResultToJson(this, toJsonT);
}
