// --- Day 2: Dive! ---
// https://adventofcode.com/2021/day/2

int solveA(Iterable<String> input) {
  final List<String> list = input.toList(growable: false);

  int horizontal = 0;
  int depth = 0;

  for (int a = 0; a < list.length; a++) {
    final List<String> row = list[a].split(' ');
    final String command = row[0];
    final int value = int.parse(row[1]);

    switch (command) {
      case 'forward':
        horizontal += value;
        break;
      case 'down':
        depth += value;
        break;
      case 'up':
        depth -= value;
        break;
    }
  }

  return horizontal * depth;
}

int solveB(Iterable<String> input) {
  final List<String> list = input.toList(growable: false);

  int horizontal = 0;
  int depth = 0;
  int aim = 0;

  for (int a = 0; a < list.length; a++) {
    final List<String> row = list[a].split(' ');
    final String command = row[0];
    final int value = int.parse(row[1]);

    switch (command) {
      case 'forward':
        horizontal += value;
        depth += value * aim;
        break;
      case 'down':
        aim += value;
        break;
      case 'up':
        aim -= value;
        break;
    }
  }

  return horizontal * depth;
}
