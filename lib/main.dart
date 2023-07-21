import 'package:doingly/logic/cubit/theme_cubit.dart';
import 'package:doingly/presentation/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/services/my_orientation.dart';
import 'config/tags.dart';
import 'injector.dart';
import 'presentation/theme/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Tags.hiveBase);
  MyOrientation.systemUiOverlayStyle();
  runApp(const Injector(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     final providerT = ThemeP.of(context, listen: false);
  //     providerT.getIsSystem;
  //     providerT.getIsLight;
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).platformBrightness;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doingly',
      // themeMode: ThemeP.of(context).mode,
      themeMode: ThemeCubit.of(context).mode,
      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      // routes: Rout.pages,
      // initialRoute: Rout.logo,
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}