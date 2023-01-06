part of 'github_search_bloc.dart';

abstract class GithubSearchEvent extends Equatable {
  final bool resetCache;
  final int gotoPage;
  final void Function(int)? setPageCount;
  final SearchOption Function()? searchingFor;

  const GithubSearchEvent({
    this.resetCache = false,
    this.gotoPage = 1,
    this.setPageCount,
    this.searchingFor,
  });
}

class GithubSearchUser extends GithubSearchEvent {
  final String user;

  const GithubSearchUser({
    required this.user,
    super.resetCache,
    super.gotoPage,
    super.setPageCount,
    super.searchingFor,
  });

  @override
  String toString() => '''GithubSearchUser {
    user: $user,
    page: $gotoPage,
    use_cache: ${!resetCache}
  }''';

  @override
  List<Object> get props => [user, gotoPage, !resetCache];
}

class GithubSearchIssues extends GithubSearchEvent {
  final String issues;

  const GithubSearchIssues({
    required this.issues,
    super.resetCache,
    super.gotoPage,
    super.setPageCount,
    super.searchingFor,
  });

  @override
  String toString() => '''GithubSearchIssues {
    issues: $issues,
    page: $gotoPage,
    use_cache: ${!resetCache}
  }''';

  @override
  List<Object> get props => [issues, gotoPage, !resetCache];
}

class GithubSearchRepo extends GithubSearchEvent {
  final String repo;

  const GithubSearchRepo({
    required this.repo,
    super.resetCache,
    super.gotoPage,
    super.setPageCount,
    super.searchingFor,
  });

  @override
  String toString() => '''GithubSearchRepo {
    repo: $repo,
    page: $gotoPage,
    use_cache: ${!resetCache}
  }''';

  @override
  List<Object> get props => [repo, gotoPage, !resetCache];
}
