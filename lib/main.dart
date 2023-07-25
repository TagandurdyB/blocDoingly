import 'logic/cubit/internet_cubit.dart';
import 'logic/cubit/theme_cubit.dart';
import 'presentation/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/services/my_orientation.dart';
import 'config/tags.dart';
import 'data/models/list_model.dart';
import 'data/models/task_model.dart';
import 'injector.dart';
import 'presentation/theme/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
//Register HiveModes=========================
  Hive.registerAdapter(ListModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
//HiveModes==================================
//List==
  await Hive.openBox<ListModel>(Tags.hiveList);
  await Hive.openBox<ListModel>(Tags.hiveListDelete);
//Task==
  await Hive.openBox<List>(Tags.hiveTask);
  await Hive.openBox<List>(Tags.hiveTaskDelete);
//===========================================
  await Hive.openBox(Tags.hiveBase);
  MyOrientation.systemUiOverlayStyle();
  runApp(const Injector(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    BlocProvider.of<InternetCubit>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).platformBrightness;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doingly',
      themeMode: ThemeCubit.of(context).mode,
      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
