// --- Day 3: Binary Diagnostic ---
// https://adventofcode.com/2021/day/3

import 'dart:io';

import 'package:advent_of_code_2021/day03.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day03.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(const <String>[
          '00100',
          '11110',
          '10110',
          '10111',
          '10101',
          '01111',
          '00111',
          '11100',
          '10000',
          '11001',
          '00010',
          '01010',
        ]),
        equals(198),
      );
    });

    test('Solution', () {
      expect(solveA(input), equals(4006064));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(const <String>[
          '00100',
          '11110',
          '10110',
          '10111',
          '10101',
          '01111',
          '00111',
          '11100',
          '10000',
          '11001',
          '00010',
          '01010',
        ]),
        equals(230),
      );
    });

    test('Solution', () {
      expect(solveB(input), equals(5941884));
    });
  });
}
