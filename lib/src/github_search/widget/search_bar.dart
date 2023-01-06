import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../settings/settings_view.dart';
import '../../util/utils.dart';
import '../../widget/widgets.dart';
import '../enum/enums.dart';
import 'search_field.dart';

class SearchBar extends StatelessWidget {
  final double toolbarHeight; // height per toolbar

  final TextEditingController searchFieldController;
  final void Function(String)? onSearchTextChanged;
  final void Function()? onSearchTextCleared;

  final SearchOption currentSearchOptionValue;
  final void Function(SearchOption?)? onSearchOptionChanged;

  final PagingOption currentPagingOptionValue;
  final void Function(PagingOption)? onPagingOptionChanged;

  const SearchBar({
    super.key,

    // Height per toolbar
    required this.toolbarHeight,

    // Search field
    required this.searchFieldController,
    this.onSearchTextChanged,
    this.onSearchTextCleared,

    // Search options: User | Issues | Repositories
    this.currentSearchOptionValue = SearchOption.user,
    this.onSearchOptionChanged,

    // Paging options: Lazy loading | With index
    this.currentPagingOptionValue = PagingOption.lazyLoading,
    this.onPagingOptionChanged,
  });

  final ShapeBorder _appBarBorderShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(16),
    ),
  );

  Widget _searchBar({
    required BuildContext context,
    required ShapeBorder shape,
  }) {
    return FlexibleSpaceBar(
      background: AppBar(
        toolbarHeight: AppPlatform.isDesktop(context) ? null : toolbarHeight,
        shape: shape,

        // Back button
        leadingWidth: 56,
        leading: IconButton(
          tooltip: AppText.of(context).quit,
          icon: const Icon(Icons.arrow_back_outlined),
          padding: const EdgeInsets.only(bottom: 4),
          onPressed: () => SystemNavigator.pop(),
        ),

        // Settings page
        actions: [
          SizedBox(
            width: 56,
            child: IconButton(
              tooltip: AppText.of(context).settings,
              icon: const Icon(Icons.settings_outlined),
              padding: const EdgeInsets.only(bottom: 4),
              onPressed: () => context.navigator.push<void>(
                SwipeablePageRoute(
                  builder: (_) => SettingsView(),
                ),
              ),
            ),
          ),
        ],

        // Search field
        titleSpacing: 0,
        title: SizedBox(
          height: AppPlatform.isDesktop(context) ? null : toolbarHeight,
          child: SearchField(
            control: searchFieldController,
            onSearchTextChanged: onSearchTextChanged,
            suffixIconTapAction: onSearchTextCleared,
          ),
        ),
      ),
    );
  }

  List<Widget> _pinnedWidgets(BuildContext context) {
    // Radio group: User | Issues | Repositories
    final Widget radioGroup = SizedBox(
      height: toolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // User
          RadioButton(
            title: AppText.of(context).user,
            value: SearchOption.user,
            groupValue: currentSearchOptionValue,
            onChanged: onSearchOptionChanged,
          ),

          // Issues
          RadioButton(
            title: AppText.of(context).issues,
            value: SearchOption.issues,
            groupValue: currentSearchOptionValue,
            onChanged: onSearchOptionChanged,
          ),

          // Repositories
          RadioButton(
            title: AppText.of(context).repositories,
            value: SearchOption.repo,
            groupValue: currentSearchOptionValue,
            onChanged: onSearchOptionChanged,
          ),
        ],
      ),
    );

    // Paging options: Lazy loading | With index
    final Widget pagingOptions = SizedBox(
      height: toolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lazy loading
          DefaultButton(
            hierarchy: currentPagingOptionValue == PagingOption.lazyLoading
                ? DefaultButtonHierarchy.primary
                : DefaultButtonHierarchy.secondary,
            tapAction: () {
              if (onPagingOptionChanged != null) {
                onPagingOptionChanged!(PagingOption.lazyLoading);
              }
            },
            label: AppText.of(context).lazyLoading,
          ),

          // With index
          DefaultButton(
            hierarchy: currentPagingOptionValue == PagingOption.withIndex
                ? DefaultButtonHierarchy.primary
                : DefaultButtonHierarchy.secondary,
            tapAction: () {
              if (onPagingOptionChanged != null) {
                onPagingOptionChanged!(PagingOption.withIndex);
              }
            },
            label: AppText.of(context).withIndex,
          ),
        ],
      ),
    );

    return [
      radioGroup,
      pagingOptions,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Widget searchBar = _searchBar(
      context: context,
      shape: _appBarBorderShape,
    );
    final List<Widget> pinnedWidgets = _pinnedWidgets(context);
    final int pinnedWidgetCount = pinnedWidgets.length;

    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      toolbarHeight: toolbarHeight,

      // Search bar
      flexibleSpace: searchBar,

      // Pinned widgets
      bottom: AppBar(
        toolbarHeight: toolbarHeight * pinnedWidgetCount,
        titleTextStyle: const TextStyle(fontSize: 14),
        title: Column(
          children: pinnedWidgets,
        ),
        shape: _appBarBorderShape,
      ),
      shape: _appBarBorderShape,
    );
  }
}
