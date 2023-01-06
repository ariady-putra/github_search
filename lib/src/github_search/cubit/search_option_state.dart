part of 'search_option_cubit.dart';

class SearchOptionState extends Equatable {
  final SearchOption searchBy;

  const SearchOptionState({this.searchBy = SearchOption.user});

  @override
  List<SearchOption> get props => [searchBy];
}
