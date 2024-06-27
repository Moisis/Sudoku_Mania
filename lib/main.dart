import 'package:flutter/material.dart';



//Pages
import 'package:sudoku_mania/Pages/home_page.dart';
import 'package:sudoku_mania/Pages/Game_Page.dart';
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
      initialRoute:  '/game_page',
      routes: {
        '/splash_page': (context) => const SplashScreen(),
        '/home_page': (context) => const HomeScreen(),
        '/game_page': (context) => SudokuContent(),
      },
    );
  }
}


