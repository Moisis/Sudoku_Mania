class SudokuStatistic {
  final String difficulty;
  int gamesPlayed = 0;
  int gamesWon = 0;
  int gamesLost = 0;
  String winRate = '0%';
  int bestTimeInSeconds = 0;
  String bestTime = 'N/A';

  SudokuStatistic({required this.difficulty});

  void calculateWinRate() {
    if (gamesPlayed > 0) {
      winRate = '${((gamesWon / gamesPlayed) * 100).toStringAsFixed(2)}%';
    }
  }

  void setBestTime(int seconds) {
    bestTimeInSeconds = seconds;
    bestTime = _formatTime(seconds);
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}