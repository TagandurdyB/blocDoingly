import 'package:connectivity_plus/connectivity_plus.dart';
import 'data/repositories/list_repository.dart';
import 'logic/bloc/list_bloc.dart';
import 'logic/bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/task_repository.dart';
import 'data/repositories/user_repository.dart';
import 'logic/cubit/internet_cubit.dart';
import 'logic/cubit/theme_cubit.dart';

class Injector extends StatelessWidget {
  final Widget child;
  const Injector(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: repositories(context),
        child: MultiBlocProvider(providers: providers(context), child: child));
  }

  repositories(BuildContext context) => [
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
      ];

  providers(BuildContext context) => [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()..init()),
        BlocProvider<InternetCubit>(
            lazy: false,
            create: (context) => InternetCubit(conectivity: Connectivity())),
        BlocProvider<ListBloc>(
            create: (context) => ListBloc(
                BlocProvider.of<InternetCubit>(context), ListRepository())),
        BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(
                BlocProvider.of<InternetCubit>(context),
                TaskRepository(),
                BlocProvider.of<ListBloc>(context))),
      ];
}
