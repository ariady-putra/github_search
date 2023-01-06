import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'bloc/blocs.dart';
import 'cubit/cubits.dart';
import 'github_search_view.dart';

class GithubSearchPageBuilder extends StatelessWidget {
  const GithubSearchPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchOptionCubit, SearchOptionState>(
      builder: (_, searchOptState) =>
          BlocBuilder<PagingOptionCubit, PagingOptionState>(
        builder: (_, pagingOptState) =>
            BlocBuilder<PageIndexCubit, PageIndexState>(
          builder: (_, pageIdxState) =>
              BlocConsumer<GithubSearchBloc, GithubSearchState>(
            listener: (_, githubSearchState) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            builder: (_, githubSearchState) => GithubSearchPageView(
              searchOptionState: searchOptState,
              pagingOptionState: pagingOptState,
              pageIndexState: pageIdxState,
              githubSearchState: githubSearchState,
            ),
          ),
        ),
      ),
    );
  }
}
