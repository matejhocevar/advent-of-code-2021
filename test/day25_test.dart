// --- Day 25: Sea Cucumber ---
// https://adventofcode.com/2021/day/25

import 'dart:io';

import 'package:advent_of_code_2021/day25.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day25.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Part One > Example 1', () {
      expect(
        solveA(const <String>[
          'v...>>.vv>',
          '.vv>>.vv..',
          '>>.>v>...v',
          '>>v>>.>.v.',
          'v>v.vv.v..',
          '>.>>..v...',
          '.vv..>.>v.',
          'v.v..>>v.v',
          '....v..v.>',
        ]),
        equals(58),
      );
    });

    test('Part One > Solution', () {
      expect(solveA(input), equals(334));
    });
  });
}
