// --- Day 17: Trick Shot ---
// https://adventofcode.com/2021/day/17

import 'dart:io';

import 'package:advent_of_code_2021/day17.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day17.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(const <String>['target area: x=20..30, y=-10..-5']), equals(45));
    });

    test('Solution', () {
      expect(solveA(input), equals(4753));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(const <String>['target area: x=20..30, y=-10..-5']), equals(112));
    });

    test('Solution', () {
      expect(solveB(input), equals(1546));
    });
  });
}
