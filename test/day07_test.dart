// --- Day 7: The Treachery of Whales ---
// https://adventofcode.com/2021/day/7

import 'dart:io';

import 'package:advent_of_code_2021/day07.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day07.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(const <String>[
          '16,1,2,0,4,2,7,1,2,14',
        ]),
        equals(37),
      );
    });

    test('Solution', () {
      expect(solveA(input), equals(340056));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(const <String>[
          '16,1,2,0,4,2,7,1,2,14',
        ]),
        equals(168),
      );
    });

    test('Solution', () {
      expect(solveB(input), equals(96592275));
    });
  });
}
