import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sudoku_mania/components/icon_button.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> textList = [
    "Beginner",
    "Easy",
    "Medium",
    "Hard",
    "Expert",
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        title: Text('Sudoku Mania'.toUpperCase()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/pastime.png', scale: 2,),
            const SizedBox(height: 20),
            Stack(
              children: [
                CarouselSlider(
                  items: textList.map((item) => Center(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 24.0),
                    ),
                  )).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: 100.0,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => _controller.previousPage(),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => _controller.nextPage(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            IC_button(
                title: "Start Game",
                icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24.0),
                color: Color(0xFF232E7A),
                width: 200.0,
                height: 60.0,
                fontsize: 20.0,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    "/game_page",
                    arguments: { 'difficulty' : textList[_current].toString() },
                  );
                },),
          ],
        ),
      ),
    );
  }
}
