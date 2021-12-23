// --- Day 23: Amphipod ---
// https://adventofcode.com/2021/day/23

import 'dart:io';

import 'package:advent_of_code_2021/day23.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day23.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Part One > Solution', () {
      expect(
          solveA(const <String>[
            '#############',
            '#...........#',
            '###A#D#C#A###',
            '  #C#D#B#B#',
            '  #########',
          ]),
          equals(15367));
    });
  });

  group('Part Two', () {
    test('Part Two > Solution', () {
      expect(
        solveB(const <String>[
          '#############',
          '#...........#',
          '###A#D#C#A###',
          '  #D#C#B#A#',
          '  #D#B#A#C#',
          '  #C#D#B#B#',
          '  #########',
        ]),
        equals(52055),
      );
    });
  });
}
