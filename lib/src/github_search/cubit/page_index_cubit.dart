import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_index_state.dart';

class PageIndexCubit extends Cubit<PageIndexState> {
  PageIndexCubit()
      : super(
          const PageIndexState(),
        );

  void reset() => emit(
        const PageIndexState(),
      );

  void setTotalPage({required int pageCount}) => emit(
        PageIndexState(
          totalPage: pageCount,
          currentPage: state.currentPage,
        ),
      );

  void gotoPage({required int page}) => emit(
        PageIndexState(
          currentPage: page,
          totalPage: state.totalPage,
        ),
      );
}
