

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/Num_pad.dart';
import 'package:sudoku_mania/models/Sudoku.dart';

import '../components/icon_button.dart';
import '../components/pause_menu.dart';

class GamePage extends StatefulWidget {

  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  // Grid of the sudoku puzzle.
  late String difficulty;
  var sudokuGrid = List.generate(9, (i) => List.filled(9, 0, growable: false), growable: false);
  late var Oldboard ;

  //  keep the track of the numbers input by the user. (for display purpose).
  var UserInputNumbers = List.generate(9, (i) => List.filled(9, false, growable: false), growable: false);


  // coordinates of the column selected.
  var rowSelected = -1;
  var colSelected = -1;

  // indexes of the number that are repeated.
  int invalidRow1 = -1;
  int invalidCol1 = -1;
  int invalidRow2 = -1;
  int invalidCol2 = -1;

  // !-----------------------Variables -----------------------!

   var NumberOfHeartsLeft  = 3;

   bool isHeartFilled1 = true; // Change this value according to your logic
   bool isHeartFilled2 = true; // Change this value according to your logic
   bool isHeartFilled3 = true; // Change this value according to your logic

   bool isPaused = false; // Change this value according to your logic

   List<List<bool>> highlightedCells = List.generate(9, (i) => List.filled(9, false, growable: false), growable: false);

   // !-----------Timer  Start -----------------!
   Timer? _timer;
   int _secondsElapsed = 0;


  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) { // Check if the widget is still in the tree
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }


   void stopTimer() {
     _timer?.cancel();
   }

   String formatTime(int seconds) {
     final int minutes = seconds ~/ 60;
     final int remainingSeconds = seconds % 60;
     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
   }


   // !-----------Timer End -----------------!


  @override
   void didChangeDependencies() {
     super.didChangeDependencies();
     // Retrieve the arguments from the ModalRoute and initialize 'difficulty'
     difficulty = ModalRoute.of(context)!.settings.arguments as String ;
   }

  @override
   void dispose() {
     super.dispose();
     stopTimer();
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      difficulty = ModalRoute.of(context)!.settings.arguments as String ;
      _newGame();
    });

   }


   //???? Game Logic ????
   // !-----------------------New Game Function -----------------------!
   void _newGame() {
     setState(() {
       // Initialize game variables
       sudokuGrid = List.generate(9, (i) => List.filled(9, 0, growable: false), growable: false);
       UserInputNumbers = List.generate(9, (i) => List.filled(9, false, growable: false), growable: false);

       var sudoku = Sudoku(difficulty: difficulty );

       sudoku.generateSolvedPuzzle();
       sudoku.generateUnsolvedPuzzle();
       sudokuGrid = sudoku.board;

       invalidRow1 = invalidRow2 = invalidCol1 = invalidCol2 = -1; // Reset invalid indicators
       rowSelected = colSelected = -1;
       _secondsElapsed = 0;

       // Start timer and set up other game-related logic
       startTimer();
       _Control_Hearts(3); // Example function call
     });
   }

   // !-----------------------Utils  Function -----------------------!

  void _onNumberSelected(index){
    setState(() {
      if (rowSelected >= 0 && colSelected >= 0 && sudokuGrid[rowSelected][colSelected]  == 0 ) {
        sudokuGrid[rowSelected][colSelected] = index ;
        UserInputNumbers[rowSelected][colSelected] = true;
        CheckifValid(rowSelected, colSelected);
      }
    });
    //print(index);
  }

  void CheckifValid(int row, int col){
    var number = sudokuGrid[row][col];
    var isvalid = true;
    for (var i = 0; i < 9; i++) {
      if (sudokuGrid[row][i] == number && i != col) {
        isvalid = false;
        invalidRow1 = row;
        invalidCol1 = i;
        break;
      }
      if (sudokuGrid[i][col] == number && i != row) {
        isvalid = false;
        invalidRow1 = i;
        invalidCol1 = col;
        break;
      }

    }
    var startRow = (row ~/ 3) * 3;
    var startCol = (col ~/ 3) * 3;
    for (var i = startRow; i < startRow + 3; i++) {
      for (var j = startCol; j < startCol + 3; j++) {
        if (sudokuGrid[i][j] == number && i != row && j != col) {
          isvalid = false;
          invalidRow2 = i;
          invalidCol2 = j;
          break;
        }
      }
    }
    if (isvalid) {
      invalidRow1 = invalidCol1 = invalidRow2 = invalidCol2 = -1;
    }else{
      NumberOfHeartsLeft--;
      _Control_Hearts(NumberOfHeartsLeft);
    }
  }

   void highlightOccurrences(int row, int col) {
     setState(() {
       var number = sudokuGrid[row][col];
       highlightedCells = List.generate(9, (i) => List.filled(9, false, growable: false), growable: false);
       for (var i = 0; i < 9; i++) {
         highlightedCells[row][i] = true;  // Highlight the row
         highlightedCells[i][col] = true;  // Highlight the column
         if (sudokuGrid[row][i] == number) {
           highlightedCells[row][i] = true;  // Highlight occurrences in the row
         }
         if (sudokuGrid[i][col] == number) {
           highlightedCells[i][col] = true;  // Highlight occurrences in the column
         }
       }
       // Highlight occurrences in the grid
       for (var i = 0; i < 9; i++) {
         for (var j = 0; j < 9; j++) {
           if (sudokuGrid[i][j] == number) {
             highlightedCells[i][j] = true;
           }
         }
       }
     });
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


   void togglePause() {
     setState(() {
       isPaused = !isPaused;
     });
   }


   void _Control_Hearts(int NumberOfHeartsLeft){
     setState(() {
        if(NumberOfHeartsLeft == 3){
          isHeartFilled1 = true;
          isHeartFilled2 = true;
          isHeartFilled3 = true;
        }
        else if(NumberOfHeartsLeft == 2){
          isHeartFilled1 = true;
          isHeartFilled2 = true;
          isHeartFilled3 = false;
        }
        else if(NumberOfHeartsLeft == 1){
          isHeartFilled1 = true;
          isHeartFilled2 = false;
          isHeartFilled3 = false;
        }
        else if(NumberOfHeartsLeft == 0){
          isHeartFilled1 = false;
          isHeartFilled2 = false;
          isHeartFilled3 = false;
          _showGameOverDialog();
        }
     });
   }


   void _testfunction(){
     print('test');
     // setState(() {
     //   isHeartFilled2 = !isHeartFilled2;
     // });
    // _Control_Heart(3);
    // _showGameOverDialog();
   }

   void _showGameOverDialog() {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text('Game Over'),
           content: Text('Sorry, you lost the game. Try again!'),
           actions: <Widget>[
             TextButton(
               child: Text('Restart'),
               onPressed: () {
                 Navigator.of(context).pop();
                  _newGame();
                 // Reset the game state and start a new game
               },
             ),
           ],
         );
       },
     );
   }


   // !-----------------------View Page  -----------------------!

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Row(
          children: [
             Text(difficulty.toUpperCase(),
              style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold ),
            ),
            const Spacer(), // This will take up all available space, pushing the hearts to the right
            Icon(
              isHeartFilled1 ? CupertinoIcons.heart_fill : CupertinoIcons.heart_slash,
              color: isHeartFilled1 ? Colors.red : Colors.grey,
              size: 30,
            ),
            const SizedBox(width: 10),
            Icon(
              isHeartFilled2 ? CupertinoIcons.heart_fill : CupertinoIcons.heart_slash,
              color: isHeartFilled2 ? Colors.red : Colors.grey,
              size: 30,
            ),
            const SizedBox(width: 10),
            Icon(
              isHeartFilled3 ? CupertinoIcons.heart_fill : CupertinoIcons.heart_slash,
              color: isHeartFilled3 ? Colors.red : Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/background.svg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox( height: 10 ),
                // !-----------------------New Game Button-----------------------!
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: IC_button(
                        icon: const Icon(Icons.add, color: Colors.white, size: 20),
                        title: 'New Game',
                        color: Colors.blueAccent,
                        fontsize: 16,
                        onPress : _newGame,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                    // !-----------------------Pause Menu  Button-----------------------!

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: IC_button(
                            icon: const Icon(Icons.pause, color: Colors.white, size: 20),
                            title: formatTime(_secondsElapsed),
                            onPress : togglePause,
                            color: Colors.blueAccent,
                            fontsize: 16,
                          ),
                    ),
                  ],
                ),
                // !-----------------------Sudoku puzzle -----------------------!
                SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 9,
                    ), itemBuilder: (context,index){
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              rowSelected = index ~/9;
                              colSelected = index%9;
                              highlightOccurrences(rowSelected, colSelected);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (invalidRow1 ==  index ~/9 && invalidCol1 == index%9) || (invalidRow2 ==  index ~/9 && invalidCol2 == index%9)
                                  ? Colors.red[200] // show red colour for invalid boxes.
                                  : highlightedCells[index ~/ 9][index % 9] ? Colors.lightBlue[100]
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

                // !------------------Test Button-------------------!
                IC_button(
                    title: "Test",
                    onPress: _testfunction,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  color: Colors.blue,
                  fontsize: 16,
                ),
              ],
            ),
          ),

          // !-----------------------Pause Menu -----------------------!
          if (isPaused)
            PauseMenu(
              onResume: togglePause,
            ),

        ],
      ),
    );
  }
}
