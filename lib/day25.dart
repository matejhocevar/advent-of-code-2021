// --- Day 25: Sea Cucumber ---
// https://adventofcode.com/2021/day/25

class SeaFloor {
  List<List<String>> floor = <List<String>>[];
  List<List<String>> copy = <List<String>>[];

  bool nextStep(int i) {
    bool moved = false;

    copy = cloneFloor(floor);
    for (int y = 0; y < floor.length; y++) {
      for (int x = 0; x < floor[y].length; x++) {
        moved |= moveEast(x, y);
      }
    }
    floor = cloneFloor(copy);
    copy = cloneFloor(floor);

    for (int y = 0; y < floor.length; y++) {
      for (int x = 0; x < floor[y].length; x++) {
        moved |= moveSouth(x, y);
      }
    }
    floor = cloneFloor(copy);

    return moved;
  }

  bool moveEast(int x, int y) {
    if (floor[y][x] == '>') {
      if (floor[y][(x + 1) % floor[y].length] == '.') {
        copy[y][x] = '.';
        copy[y][(x + 1) % floor[y].length] = '>';
        return true;
      }
    }
    return false;
  }

  bool moveSouth(int x, int y) {
    if (floor[y][x] == 'v') {
      if (floor[(y + 1) % floor.length][x] == '.') {
        copy[y][x] = '.';
        copy[(y + 1) % floor.length][x] = 'v';
        return true;
      }
    }

    return false;
  }

  void displayFloor() {
    for (final List<String> row in floor) {
      print(row.join());
    }
  }

  List<List<String>> cloneFloor(List<List<String>> list) {
    return list.map((List<String> row) => List<String>.from(row)).toList();
  }
}

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  final SeaFloor seaFloor = SeaFloor();
  seaFloor.floor.addAll(rawInput.map((String line) => line.split('')));

  // print('Initial state: ');
  // seaFloor.displayFloor();

  int steps = 0;
  bool moved = true;
  while (moved) {
    moved = seaFloor.nextStep(steps);
    print('\nAfter ${steps + 1} steps:');
    // seaFloor.displayFloor();
    steps++;
  }

  return steps;
}
