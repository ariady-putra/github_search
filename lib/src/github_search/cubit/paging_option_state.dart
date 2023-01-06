part of 'paging_option_cubit.dart';

class PagingOptionState extends Equatable {
  final PagingOption pagingMode;

  const PagingOptionState({this.pagingMode = PagingOption.lazyLoading});

  @override
  List<PagingOption> get props => [pagingMode];
}
