import 'package:dio/dio.dart';

import '../model/models.dart';
import 'cache.dart';

class GithubApi {
  static Future _search(String path, String q, {int page = 1}) async {
    final Response rsp = await Dio().get(
      'https://api.github.com/search/$path',
      queryParameters: {
        'q': q,
        'page': page,
      },
      options: Options(validateStatus: (_) => true),
    );
    print('https://api.github.com/search/$path?q=$q&page=$page');
    return rsp.data;
  }

  static Future<SearchResult<User>?> searchUser(
    String user, {
    int page = 1,
    bool useCache = true,
  }) async {
    final String cacheKey = '$user$page';
    if (useCache && ApiCache.users.containsKey(cacheKey)) {
      print('ApiCache.users[$cacheKey]');
      await Future.delayed(
        const Duration(seconds: 1),
      );
      return ApiCache.users[cacheKey];
    }

    final response = await _search('users', user, page: page);
    final SearchResult<User> result = SearchResult<User>.fromJson(
      response,
      (json) => User.fromJson(json as Map<String, dynamic>),
    );

    // Only cache result containing items
    if (result.items != null) ApiCache.users[cacheKey] = result;
    return result;
  }

  static Future<SearchResult<Issues>?> searchIssues(
    String issues, {
    int page = 1,
    bool useCache = true,
  }) async {
    final String cacheKey = '$issues$page';
    if (useCache && ApiCache.issues.containsKey(cacheKey)) {
      print('ApiCache.issues[$cacheKey]');
      await Future.delayed(
        const Duration(seconds: 1),
      );
      return ApiCache.issues[cacheKey];
    }

    final response = await _search('issues', issues, page: page);
    final SearchResult<Issues> result = SearchResult<Issues>.fromJson(
      response,
      (json) => Issues.fromJson(json as Map<String, dynamic>),
    );

    // Only cache result containing items
    if (result.items != null) ApiCache.issues[cacheKey] = result;
    return result;
  }

  static Future<SearchResult<Repo>?> searchRepo(
    String repo, {
    int page = 1,
    bool useCache = true,
  }) async {
    final String cacheKey = '$repo$page';
    if (useCache && ApiCache.repos.containsKey(cacheKey)) {
      print('ApiCache.repos[$cacheKey]');
      await Future.delayed(
        const Duration(seconds: 1),
      );
      return ApiCache.repos[cacheKey];
    }

    final response = await _search('repositories', repo, page: page);
    final SearchResult<Repo> result = SearchResult<Repo>.fromJson(
      response,
      (json) => Repo.fromJson(json as Map<String, dynamic>),
    );

    // Only cache result containing items
    if (result.items != null) ApiCache.repos[cacheKey] = result;
    return result;
  }
}
