// --- Day 24: Arithmetic Logic Unit ---
// https://adventofcode.com/2021/day/24

import 'dart:io';

import 'package:advent_of_code_2021/day24.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day24.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Part One > Solution', () {
      expect(solveA(input), equals(94992994195998));
    });
  });

  group('Part Two', () {
    test('Part Two > Solution', () {
      expect(solveB(input), equals(21191861151161));
    });
  });
}
