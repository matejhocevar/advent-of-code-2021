// --- Day 5: Hydrothermal Venture ---
// https://adventofcode.com/2021/day/5

class Grid {
  Map<String, int> grid = <String, int>{};

  void addVent(int x, int y) {
    final String key = '$x,$y';

    if (!grid.containsKey(key)) {
      grid[key] = 0;
    }

    grid[key] = grid[key]! + 1;
  }

  int calculateOverlaps() {
    return grid.values.where((int v) => v > 1).length;
  }
}

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  final Grid grid = Grid();
  for (final String line in rawInput) {
    int x1 = int.parse(line.split(' -> ')[0].split(',')[0]);
    int y1 = int.parse(line.split(' -> ')[0].split(',')[1]);
    final int x2 = int.parse(line.split(' -> ')[1].split(',')[0]);
    final int y2 = int.parse(line.split(' -> ')[1].split(',')[1]);

    // Diagonal
    if (x1 != x2 && y1 != y2) {
      continue;
    }

    // Horizontal
    if (y1 == y2) {
      while (x1 != x2) {
        grid.addVent(x1, y1);
        x1 += x1 < x2 ? 1 : -1;

        if (x1 == x2) {
          grid.addVent(x1, y1);
        }
      }
    }
    // Vertical
    else {
      while (y1 != y2) {
        grid.addVent(x1, y1);
        y1 += y1 < y2 ? 1 : -1;

        if (y1 == y2) {
          grid.addVent(x1, y1);
        }
      }
    }
  }

  return grid.calculateOverlaps();
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  final Grid grid = Grid();
  for (final String line in rawInput) {
    int x1 = int.parse(line.split(' -> ')[0].split(',')[0]);
    int y1 = int.parse(line.split(' -> ')[0].split(',')[1]);
    final int x2 = int.parse(line.split(' -> ')[1].split(',')[0]);
    final int y2 = int.parse(line.split(' -> ')[1].split(',')[1]);

    // Diagonal
    if (x1 != x2 && y1 != y2) {
      while (x1 != x2 && y1 != y2) {
        grid.addVent(x1, y1);

        x1 += x1 < x2 ? 1 : -1;
        y1 += y1 < y2 ? 1 : -1;

        if (x1 == x2 && y1 == y2) {
          grid.addVent(x1, y1);
        }
      }
    }

    // Horizontal
    if (y1 == y2) {
      while (x1 != x2) {
        grid.addVent(x1, y1);
        x1 += x1 < x2 ? 1 : -1;

        if (x1 == x2) {
          grid.addVent(x1, y1);
        }
      }
    }
    // Vertical
    else {
      while (y1 != y2) {
        grid.addVent(x1, y1);
        y1 += y1 < y2 ? 1 : -1;

        if (y1 == y2) {
          grid.addVent(x1, y1);
        }
      }
    }
  }

  return grid.calculateOverlaps();
}
