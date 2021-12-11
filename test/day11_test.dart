// --- Day 11: Dumbo Octopus ---
// https://adventofcode.com/2021/day/10

import 'dart:io';

import 'package:advent_of_code_2021/day11.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day11.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(const <String>[
          '5483143223',
          '2745854711',
          '5264556173',
          '6141336146',
          '6357385478',
          '4167524645',
          '2176841721',
          '6882881134',
          '4846848554',
          '5283751526',
        ]),
        equals(1656),
      );
    });

    test('Solution', () {
      expect(solveA(input), equals(1705));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(const <String>[
          '5483143223',
          '2745854711',
          '5264556173',
          '6141336146',
          '6357385478',
          '4167524645',
          '2176841721',
          '6882881134',
          '4846848554',
          '5283751526',
        ]),
        equals(195),
      );
    });

    test('Solution', () {
      expect(solveB(input), equals(265));
    });
  });
}
