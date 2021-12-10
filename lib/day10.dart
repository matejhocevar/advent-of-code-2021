// --- Day 10: Syntax Scoring ---
// https://adventofcode.com/2021/day/10

const List<String> openChunks = <String>['(', '[', '{', '<'];
const List<String> closeChunks = <String>[')', ']', '}', '>'];

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  final Map<String, int> points = <String, int>{
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137,
  };

  int sum = 0;
  for (final String s in rawInput) {
    final List<String> stack = <String>[];
    for (final String c in s.split('')) {
      if (openChunks.contains(c)) {
        stack.add(c);
      } else {
        if (openChunks.indexOf(stack.last) == closeChunks.indexOf(c)) {
          stack.removeLast();
        } else {
          sum += points[c]!;
          break;
        }
      }
    }
  }

  return sum;
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  final Map<String, int> points = <String, int>{
    ')': 1,
    ']': 2,
    '}': 3,
    '>': 4,
  };

  final List<int> sums = <int>[];
  for (final String s in rawInput) {
    final List<String> stack = <String>[];
    bool isCorrupted = false;
    for (final String chunk in s.split('')) {
      if (openChunks.contains(chunk)) {
        stack.add(chunk);
      } else {
        if (openChunks.indexOf(stack.last) == closeChunks.indexOf(chunk)) {
          stack.removeLast();
        } else {
          isCorrupted = true;
          break;
        }
      }
    }

    if (!isCorrupted) {
      int sum = 0;
      for (final String item in stack.reversed) {
        final String chunk = closeChunks[openChunks.indexOf(item)];
        sum *= 5;
        sum += points[chunk]!;
      }
      sums.add(sum);
    }
  }

  sums.sort();
  return sums[sums.length ~/ 2];
}
