import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper/Model/theme_model.dart';
import 'package:wallpaper/Provider/plat_from.dart';
import 'package:wallpaper/Provider/theme_provider.dart';
import 'package:wallpaper/views/screens/homepage.dart';
import 'package:wallpaper/views/screens/intro_screens.dart';
import 'package:wallpaper/views/screens/setting_page.dart';

import 'Global/Global_variable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences perf = await SharedPreferences.getInstance();
  iscompleted_intro = perf.getBool("intro_completed") ?? false;
  iscompleted_theme = perf.getBool("theme_completed") ?? false;
  runApp(
    const Gautam(),
  );
}

class Gautam extends StatefulWidget {
  const Gautam({super.key});

  @override
  State<Gautam> createState() => _GautamState();
}

class _GautamState extends State<Gautam> {
  //
  // getdata() async{
  //   await Apihelper.apihelper.callapi();
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getdata();
  // }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Plat_form_convertor(),),
        ChangeNotifierProvider(
          create: (context) => theme_provider(
            app_theme: theme_model(isDark: false),
          ),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          colorScheme: ColorScheme.light(
            primary: const Color(0xff37474f),
            secondary: Colors.grey.shade200,
          ),
        ),
        darkTheme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          colorScheme: const ColorScheme.dark(
            brightness: Brightness.dark,
            primary: Colors.deepPurpleAccent,
            secondary: Colors.white54,
          ),
        ),
        themeMode: (Provider.of<theme_provider>(context).app_theme.isDark
            ? ThemeMode.light
            : ThemeMode.dark),
        routes: {
          '/': (context) => const intro_screens(),
          'homepage': (context) => const homepage(),
          // 'hidden_drawer': (context) => const hidden_drawer(),
          'intro_screens': (context) => const intro_screens(),
          'setting_page': (context) => const setting_page(),
        },
      ),
    );
  }
}
