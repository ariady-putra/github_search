part of 'page_index_cubit.dart';

class PageIndexState extends Equatable {
  final int totalPage;
  final int currentPage;

  const PageIndexState({
    this.totalPage = 0,
    this.currentPage = 1,
  });

  @override
  List<Object> get props => [currentPage, totalPage];
}
