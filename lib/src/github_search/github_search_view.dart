import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../util/utils.dart';
import 'bloc/blocs.dart';
import 'cubit/cubits.dart';
import 'enum/enums.dart';
import 'widget/widgets.dart';

const double toolbarHeight = 70;

class GithubSearchPageView extends StatefulWidget {
  final SearchOptionState searchOptionState;
  final PagingOptionState pagingOptionState;
  final PageIndexState pageIndexState;
  final GithubSearchState githubSearchState;

  const GithubSearchPageView({
    required this.searchOptionState,
    required this.pagingOptionState,
    required this.pageIndexState,
    required this.githubSearchState,
    super.key,
  });

  @override
  State<GithubSearchPageView> createState() => GithubSearchPageViewState();
}

class GithubSearchPageViewState extends State<GithubSearchPageView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
    ).whenComplete(
      () => AppSplash.remove(),
    );
  }

  void _setSearchOption({required SearchOption searchBy}) {
    context.read<SearchOptionCubit>().set(searchBy: searchBy);
    if (_searchFieldController.text.isNotEmpty) {
      _onPagerChanged(1); // reset page
    }
  }

  void _setPagingOption({required PagingOption pagingMode}) {
    context.read<PagingOptionCubit>().set(pagingMode: pagingMode);
    if (_searchFieldController.text.isNotEmpty) {
      _onPagerChanged(pagingMode == PagingOption.withIndex
          ? widget.pageIndexState.currentPage
          : 1);
    }
  }

  void _setPagerCount(int totalPage) =>
      context.read<PageIndexCubit>().setTotalPage(pageCount: totalPage);

  void _onRefresh() => _searchGithub(
        widget.searchOptionState.searchBy,
        _searchFieldController.text,
        refresh: true,
      );

  void _onSearchTextChanged(String value) =>
      _searchGithub(widget.searchOptionState.searchBy, value);

  void _onSearchTextCleared() {
    _onSearchTextChanged('');
    _searchFieldController.text = '';
    context.read<PageIndexCubit>().reset();
  }

  void _onSearchOptionChanged(SearchOption? searchBy) {
    if (searchBy != null) {
      _setSearchOption(searchBy: searchBy);
      _searchGithub(searchBy, _searchFieldController.text);
    }
  }

  void _onPagerChanged(int gotoPage) => _searchGithub(
        widget.searchOptionState.searchBy,
        _searchFieldController.text,
        page: gotoPage,
      );

  void _searchGithub(
    SearchOption searchBy,
    String value, {
    bool refresh = false,
    int page = 1,
  }) {
    context.read<PageIndexCubit>().gotoPage(page: page);
    switch (searchBy) {
      case SearchOption.user:
        return context.read<GithubSearchBloc>().add(
              GithubSearchUser(
                user: value,
                resetCache: refresh,
                gotoPage: page,
                setPageCount: _setPagerCount,
                searchingFor: () => widget.searchOptionState.searchBy,
              ),
            );
      case SearchOption.issues:
        return context.read<GithubSearchBloc>().add(
              GithubSearchIssues(
                issues: value,
                resetCache: refresh,
                gotoPage: page,
                setPageCount: _setPagerCount,
                searchingFor: () => widget.searchOptionState.searchBy,
              ),
            );
      case SearchOption.repo:
        return context.read<GithubSearchBloc>().add(
              GithubSearchRepo(
                repo: value,
                resetCache: refresh,
                gotoPage: page,
                setPageCount: _setPagerCount,
                searchingFor: () => widget.searchOptionState.searchBy,
              ),
            );
      default:
        return;
    }
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  final TextEditingController _searchFieldController = TextEditingController();
  /* App bar:
      - Search bar
      - Pinned widgets:
        + Radio group:
          | User
          | Issues
          | Repositories
        + Paging options:
          | Lazy loading
          | With index
  */
  /* Search result area:
      / Search result success
      / Search result error
      / Search result loading
      / Search result empty
  */
  Widget _body() {
    const int pinnedWidgetCount = 2; // Search options and Paging options

    return CustomScrollView(
      slivers: [
        // App bar
        SearchBar(
          // Height per toolbar
          toolbarHeight: toolbarHeight,
          /* There are 3 bars:
              - Search field
              - Search options (User | Issues | Repositories)
              - Paging options (Lazy loading | With index)
          */

          // Search field
          searchFieldController: _searchFieldController,
          onSearchTextChanged: _onSearchTextChanged,
          onSearchTextCleared: _onSearchTextCleared,

          // Search options: User | Issues | Repositories
          currentSearchOptionValue: widget.searchOptionState.searchBy,
          onSearchOptionChanged: _onSearchOptionChanged,

          // Paging options: Lazy loading | With index
          currentPagingOptionValue: widget.pagingOptionState.pagingMode,
          onPagingOptionChanged: (p) => _setPagingOption(pagingMode: p),
        ),

        // Search results
        if (widget.githubSearchState is GithubSearchStateSuccess)
          SearchSuccess(
            parentContext: context,
            searchBy: widget.searchOptionState.searchBy,
            pagingMode: widget.pagingOptionState.pagingMode,
            searchResult: widget.githubSearchState as GithubSearchStateSuccess,
            pinnedWidgetCount: pinnedWidgetCount,
          ),

        // Search error
        if (widget.githubSearchState is GithubSearchStateError)
          SearchError(
            parentContext: context,
            searchState: widget.githubSearchState as GithubSearchStateError,
            pinnedWidgetCount: pinnedWidgetCount,
          ),

        // Search loading
        if (widget.githubSearchState is GithubSearchStateLoading)
          SearchLoading(
            parentContext: context,
            pinnedWidgetCount: pinnedWidgetCount,
          ),

        // Search empty
        if (widget.githubSearchState is GithubSearchStateEmpty)
          SearchEmpty(
            parentContext: context,
            pinnedWidgetCount: pinnedWidgetCount,
          ),
      ],
    );
  }

  // Page indices
  Widget? _bottomAppBar() {
    final int pageCount =
        widget.pagingOptionState.pagingMode == PagingOption.withIndex
            ? widget.pageIndexState.totalPage
            : 0;
    if (pageCount == 0) return null;

    final int currPage = min(widget.pageIndexState.currentPage, pageCount);
    return PageIndices(
      toolbarHeight: toolbarHeight,
      onPagerChanged: _onPagerChanged,
      pageCount: pageCount,
      currentPage: currPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSearchQuery = widget.githubSearchState.search.isNotEmpty;

    return SafeArea(
      child: Scaffold(
        // App bar & search result area
        body: hasSearchQuery
            // if it has search query,
            ? LiquidPullToRefresh(
                onRefresh: () async => _onRefresh(),
                child: _body(),
              )

            // no pull-to-refresh when there's no search query
            : _body(),

        // Page indices
        bottomNavigationBar: _bottomAppBar(),
      ),
    );
  }
}
