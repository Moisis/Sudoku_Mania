import 'package:flutter/material.dart';



//Pages
import 'package:sudoku_mania/Pages/home_page.dart';
import 'package:sudoku_mania/Pages/game_page.dart';
import 'package:sudoku_mania/Pages/splash_screen.dart';


void main() {
  runApp( const MyApp());
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
      initialRoute:  '/home_page',
      routes: {
        '/splash_page': (context) => const SplashScreen(),
        '/home_page': (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/game_page') {
          final args = settings.arguments as Map<String, dynamic>;
          final difficulty = args['difficulty'] as String;
          return MaterialPageRoute(builder: (context) => GamePage(),
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


