import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widget/widgets.dart';

// List tile: Leading avatar | Title text | Trailing widget
class ResultRecord extends StatelessWidget {
  final String avatarUrl;
  final String titleText;
  final String openUrl;
  final String? subtitleText;
  final Widget? trailingWidget;

  const ResultRecord({
    required this.avatarUrl,
    required this.titleText,
    required this.openUrl,
    this.subtitleText,
    this.trailingWidget,
    super.key,
  });

  Widget _leadingAvatar(String imgUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        placeholder: (context, url) => const AspectRatio(
          aspectRatio: 1,
          child: Center(
            child: LoadingIndicator(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _leadingAvatar(avatarUrl),
      title: Text(titleText),
      subtitle: subtitleText == null ? null : Text(subtitleText!),
      trailing: trailingWidget,
      visualDensity: const VisualDensity(vertical: 3),
      contentPadding: const EdgeInsets.all(8),
      onTap: () => launchUrlString(openUrl),
    );
  }
}
