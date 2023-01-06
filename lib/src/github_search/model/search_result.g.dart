// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult<T> _$SearchResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    SearchResult<T>(
      totalCount: json['total_count'] as int?,
      incompleteResults: json['incomplete_results'] as bool?,
      items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SearchResultToJson<T>(
  SearchResult<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('total_count', instance.totalCount);
  writeNotNull('incomplete_results', instance.incompleteResults);
  writeNotNull('items', instance.items?.map(toJsonT).toList());
  writeNotNull('message', instance.message);
  return val;
}
