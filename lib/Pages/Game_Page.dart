

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/Num_pad.dart';
import 'package:sudoku_mania/models/Sudoku.dart';

import '../components/custom_button.dart';

class SudokuContent extends StatefulWidget {




  @override
  State<SudokuContent> createState() => _SudokuContentState();

}

class _SudokuContentState extends State<SudokuContent> {

   late var sudokuGrid ;
    late var Oldboard ;


   //var sudokuGrid = List.generate(9, (i) => List.filled(9, 0, growable: false), growable: false);

  // // keep the track of the numbers input by the user. (for display purpose).
  var UserInputNumbers = List.generate(9, (i) => List.filled(9, false, growable: false), growable: false);
  //
  // coordinates of the column selected.
  var rowSelected = -1;
  var colSelected = -1;

  // indexes of the number that are repeated.
  int invalidRow1 = -1;
  int invalidCol1 = -1;
  int invalidRow2 = -1;
  int invalidCol2 = -1;



   Timer? _timer;
   int _secondsElapsed = 0;

   void startTimer() {
     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
       setState(() {
         _secondsElapsed++;
       });
     });
   }

   void stopTimer() {
     _timer?.cancel();
   }

   @override
   void dispose() {
     stopTimer();
     super.dispose();
   }


   String formatTime(int seconds) {
     final int minutes = seconds ~/ 60;
     final int remainingSeconds = seconds % 60;
     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var sudoku = Sudoku();
    sudokuGrid = List.generate(9, (i) => List.filled(9, 0, growable: false), growable: false);
   // Oldboard = List.generate(9, (i) => List.filled(9, 0, growable: false), growable: false);

    sudoku.generateSolvedPuzzle();
    sudoku.generateUnsolvedPuzzle();
    sudokuGrid = sudoku.board ;
    //Oldboard = sudoku.board ;
    startTimer();

   }

   void _newGame() {
     setState(() {

       UserInputNumbers = List.generate(9, (i) => List.filled(9, false, growable: false), growable: false);
       var sudoku = Sudoku();
       sudoku.generateSolvedPuzzle();
       sudoku.generateUnsolvedPuzzle();
       sudokuGrid = sudoku.board ;

       invalidRow1 = invalidRow2 = invalidCol1 = invalidCol2  = -1; // Reset invalid indicators
       rowSelected = colSelected = -1;


       stopTimer();
        _secondsElapsed = 0;
        startTimer();

     });
   }


  void _onNumberSelected(index){
    setState(() {
      if (rowSelected >= 0 && colSelected >= 0 && sudokuGrid[rowSelected][colSelected]  == 0 ) {
        sudokuGrid[rowSelected][colSelected] = index ;
        UserInputNumbers[rowSelected][colSelected] = true;
      }
    });
    //print(index);
  }


  void removetest(){
    print('test');
    setState(() {
      if (rowSelected == -1 || colSelected == -1) {
        return;
      }
      sudokuGrid[rowSelected][colSelected] = 0;
      UserInputNumbers[rowSelected][colSelected] = false;
    });
  }

   bool isHeartFilled1 = true; // Change this value according to your logic
   bool isHeartFilled2 = true; // Change this value according to your logic
   bool isHeartFilled3 = false; // Change this value according to your logic

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Color(0xFF1468EF),

      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            const Text('EASY',
              style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold ),
            ),
            Spacer(), // This will take up all available space, pushing the hearts to the right
            Icon(
              isHeartFilled1 ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(width: 10),
            Icon(
              isHeartFilled2 ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(width: 10),
            Icon(
              isHeartFilled3 ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: Colors.red,
              size: 30,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),

        child: Column(

          children: [
            const SizedBox( height: 10 ),

            // !-----------------------New Game Button-----------------------!
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.37,
                  child: Custom_button(
                    title: 'New Game',
                    onPress : _newGame,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.21),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.37,
                  child: Custom_button(
                    title: formatTime(_secondsElapsed),
                    onPress : _newGame,
                  ),
                ),


              ],

            ),
            // Custom_button(
            //   title: 'New Game',
            //   onPress : _newGame,
            // ),

            // !-----------------------Sudoku-----------------------!
            SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: 400,
                child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                ), itemBuilder: (context,index){
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          rowSelected = index ~/9;
                          colSelected = index%9;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (invalidRow1 ==  index ~/9 && invalidCol1 == index%9) || (invalidRow2 ==  index ~/9 && invalidCol2 == index%9)
                              ? Colors.red[200] // show red colour for invalid boxes.
                              : Colors.white,

                          border: rowSelected ==  index ~/9 && colSelected == index%9
                              ? Border.all(color: Colors.red, width: 2) // show red border for selected box.
                              :  (index %9 == 2 || index%9 == 5)
                              ? Border( right: const BorderSide( width: 1.5, color: Colors.blueAccent), bottom: BorderSide( width: (index ~/9 == 2 || index ~/9 == 5)  ? 1.5 : 0.5 , color: Colors.blueAccent),
                              left : const BorderSide( width: 0.5, color: Colors.blueAccent), top: const BorderSide( width: 0.5, color: Colors.blueAccent))
                              : (index ~/9 == 2 || index ~/9 == 5)
                              ?  const Border( right: BorderSide( width: 0.5, color: Colors.blueAccent), bottom: BorderSide( width: 1.5, color: Colors.blueAccent),
                              left : BorderSide( width: 0.5, color: Colors.blueAccent), top: BorderSide( width: 0.5, color: Colors.blueAccent))
                              : Border.all(width: 0.5, color: Colors.blueAccent,),

                        ),
                        alignment: Alignment.center,

                        child: Text(
                          // Display number only if it is not zero.
                          '${sudokuGrid[ index ~/9 ][index%9] != 0 ? sudokuGrid[ index ~/9 ][index%9] : ' ' }',
                          style: TextStyle(
                            // show user input numbers in black and result number in blue.
                            // color: UserInputNumbers[ index ~/9 ][index%9]  ? Colors.black : Colors.blueAccent,
                            color: UserInputNumbers[ index ~/9 ][index%9]  ? Colors.red : Colors.blueAccent ,
                            fontWeight: UserInputNumbers[ index ~/9 ][index%9]  ? FontWeight.w600  : FontWeight.normal,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,

                        ),
                      )
                  );
                }, itemCount: 81)
            ),

            // !------------------Number Butttons-------------------!
            NumberPad(onNumberSelected: _onNumberSelected),



          ],
        ),
      ),
    );
  }
}
