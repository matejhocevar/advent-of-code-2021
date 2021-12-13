// --- Day 13: Transparent Origami ---
// https://adventofcode.com/2021/day/13

import 'dart:math' as math;

enum Part { part1, part2 }

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: false);
  return foldPaper(rawInput);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: false);
  return foldPaper(rawInput, part: Part.part2);
}

int foldPaper(List<String> rawInput, {Part part = Part.part1}) {
  const int size = 2000;
  final List<List<String>> paper =
      List<List<String>>.generate(size, (_) => List<String>.filled(size, '.', growable: true), growable: true);

  int maxX = 0;
  int maxY = 0;
  for (final String s in rawInput) {
    if (!s.startsWith('fold') && s.isNotEmpty) {
      final int x = int.parse(s.split(',')[0]);
      final int y = int.parse(s.split(',')[1]);
      maxX = math.max(maxX, x);
      maxY = math.max(maxY, y);
      paper[y][x] = '#';
    }

    if (s.isEmpty) {
      paper.length = maxY + 1;
      for (int a = 0; a < paper.length; a++) {
        paper[a].length = maxX + 1;
      }
    }

    if (s.startsWith('fold along x')) {
      final int x = int.parse(s.split('=')[1]);
      for (int a = 0; a < paper.length; a++) {
        final List<String> right = paper[a].reversed.toList();
        paper[a] = mergeLines(paper[a], right);
        paper[a].length = x;
      }

      if (part == Part.part1) {
        return sumDots(paper);
      }
    }

    if (s.startsWith('fold along y')) {
      final int y = int.parse(s.split('=')[1]);
      final List<List<String>> bottom = paper.skip(y).toList().reversed.toList();
      for (int a = 0; a < bottom.length; a++) {
        paper[a] = mergeLines(paper[a], bottom[a]);
      }
      paper.length = y;

      if (part == Part.part1) {
        return sumDots(paper);
      }
    }
  }

  displayPaper(paper);
  return 0;
}

List<String> mergeLines(List<String> a, List<String> b) {
  for (int i = 0; i < a.length; i++) {
    if (a[i] == '#' || b[i] == '#') {
      a[i] = '#';
    }
  }
  return a;
}

int sumDots(List<List<String>> paper) {
  int sum = 0;
  for (int a = 0; a < paper.length; a++) {
    for (int b = 0; b < paper[a].length; b++) {
      if (paper[a][b] == '#') {
        sum++;
      }
    }
  }
  return sum;
}

void displayPaper(List<List<String>> paper) {
  for (int a = 0; a < paper.length; a++) {
    print(paper[a].join(''));
  }
}
