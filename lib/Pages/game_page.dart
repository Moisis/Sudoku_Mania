

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/num_pad.dart';
import 'package:sudoku_mania/models/Sudoku.dart';

import '../components/icon_button.dart';
import '../components/pause_menu.dart';

class GamePage extends StatefulWidget {

  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  // !-----------------------Variables -----------------------!

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
    // Check if the timer is already running
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) { // Check if the widget is still in the tree
          setState(() {
            _secondsElapsed++;
          });
        }
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null; // Set _timer to null to indicate that the timer is not running
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
       highlightedCells = List.generate(9, (i) => List.filled(9, false, growable: false), growable: false);


       var sudoku = Sudoku(difficulty: difficulty );

       sudoku.generateSolvedPuzzle();
       sudoku.generateUnsolvedPuzzle();
       sudokuGrid = sudoku.board;
       Oldboard = sudoku.solvedBoard;

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
        if (isBoardFilledCorrectly()) {
          _showGameWonDialog();
        }
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
    print(isvalid);
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
      if (number == 0) {
        return;
      }
      // Highlight the selected row and column
      for (var i = 0; i < 9; i++) {
        highlightedCells[row][i] = true;  // Highlight the row
        highlightedCells[i][col] = true;  // Highlight the column
      }

      // Highlight occurrences of the number in the entire grid
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
          if (sudokuGrid[i][j] == number) {
            highlightedCells[i][j] = true;
          }
        }
      }
    });
  }


  void removenumber(){
    setState(() {
      if (!UserInputNumbers[rowSelected][colSelected]  && (rowSelected == -1 || colSelected == -1)) {
        return;
      }else {
        sudokuGrid[rowSelected][colSelected] = 0;
        UserInputNumbers[rowSelected][colSelected] = false;
        invalidRow1 = invalidCol1 = invalidRow2 = invalidCol2 = -1;
      }
    });
  }

  // !-----------------------Pause Menu  -----------------------!


   void togglePause() {
     setState(() {
       isPaused = !isPaused;
     });
   }
  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Confirmation',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Do you really want to go back?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Return false to not pop
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('No' , style: TextStyle(color: Colors.white)  ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true); // Return true to pop
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Yes', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ) ?? false; // If the dialog is dismissed by tapping outside
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
     _showGameOverDialog();
     // setState(() {
     //   isHeartFilled2 = !isHeartFilled2;
     // });
    // _Control_Heart(3);
    // _showGameOverDialog();
   }

   // !-----------------------Game Over Screens  -----------------------!

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 10),
              Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          content: Text(
            'Sorry, you lost the game. \nTry again!',
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              child: Text(
                'Restart',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _newGame();
                // Reset the game state and start a new game
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              child: Text(
                'Back to Main Menu',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //_backToMainMenu();
                // Navigate back to the main menu
              },
            ),
          ],
        );
      },
    );
  }

  void _showGameWonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.emoji_events, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Great Job! You have successfully completed the Sudoku puzzle!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Time taken: ${formatTime(_secondsElapsed)}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              child: Text(
                'New Game',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _newGame();
                // Reset the game state and start a new game
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              child: const Text(
                'Back to Main Menu',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //_backToMainMenu();
                // Reset the game state and return to the main menu
              },
            ),
          ],
        );
      },
    );
  }

  bool isBoardFilledCorrectly() {
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        if (sudokuGrid[i][j] == 0 || sudokuGrid[i][j] != Oldboard[i][j]) {
          return false;
        }
      }
    }
    return true;
  }



  // !-----------------------View Page  -----------------------!

  @override
  Widget build(BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await _showConfirmationDialog(context) ;
          if (context.mounted && shouldPop) {
            Navigator.pop(context);
          }
        },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
               Text(difficulty,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox( height: 10 ),

                  Row(
                    children: [
                      // !-----------------------New Game Button-----------------------!
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: IC_button(
                          height: 40,
                          width: 40,
                          icon: const Icon(Icons.add, color: Colors.white, size: 20),
                          title: 'New Game',
                          color: Colors.blueAccent,
                          fontsize: 16,
                          onPress : _newGame,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.25),
      // !-----------------------Pause Menu  Button-----------------------!
                      Flexible(
                        child: IC_button(
                          height: 40,
                          width: MediaQuery.of(context).size.width *0.35 , // Added width parameter
                          icon: const Icon(Icons.pause, color: Colors.white, size: 20),
                          title: formatTime(_secondsElapsed),
                          onPress : togglePause,
                          color: Colors.blueAccent,
                          fontsize: 16,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),
                  // !-----------------------Sudoku puzzle -----------------------!
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 9,
                      ),
                      itemBuilder: (context, index) {
                        int row = index ~/ 9;
                        int col = index % 9;

                        // Determine the border thickness for 3x3 grid separation
                        double topBorder = row % 3 == 0 ? 1.0 : 0.5;
                        double leftBorder = col % 3 == 0 ? 1.0 : 0.5;
                        double rightBorder = (col + 1) % 3 == 0 ? 1.0 : 0.5;
                        double bottomBorder = (row + 1) % 3 == 0 ? 1.0 : 0.5;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              rowSelected = row;
                              colSelected = col;
                              highlightOccurrences(rowSelected, colSelected);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (invalidRow1 == row && invalidCol1 == col) || (invalidRow2 == row && invalidCol2 == col)
                                  ? Colors.red[200] // Invalid boxes
                                  : (row == rowSelected && col == colSelected)
                                  ? Colors.lightBlueAccent // Selected box
                                  : highlightedCells[row][col]
                                  ? (row == rowSelected || col == colSelected)
                                  ? Colors.lightBlue[100] // Selected row or column
                                  : Colors.lightBlue[300] // Other occurrences
                                  : Colors.white, // Default color
                              border: Border(
                                top: BorderSide(width: topBorder, color: Colors.blueAccent),
                                left: BorderSide(width: leftBorder, color: Colors.blueAccent),
                                right: BorderSide(width: rightBorder, color: Colors.blueAccent),
                                bottom: BorderSide(width: bottomBorder, color: Colors.blueAccent),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${sudokuGrid[row][col] != 0 ? sudokuGrid[row][col] : ' '}',
                              style: TextStyle(
                                color: UserInputNumbers[row][col] ? Colors.black : const Color(0xFF232E7A),
                                fontWeight: UserInputNumbers[row][col] ? FontWeight.w600 : FontWeight.normal,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                      itemCount: 81,
                    ),
                  ),

                  // !------------------Number Pad -------------------!
                  NumberPad(
                      onNumberSelected: _onNumberSelected ,
                      onClear: removenumber,
                  ),

                  // !------------------Test Button-------------------!
                  // IC_button(
                  //     height: 70,
                  //     width: 200,
                  //     title: "Test",
                  //     onPress: _testfunction,
                  //     icon: const Icon(
                  //       Icons.add,
                  //       color: Colors.white,
                  //     ),
                  //   color: Colors.blue,
                  //   fontsize: 16,
                  // ),
                  const Spacer(),
                ],
              ),
            ),

            // !-----------------------Pause Menu -----------------------!
            if (isPaused)
              PauseMenu(
                onResume: togglePause,
                onRestart: _newGame,
                onReturnToMainMenu: () {
                  Navigator.of(context).pop();
                  //_backToMainMenu();
                },
              ),

          ],
        ),
      ),
    );
  }


}
