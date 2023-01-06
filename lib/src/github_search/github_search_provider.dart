import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'bloc/blocs.dart';
import 'cubit/cubits.dart';
import 'github_search_builder.dart';

class GithubSearchPageProvider extends StatelessWidget {
  const GithubSearchPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchOptionCubit(),
        ),
        BlocProvider(
          create: (_) => PagingOptionCubit(),
        ),
        BlocProvider(
          create: (_) => PageIndexCubit(),
        ),
        BlocProvider(
          create: (_) => GithubSearchBloc(),
        ),
      ],
      child: const GithubSearchPageBuilder(),
    );
  }
}
