import 'package:flutter/material.dart';

import '../../util/app_text.dart';
import '../model/models.dart';
import 'result_record.dart';

class UserList extends StatelessWidget {
  final List<User> users;

  const UserList(this.users, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(
          color: i.isOdd ? Colors.grey.withOpacity(.1) : null,
          child: ResultRecord(
            avatarUrl: users[i].avatarUrl,
            titleText: users[i].login,
            openUrl: users[i].htmlUrl,
          ),
        ),
        childCount: users.length,
      ),
    );
  }
}

class IssuesList extends StatelessWidget {
  final List<Issues> issues;

  const IssuesList(this.issues, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(
          color: i.isOdd ? Colors.grey.withOpacity(.1) : null,
          child: ResultRecord(
            avatarUrl: issues[i].user.avatarUrl,
            titleText: issues[i].title,
            subtitleText: issues[i].updatedAt,
            trailingWidget: Text(issues[i].state),
            openUrl: issues[i].htmlUrl,
          ),
        ),
        childCount: issues.length,
      ),
    );
  }
}

class RepoList extends StatelessWidget {
  final List<Repo> repos;

  const RepoList(this.repos, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => Container(
          color: i.isOdd ? Colors.grey.withOpacity(.1) : null,
          child: ResultRecord(
            avatarUrl: repos[i].owner.avatarUrl,
            titleText: repos[i].fullName,
            subtitleText: repos[i].createdAt,
            trailingWidget: RepoStatistic(
              totalWatchers: repos[i].watchersCount,
              totalStars: repos[i].stargazersCount,
              totalForks: repos[i].forksCount,
            ),
            openUrl: repos[i].htmlUrl,
          ),
        ),
        childCount: repos.length,
      ),
    );
  }
}

class RepoStatistic extends StatelessWidget {
  final int totalWatchers;
  final int totalStars;
  final int totalForks;

  const RepoStatistic({
    required this.totalWatchers,
    required this.totalStars,
    required this.totalForks,
    super.key,
  });

  TableRow _row({
    required int count,
    required IconData icon,
    required String label,
  }) {
    return TableRow(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(' $count '),
        ),
        Icon(icon, size: 21),
        Text(' $label '),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        _row(
          count: totalWatchers,
          icon: Icons.remove_red_eye_outlined,
          label: AppText.of(context).watchers,
        ),
        _row(
          count: totalStars,
          icon: Icons.star_outline,
          label: AppText.of(context).stars,
        ),
        _row(
          count: totalForks,
          icon: Icons.fork_right_outlined,
          label: AppText.of(context).forks,
        ),
      ],
    );
  }
}
