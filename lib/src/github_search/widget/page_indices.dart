import 'package:flutter/material.dart';
import 'package:pager/pager.dart';

class PageIndices extends StatelessWidget {
  final double toolbarHeight;
  final dynamic Function(int) onPagerChanged;
  final int pageCount;
  final int currentPage;

  const PageIndices({
    required this.toolbarHeight,
    required this.onPagerChanged,
    required this.pageCount,
    this.currentPage = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: toolbarHeight,
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pager(
            numberButtonSelectedColor: Theme.of(context).indicatorColor,
            numberTextSelectedColor: Theme.of(context).cardColor,
            numberTextUnselectedColor: Theme.of(context).unselectedWidgetColor,
            pagesView: MediaQuery.of(context).size.width ~/ 135,
            currentPage: currentPage,
            totalPages: pageCount,
            onPageChanged: onPagerChanged,
          ),
        ],
      ),
    );
  }
}
