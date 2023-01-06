import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';

part 'paging_option_state.dart';

class PagingOptionCubit extends Cubit<PagingOptionState> {
  PagingOptionCubit()
      : super(
          const PagingOptionState(),
        );

  void set({required PagingOption pagingMode}) {
    if (pagingMode != state.pagingMode) {
      emit(
        PagingOptionState(pagingMode: pagingMode),
      );
    }
  }
}
