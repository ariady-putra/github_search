import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme.dart';
import '../../util/utils.dart';
import '../../widget/widgets.dart';
import '../bloc/blocs.dart';
import '../github_search_view.dart';
import '../enum/enums.dart';
import '../model/models.dart';
import 'result_list/result_lists.dart' as lazy_loading;
import 'result_list.dart' as with_index;

abstract class BaseSearchResultArea extends StatelessWidget {
  final BuildContext parentContext;
  final int pinnedWidgetCount; // Radio group and Paging options

  const BaseSearchResultArea({
    required this.parentContext,
    this.pinnedWidgetCount = 2,
    super.key,
  });
}

// Search result list
class SearchSuccess extends BaseSearchResultArea {
  final SearchOption searchBy;
  final PagingOption pagingMode;
  final GithubSearchStateSuccess searchResult;

  const SearchSuccess({
    required super.parentContext,
    required this.searchBy,
    required this.pagingMode,
    required this.searchResult,
    super.pinnedWidgetCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (searchResult.items.isEmpty) {
      return SearchEmpty(
        parentContext: parentContext,
        pinnedWidgetCount: pinnedWidgetCount,
        message: AppText.of(context).noSearchResult,
      );
    }

    switch (searchBy) {
      case SearchOption.user:
        if (searchResult.items is List<User>) {
          switch (pagingMode) {
            case PagingOption.lazyLoading:
              return lazy_loading.UserList(searchResult.items as List<User>);
            case PagingOption.withIndex:
              return with_index.UserList(searchResult.items as List<User>);
            default:
              break;
          }
        }
        break;
      case SearchOption.issues:
        if (searchResult.items is List<Issues>) {
          switch (pagingMode) {
            case PagingOption.lazyLoading:
              return lazy_loading.IssuesList(
                  searchResult.items as List<Issues>);
            case PagingOption.withIndex:
              return with_index.IssuesList(searchResult.items as List<Issues>);
            default:
              break;
          }
        }
        break;
      case SearchOption.repo:
        if (searchResult.items is List<Repo>) {
          switch (pagingMode) {
            case PagingOption.lazyLoading:
              return lazy_loading.RepoList(searchResult.items as List<Repo>);
            case PagingOption.withIndex:
              return with_index.RepoList(searchResult.items as List<Repo>);
            default:
              break;
          }
        }
        break;
      default:
        break;
    }

    return SearchLoading(
      parentContext: parentContext,
      pinnedWidgetCount: pinnedWidgetCount,
    );
  }
}

// Text: Error message
class SearchError extends BaseSearchResultArea {
  final GithubSearchStateError searchState;

  const SearchError({
    required super.parentContext,
    required this.searchState,
    super.pinnedWidgetCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool noSearchResult = searchState.result == null;
    final bool unspecifiedError =
        !noSearchResult && searchState.result!.message == null;

    late String errorMessage;
    if (noSearchResult) {
      errorMessage = '${AppText.of(context).noSearchResult}\n\n'
          '${AppText.of(context).pleaseEnterAnotherSearchTerm}';
    } else if (unspecifiedError) {
      errorMessage = '${AppText.of(context).anUnspecifiedErrorHasOccured}'
          '\n\n${AppText.of(context).pleaseEnterAnotherSearchTerm}';
    } else {
      errorMessage = searchState.result!.message!;
    }

    return SearchResultArea(
      height: _calcSearchResultAreaHeight(
        parentContext: parentContext,
        pinnedWidgetCount: pinnedWidgetCount,
      ),
      children: [
        SvgPicture.string(
          AppSvg.error(context),
        ),
        const SizedBox(height: 20),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Loading indicator
class SearchLoading extends BaseSearchResultArea {
  const SearchLoading({
    required super.parentContext,
    super.pinnedWidgetCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchResultArea(
      initOpacity: 1,
      height: _calcSearchResultAreaHeight(
        parentContext: parentContext,
        pinnedWidgetCount: pinnedWidgetCount,
      ),
      children: const [
        LoadingIndicator(),
      ],
    );
  }
}

// Text: Please enter a search term to begin
class SearchEmpty extends BaseSearchResultArea {
  final String? message;

  const SearchEmpty({
    required super.parentContext,
    super.pinnedWidgetCount,
    this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchResultArea(
      height: _calcSearchResultAreaHeight(
        parentContext: parentContext,
        pinnedWidgetCount: pinnedWidgetCount,
      ),
      children: [
        SvgPicture.string(
          AppSvg.search(context),
        ),
        const SizedBox(height: 20),
        Text(
          message ?? AppText.of(context).pleaseEnterSearchTermToBegin,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

double _calcSearchResultAreaHeight({
  required BuildContext parentContext,
  required int pinnedWidgetCount,
}) {
  final MediaQueryData ctxMediaQuery = MediaQuery.of(parentContext);

  final Size ctxSize = ctxMediaQuery.size;
  final EdgeInsets ctxPadding = ctxMediaQuery.padding;

  return ctxSize.height -
      ctxPadding.top -
      ctxPadding.bottom -
      toolbarHeight * (pinnedWidgetCount + 1);
}

class SearchResultArea extends StatefulWidget {
  final List<Widget> children;
  final double height;
  final int topSpacerFlex;
  final int bottomSpacerFlex;
  final double initOpacity;

  const SearchResultArea({
    required this.height,
    required this.children,
    this.topSpacerFlex = 1,
    this.bottomSpacerFlex = 2,
    this.initOpacity = 0,
    super.key,
  });

  @override
  State<SearchResultArea> createState() => _SearchResultAreaState();
}

class _SearchResultAreaState extends State<SearchResultArea> {
  late int _topSpacerFlex;
  late int _bottomSpacerFlex;

  @override
  initState() {
    super.initState();

    _topSpacerFlex = widget.topSpacerFlex;
    _bottomSpacerFlex = widget.bottomSpacerFlex;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: widget.height,
        child: Column(
          children: [
            // Top spacer
            if (_topSpacerFlex > 0) Spacer(flex: _topSpacerFlex),

            // Content area
            FadeIn(
              delay: const Duration(seconds: 1),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withOpacity(.25),
                ),
                child: Column(
                  children: widget.children,
                ),
              ),
            ),

            // Bottom spacer
            if (_bottomSpacerFlex > 0) Spacer(flex: _bottomSpacerFlex),
          ],
        ),
      ),
    );
  }
}
