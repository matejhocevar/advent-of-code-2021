// --- Day 11: Dumbo Octopus ---
// https://adventofcode.com/2021/day/11

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  final List<List<int>> grid =
      rawInput.map((String s) => s.split('').map((String c) => int.parse(c)).toList()).toList();

  int steps = 0;
  int sum = 0;
  while (steps < 100) {
    final List<String> nextFlash = <String>[];

    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[x].length; y++) {
        grid[x][y]++;
        if (grid[x][y] == 10) {
          nextFlash.add('$x,$y');
        }
      }
    }

    while (nextFlash.isNotEmpty) {
      final int x = int.parse(nextFlash.first.split(',')[0]);
      final int y = int.parse(nextFlash.first.split(',')[1]);
      nextFlash.removeAt(0);

      if (x > 0 && y > 0) {
        grid[x - 1][y - 1]++;
        if (grid[x - 1][y - 1] == 10) {
          nextFlash.add('${x - 1},${y - 1}');
        }
      }
      if (y > 0) {
        grid[x][y - 1]++;
        if (grid[x][y - 1] == 10) {
          nextFlash.add('$x,${y - 1}');
        }
      }
      if (x < grid.length - 1 && y > 0) {
        grid[x + 1][y - 1]++;
        if (grid[x + 1][y - 1] == 10) {
          nextFlash.add('${x + 1},${y - 1}');
        }
      }
      if (x > 0) {
        grid[x - 1][y]++;
        if (grid[x - 1][y] == 10) {
          nextFlash.add('${x - 1},$y');
        }
      }
      if (x < grid.length - 1) {
        grid[x + 1][y]++;
        if (grid[x + 1][y] == 10) {
          nextFlash.add('${x + 1},$y');
        }
      }
      if (x > 0 && y < grid[x].length - 1) {
        grid[x - 1][y + 1]++;
        if (grid[x - 1][y + 1] == 10) {
          nextFlash.add('${x - 1},${y + 1}');
        }
      }
      if (y < grid[x].length - 1) {
        grid[x][y + 1]++;
        if (grid[x][y + 1] == 10) {
          nextFlash.add('$x,${y + 1}');
        }
      }
      if (x < grid.length - 1 && y < grid[x].length - 1) {
        grid[x + 1][y + 1]++;
        if (grid[x + 1][y + 1] == 10) {
          nextFlash.add('${x + 1},${y + 1}');
        }
      }
    }

    sum += countAndResetFlashes(grid);
    steps++;
  }

  return sum;
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  final List<List<int>> grid =
      rawInput.map((String s) => s.split('').map((String c) => int.parse(c)).toList()).toList();

  int steps = 0;
  while (true) {
    final List<String> nextFlash = <String>[];

    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[x].length; y++) {
        grid[x][y]++;
        if (grid[x][y] == 10) {
          nextFlash.add('$x,$y');
        }
      }
    }

    while (nextFlash.isNotEmpty) {
      final int x = int.parse(nextFlash.first.split(',')[0]);
      final int y = int.parse(nextFlash.first.split(',')[1]);
      nextFlash.removeAt(0);

      if (x > 0 && y > 0) {
        grid[x - 1][y - 1]++;
        if (grid[x - 1][y - 1] == 10) {
          nextFlash.add('${x - 1},${y - 1}');
        }
      }
      if (y > 0) {
        grid[x][y - 1]++;
        if (grid[x][y - 1] == 10) {
          nextFlash.add('$x,${y - 1}');
        }
      }
      if (x < grid.length - 1 && y > 0) {
        grid[x + 1][y - 1]++;
        if (grid[x + 1][y - 1] == 10) {
          nextFlash.add('${x + 1},${y - 1}');
        }
      }
      if (x > 0) {
        grid[x - 1][y]++;
        if (grid[x - 1][y] == 10) {
          nextFlash.add('${x - 1},$y');
        }
      }
      if (x < grid.length - 1) {
        grid[x + 1][y]++;
        if (grid[x + 1][y] == 10) {
          nextFlash.add('${x + 1},$y');
        }
      }
      if (x > 0 && y < grid[x].length - 1) {
        grid[x - 1][y + 1]++;
        if (grid[x - 1][y + 1] == 10) {
          nextFlash.add('${x - 1},${y + 1}');
        }
      }
      if (y < grid[x].length - 1) {
        grid[x][y + 1]++;
        if (grid[x][y + 1] == 10) {
          nextFlash.add('$x,${y + 1}');
        }
      }
      if (x < grid.length - 1 && y < grid[x].length - 1) {
        grid[x + 1][y + 1]++;
        if (grid[x + 1][y + 1] == 10) {
          nextFlash.add('${x + 1},${y + 1}');
        }
      }
    }

    steps++;
    if (detectSyncAndResetFlashes(grid)) {
      return steps;
    }
  }
}

// Helpers

int countAndResetFlashes(List<List<int>> grid) {
  int flashes = 0;
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      if (grid[x][y] > 9) {
        flashes++;
        grid[x][y] = 0;
      }
    }
  }
  return flashes;
}

bool detectSyncAndResetFlashes(List<List<int>> grid) {
  int flashes = 0;
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      if (grid[x][y] > 9) {
        flashes++;
        grid[x][y] = 0;
      }
    }
  }
  return flashes == grid.length * grid[0].length;
}
