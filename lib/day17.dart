// --- Day 17: Trick Shot ---
// https://adventofcode.com/2021/day/17

// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'dart:math';

int solveA(Iterable<String> input) {
  final String target = input.first;

  final TargetArea area = TargetArea.load(target.split(': ').last);

  int maxY = 0;
  for (int x = 0; x < area.maxX + 1; x++) {
    for (int y = area.minY; y < 100; y++) {
      final int? cY = shot(area, x, y);
      if (cY != null) {
        maxY = max(maxY, cY);
      }
    }
  }

  return maxY;
}

int solveB(Iterable<String> input) {
  final String target = input.first;
  final TargetArea area = TargetArea.load(target.split(': ').last);

  int sum = 0;
  for (int x = 0; x < area.maxX + 1; x++) {
    for (int y = area.minY; y < 10000; y++) {
      final int? cY = shot(area, x, y);
      if (cY != null) {
        sum++;
      }
    }
  }

  return sum;
}

class TargetArea {
  TargetArea({
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  });

  factory TargetArea.load(String input) {
    final List<int> x = parseCommand(input, 'x');
    final List<int> y = parseCommand(input, 'y');

    return TargetArea(
      minX: x[0],
      maxX: x[1],
      minY: y[0],
      maxY: y[1],
    );
  }

  final int minX;
  final int maxX;
  final int minY;
  final int maxY;

  bool hit(int x, int y) {
    return x >= minX && x <= maxX && y >= minY && y <= maxY;
  }

  bool surelyMissed(int x, int y) {
    return x > maxX || y < minY;
  }
}

int? shot(TargetArea area, int velocityX, int velocityY) {
  int maxY = 0;

  int x = 0;
  int y = 0;
  while (!area.hit(x, y) && !area.surelyMissed(x, y)) {
    x += velocityX;
    y += velocityY;
    maxY = max(maxY, y);

    if (velocityX > 0) {
      velocityX--;
    } else if (velocityX < 0) {
      velocityX++;
    }
    velocityY--;
  }

  if (area.hit(x, y) && !area.surelyMissed(x, y)) {
    return maxY;
  }
}

// Helpers
List<int> parseCommand(String command, String coordinate) {
  return command
      .split(', ')[coordinate == 'x' ? 0 : 1]
      .replaceFirst('$coordinate=', '')
      .split('..')
      .map((String s) => int.parse(s))
      .toList();
}
