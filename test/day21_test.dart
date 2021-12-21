// --- Day 21: Dirac Dice ---
// https://adventofcode.com/2021/day/21

import 'dart:io';

import 'package:advent_of_code_2021/day21.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day21.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(const <String>[
          'Player 1 starting position: 4',
          'Player 2 starting position: 8',
        ]),
        equals(739785),
      );
    });

    test('Solution', () {
      expect(solveA(input), equals(679329));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(const <String>[
          'Player 1 starting position: 4',
          'Player 2 starting position: 8',
        ]),
        equals(444356092776315),
      );
    });

    test('Solution', () {
      expect(solveB(input), equals(433315766324816));
    });
  });
}
