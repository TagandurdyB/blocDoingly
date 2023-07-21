import 'package:doingly/logic/bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/user_repository.dart';
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
        // BlocProvider<InternetCubit>(
        //     create: (context) => InternetCubit(conectivity: Connectivity())),
        // BlocProvider<CounterCubit>(
        //     create: (context) => CounterCubit(
        //         internetCubit: BlocProvider.of<InternetCubit>(context))),
        // BlocProvider<UserListBloc>(create: (context) => UserListBloc()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()..init()),
        BlocProvider<ListBloc>(create: (context)=>ListBloc()),
      ];
}