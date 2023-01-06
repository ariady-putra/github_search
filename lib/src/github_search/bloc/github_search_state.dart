part of 'github_search_bloc.dart';

abstract class GithubSearchState extends Equatable {
  final String search;

  const GithubSearchState({this.search = ''});

  @override
  List<Object> get props => [search];
}

class GithubSearchStateEmpty extends GithubSearchState {}

class GithubSearchStateLoading extends GithubSearchState {
  const GithubSearchStateLoading({required super.search});
}

class GithubSearchStateSuccess extends GithubSearchState {
  final List items;
  final int pages;

  const GithubSearchStateSuccess({
    required super.search,
    required this.items,
    required this.pages,
  });

  @override
  String toString() =>
      'GithubSearchStateSuccess { items_count: ${items.length} }';

  @override
  List<Object> get props => [search, items];
}

class GithubSearchStateError extends GithubSearchState {
  final SearchResult? result;

  const GithubSearchStateError({
    required super.search,
    required this.result,
  });

  @override
  List<Object> get props => [search, result ?? -1];
}
