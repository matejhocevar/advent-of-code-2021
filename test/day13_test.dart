// --- Day 13: Transparent Origami ---
// https://adventofcode.com/2021/day/13

import 'dart:io';

import 'package:advent_of_code_2021/day13.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day13.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(const <String>[
          '6,10',
          '0,14',
          '9,10',
          '0,3',
          '10,4',
          '4,11',
          '6,0',
          '6,12',
          '4,1',
          '0,13',
          '10,12',
          '3,4',
          '3,0',
          '8,4',
          '1,10',
          '2,14',
          '8,10',
          '9,0',
          '',
          'fold along y=7',
          'fold along x=5',
        ]),
        equals(17),
      );
    });

    test('Solution', () {
      expect(solveA(input), equals(720));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(const <String>[
          '6,10',
          '0,14',
          '9,10',
          '0,3',
          '10,4',
          '4,11',
          '6,0',
          '6,12',
          '4,1',
          '0,13',
          '10,12',
          '3,4',
          '3,0',
          '8,4',
          '1,10',
          '2,14',
          '8,10',
          '9,0',
          '',
          'fold along y=7',
          'fold along x=5',
        ]),
        equals(0),
      );
    });

    test('Solution', () {
      expect(solveB(input), equals(0));
    });
  });
}
