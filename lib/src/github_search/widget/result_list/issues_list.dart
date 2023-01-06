import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../widget/widgets.dart';
import '../../api/apis.dart';
import '../../bloc/blocs.dart';
import '../../cubit/cubits.dart';
import '../../model/models.dart';
import '../result_record.dart';

class IssuesList extends StatefulWidget {
  final List<Issues> initialItems;
  final int pageSize;

  const IssuesList(
    this.initialItems, {
    this.pageSize = 30,
    super.key,
  });

  @override
  State<IssuesList> createState() => _IssuesListState();
}

class _IssuesListState extends State<IssuesList> {
  final PagingController<int, Issues> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchAndUpdatePage);
  }

  void _fetchAndUpdatePage(int pageKey) => _fetchPage(pageKey).then(
        (targetPage) => targetPage == null
            ? context.read<PageIndexCubit>().reset()
            : context.read<PageIndexCubit>().gotoPage(
                  page: targetPage,
                ),
      );

  Future<int?> _fetchPage(int pageKey) async {
    try {
      final int gotoPage = (pageKey / widget.pageSize).ceil();
      final bool isFirstPage = gotoPage == 1;

      final SearchResult<Issues>? searchResult = isFirstPage
          ? SearchResult<Issues>(items: widget.initialItems)
          : await GithubApi.searchIssues(
              context.read<GithubSearchBloc>().state.search,
              page: gotoPage,
            );

      final List<Issues>? newItems = searchResult?.items;
      final bool isLastPage = newItems!.length < widget.pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }

      return gotoPage;
    } catch (x) {
      try {
        _pagingController.error = x;
      } catch (_) {}
      return null;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  final PagedChildBuilderDelegate<Issues> _builderDelegate =
      PagedChildBuilderDelegate(
    // List tile
    itemBuilder: (_, issues, i) => Container(
      color: i.isOdd ? Colors.grey.withOpacity(.1) : null,
      child: ResultRecord(
        avatarUrl: issues.user.avatarUrl,
        titleText: issues.title,
        subtitleText: issues.updatedAt,
        trailingWidget: Text(issues.state),
        openUrl: issues.htmlUrl,
      ),
    ),

    // Loading indicator
    newPageProgressIndicatorBuilder: (_) => const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: LoadingIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PagedSliverList(
      pagingController: _pagingController,
      builderDelegate: _builderDelegate,
    );
  }
}
