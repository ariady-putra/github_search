import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../widget/widgets.dart';
import '../../api/apis.dart';
import '../../bloc/blocs.dart';
import '../../cubit/cubits.dart';
import '../../model/models.dart';
import '../result_list.dart';
import '../result_record.dart';

class RepoList extends StatefulWidget {
  final List<Repo> initialItems;
  final int pageSize;

  const RepoList(
    this.initialItems, {
    this.pageSize = 30,
    super.key,
  });

  @override
  State<RepoList> createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  final PagingController<int, Repo> _pagingController =
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

      final SearchResult<Repo>? searchResult = isFirstPage
          ? SearchResult<Repo>(items: widget.initialItems)
          : await GithubApi.searchRepo(
              context.read<GithubSearchBloc>().state.search,
              page: gotoPage,
            );

      final List<Repo>? newItems = searchResult?.items;
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

  final PagedChildBuilderDelegate<Repo> _builderDelegate =
      PagedChildBuilderDelegate(
    // List tile
    itemBuilder: (_, repo, i) => Container(
      color: i.isOdd ? Colors.grey.withOpacity(.1) : null,
      child: ResultRecord(
        avatarUrl: repo.owner.avatarUrl,
        titleText: repo.fullName,
        subtitleText: repo.createdAt,
        trailingWidget: RepoStatistic(
          totalWatchers: repo.watchersCount,
          totalStars: repo.stargazersCount,
          totalForks: repo.forksCount,
        ),
        openUrl: repo.htmlUrl,
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
