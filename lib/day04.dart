// --- Day 4: Giant Squid ---
// https://adventofcode.com/2021/day/4

class Board {
  final List<List<int>> board = <List<int>>[];
  final List<List<bool>> checks = <List<bool>>[];

  void addRow(List<int> row) {
    board.add(row);
    checks.add(List<bool>.generate(row.length, (_) => false));
  }

  void draw(int number) {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        if (board[i][j] == number) {
          checks[i][j] = true;
        }
      }
    }
  }

  int sumUnmarkedNumbers() {
    int sum = 0;
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        if (!checks[i][j]) {
          sum += board[i][j];
        }
      }
    }
    return sum;
  }

  bool checkIfCompleted() {
    for (int i = 0; i < checks.length; i++) {
      if (_checkRow(i) == true) {
        return true;
      }
    }

    for (int i = 0; i < checks[0].length; i++) {
      if (_checkColumn(i) == true) {
        return true;
      }
    }

    return false;
  }

  bool _checkRow(int row) {
    for (int i = 0; i < board[row].length; i++) {
      if (!checks[row][i]) {
        return false;
      }
    }
    return true;
  }

  bool _checkColumn(int column) {
    for (int i = 0; i < board.length; i++) {
      if (!checks[i][column]) {
        return false;
      }
    }
    return true;
  }
}

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  final List<int> draws = rawInput.removeAt(0).split(',').map((String s) => int.parse(s)).toList(growable: false);

  final List<Board> boards = <Board>[];
  for (int i = 0; i < rawInput.length; i++) {
    if (rawInput[i] == '') {
      boards.add(Board());
    } else {
      boards.last.addRow(rawInput[i]
          .split(' ')
          .where((String s) => s.isNotEmpty)
          .map((String s) => int.parse(s))
          .toList(growable: false));
    }
  }

  for (final int number in draws) {
    for (final Board board in boards) {
      board.draw(number);
      if (board.checkIfCompleted()) {
        return number * board.sumUnmarkedNumbers();
      }
    }
  }

  throw Exception('No solution found');
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  final List<int> draws = rawInput.removeAt(0).split(',').map((String s) => int.parse(s)).toList(growable: false);

  final List<Board> boards = <Board>[];

  for (int i = 0; i < rawInput.length; i++) {
    if (rawInput[i] == '') {
      boards.add(Board());
    } else {
      boards.last.addRow(rawInput[i]
          .split(' ')
          .where((String s) => s.isNotEmpty)
          .map((String s) => int.parse(s))
          .toList(growable: false));
    }
  }

  final List<bool> boardsCompleted = List<bool>.generate(boards.length, (_) => false);
  for (final int number in draws) {
    for (final Board board in boards) {
      board.draw(number);
      if (board.checkIfCompleted()) {
        boardsCompleted[boards.indexOf(board)] = true;

        if (boardsCompleted.where((bool completed) => !completed).isEmpty) {
          return number * board.sumUnmarkedNumbers();
        }
      }
    }
  }

  throw Exception('No solution found');
}
