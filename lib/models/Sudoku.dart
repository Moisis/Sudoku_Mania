import 'dart:math';

class Sudoku {
  List<List<int>> _board = [];
  List<List<int>> _solvedBoard = [];
  String difficulty ="";

  Sudoku({required this.difficulty}) {
    _board = List.generate(9, (i) => List.generate(9, (j) => 0));
    _solvedBoard = List.generate(9, (i) => List.generate(9, (j) => 0));

  }

  List<List<int>> get board => _board;
  List<List<int>> get solvedBoard => _solvedBoard;

  void generateSolvedPuzzle() {
    _initializeBoard();
    _solveSudoku();
  }

  void generateUnsolvedPuzzle() {
    int cellsToRemove;
    // Beginner: Remove 30 cells.
    // Medium: Remove 40 cells.
    // Hard: Remove  50 cells.
    // Expert: Remove  55 cells.
    switch (difficulty) {
      case "Beginner":
        cellsToRemove = 20;
        break;
      case "Easy":
        cellsToRemove = 30;
        break;
      case "Medium":
        cellsToRemove = 40;
        break;
      case "Hard":
        cellsToRemove = 50;
        break;
      case "Expert":
        cellsToRemove = 55;
        break;
      default:
        cellsToRemove = 20;
    }

    List<List<int>> positions = [];
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        positions.add([row, col]);
      }
    }

    positions.shuffle(Random.secure());

    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        _board[row][col] = _solvedBoard[row][col];
      }
    }

    for (List<int> position in positions) {
      int row = position[0];
      int col = position[1];

      if (_board[row][col] != 0 && cellsToRemove > 0) {
        int backup = _board[row][col];
        _board[row][col] = 0;

        List<List<int>> tempBoard = List.generate(9, (i) => List.from(_board[i]));
        if (!_solveSudokuFromPosition(tempBoard, 0, 0)) {
          _board[row][col] = backup;
        } else {
          cellsToRemove--;
        }
      }

      if (cellsToRemove == 0) {
        break;
      }
    }
  }

  void _initializeBoard() {
    for (int i = 0; i < 9; i += 3) {
      _fillDiagonalBox(i, i);
    }
  }

  void _fillDiagonalBox(int row, int col) {
    List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    numbers.shuffle(Random.secure());

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        _solvedBoard[row + i][col + j] = numbers[3 * i + j];
      }
    }
  }

  bool _solveSudoku() {
    return _solveSudokuFromPosition(_solvedBoard, 0, 0);
  }

  bool _solveSudokuFromPosition(List<List<int>> board, int row, int col) {
    if (row == 9) {
      return true;
    }

    if (board[row][col] != 0) {
      int nextRow = row + (col + 1) ~/ 9;
      int nextCol = (col + 1) % 9;
      return _solveSudokuFromPosition(board, nextRow, nextCol);
    }

    for (int num = 1; num <= 9; num++) {
      if (_isSafe(board, row, col, num)) {
        board[row][col] = num;

        int nextRow = row + (col + 1) ~/ 9;
        int nextCol = (col + 1) % 9;

        if (_solveSudokuFromPosition(board, nextRow, nextCol)) {
          return true;
        }

        board[row][col] = 0;
      }
    }

    return false;
  }

  bool _isSafe(List<List<int>> board, int row, int col, int num) {
    for (int i = 0; i < 9; i++) {
      if (board[row][i] == num || board[i][col] == num) {
        return false;
      }
    }

    int boxRowStart = (row ~/ 3) * 3;
    int boxColStart = (col ~/ 3) * 3;

    for (int i = boxRowStart; i < boxRowStart + 3; i++) {
      for (int j = boxColStart; j < boxColStart + 3; j++) {
        if (board[i][j] == num) {
          return false;
        }
      }
    }

    return true;
  }

  void _printBoard(List<List<int>> board) {
    for (var row in board) {
      print(row);
    }
  }
}

void main() {


  Sudoku sudoku = Sudoku(difficulty: "easy");

  print("\nSolved Sudoku Board:\n");
  for (int i = 0; i < 9; i++) {
    sudoku.generateSolvedPuzzle();
    sudoku._printBoard(sudoku.solvedBoard);
    print(" \n");
  }

  print("\nUnsolved Sudoku Board:\n");
  sudoku.generateUnsolvedPuzzle();
  sudoku._printBoard(sudoku.board);
}
