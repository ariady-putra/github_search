import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../api/apis.dart';
import '../enum/enums.dart';
import '../model/models.dart';

part 'github_search_event.dart';
part 'github_search_state.dart';

const _duration = Duration(seconds: 1);

EventTransformer<Event> debounce<Event>(Duration duration) =>
    (source, mapper) => source.debounce(duration).switchMap(mapper);

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  GithubSearchBloc()
      : super(
          GithubSearchStateEmpty(),
        ) {
    on<GithubSearchUser>(
      _onSearchUser,
      transformer: debounce(_duration),
    );

    on<GithubSearchIssues>(
      _onSearchIssues,
      transformer: debounce(_duration),
    );

    on<GithubSearchRepo>(
      _onSearchRepo,
      transformer: debounce(_duration),
    );
  }

  // the user might change the search option during another search process
  _searchingFor(SearchOption searchingFor, GithubSearchEvent event) =>
      event.searchingFor != null && event.searchingFor!() == searchingFor;
  // se we need to verify each time before emitting a state

  Future<void> _onSearchUser(
    GithubSearchUser event,
    Emitter<GithubSearchState> emit,
  ) async {
    searchingForUser() => _searchingFor(SearchOption.user, event);

    if (searchingForUser() && event.user.isEmpty) {
      return emit(
        GithubSearchStateEmpty(),
      );
    }

    if (searchingForUser()) {
      emit(
        GithubSearchStateLoading(search: event.user),
      );
    }

    final SearchResult? searchResult = await GithubApi.searchUser(
      event.user,
      useCache: !event.resetCache,
      page: event.gotoPage,
    );
    if (searchResult != null && searchResult.items != null) {
      final int resultCount = searchResult.totalCount ?? 0;
      final int totalPage = (resultCount / 30).ceil();
      if (searchingForUser()) {
        emit(
          GithubSearchStateSuccess(
            search: event.user,
            items: searchResult.items!,
            pages: totalPage,
          ),
        );
        if (event.setPageCount != null) event.setPageCount!(totalPage);
      }
    } else {
      if (searchingForUser()) {
        emit(
          GithubSearchStateError(
            search: event.user,
            result: searchResult,
          ),
        );
      }
    }
  }

  Future<void> _onSearchIssues(
    GithubSearchIssues event,
    Emitter<GithubSearchState> emit,
  ) async {
    searchingForIssues() => _searchingFor(SearchOption.issues, event);

    if (searchingForIssues() && event.issues.isEmpty) {
      return emit(
        GithubSearchStateEmpty(),
      );
    }

    if (searchingForIssues()) {
      emit(
        GithubSearchStateLoading(search: event.issues),
      );
    }

    final SearchResult? searchResult = await GithubApi.searchIssues(
      event.issues,
      useCache: !event.resetCache,
      page: event.gotoPage,
    );
    if (searchResult != null && searchResult.items != null) {
      final int resultCount = searchResult.totalCount ?? 0;
      final int totalPage = (resultCount / 30).ceil();
      if (searchingForIssues()) {
        emit(
          GithubSearchStateSuccess(
            search: event.issues,
            items: searchResult.items!,
            pages: totalPage,
          ),
        );
        if (event.setPageCount != null) event.setPageCount!(totalPage);
      }
    } else {
      if (searchingForIssues()) {
        emit(
          GithubSearchStateError(
            search: event.issues,
            result: searchResult,
          ),
        );
      }
    }
  }

  Future<void> _onSearchRepo(
    GithubSearchRepo event,
    Emitter<GithubSearchState> emit,
  ) async {
    searchingForRepo() => _searchingFor(SearchOption.repo, event);

    if (searchingForRepo() && event.repo.isEmpty) {
      return emit(
        GithubSearchStateEmpty(),
      );
    }

    if (searchingForRepo()) {
      emit(
        GithubSearchStateLoading(search: event.repo),
      );
    }

    final SearchResult? searchResult = await GithubApi.searchRepo(
      event.repo,
      useCache: !event.resetCache,
      page: event.gotoPage,
    );
    if (searchResult != null && searchResult.items != null) {
      final int resultCount = searchResult.totalCount ?? 0;
      final int totalPage = (resultCount / 30).ceil();
      if (searchingForRepo()) {
        emit(
          GithubSearchStateSuccess(
            search: event.repo,
            items: searchResult.items!,
            pages: totalPage,
          ),
        );
        if (event.setPageCount != null) event.setPageCount!(totalPage);
      }
    } else {
      if (searchingForRepo()) {
        emit(
          GithubSearchStateError(
            search: event.repo,
            result: searchResult,
          ),
        );
      }
    }
  }
}
