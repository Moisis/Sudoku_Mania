import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



//Pages
import 'package:sudoku_mania/Pages/home_page.dart';
import 'package:sudoku_mania/Pages/game_page.dart';
import 'package:sudoku_mania/Pages/rules_page.dart';
import 'package:sudoku_mania/Pages/splash_screen.dart';

import 'Pages/info_page.dart';
import 'Pages/statictics_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute:  '/splash_page',
      routes: {
        '/splash_page': (context) => const SplashScreen(),
        '/home_page': (context) => const HomeScreen(),
        '/info_page': (context) => const InfoPage(),
        '/rules_page': (context) => const RulesPage(),
        '/stats_page': (context) => const StatsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/game_page') {
          final args = settings.arguments as Map<String, dynamic>;
          final difficulty = args['difficulty'] as String;
          return MaterialPageRoute(builder: (context) =>  GamePage(),
            settings: RouteSettings(
              name : '/game_page',
              arguments: difficulty,
            ),
          );
        }
        return null;
      },
    );
  }
}


