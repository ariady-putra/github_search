import '../model/models.dart';

class ApiCache {
  static final Map<String, SearchResult<User>> users = {};
  static final Map<String, SearchResult<Issues>> issues = {};
  static final Map<String, SearchResult<Repo>> repos = {};
}
