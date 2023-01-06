import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';

part 'search_option_state.dart';

class SearchOptionCubit extends Cubit<SearchOptionState> {
  SearchOptionCubit()
      : super(
          const SearchOptionState(),
        );

  void set({required SearchOption searchBy}) {
    if (searchBy != state.searchBy) {
      emit(
        SearchOptionState(searchBy: searchBy),
      );
    }
  }
}
