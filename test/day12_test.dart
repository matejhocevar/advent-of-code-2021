// --- Day 12: Passage Pathing ---
// https://adventofcode.com/2021/day/12

import 'dart:io';

import 'package:advent_of_code_2021/day12.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day12.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(const <String>[
          'fs-end',
          'he-DX',
          'fs-he',
          'start-DX',
          'pj-DX',
          'end-zg',
          'zg-sl',
          'zg-pj',
          'pj-he',
          'RW-he',
          'fs-DX',
          'pj-RW',
          'zg-RW',
          'start-pj',
          'he-WI',
          'zg-he',
          'pj-fs',
          'start-RW',
        ]),
        equals(226),
      );
    });

    test('Solution', () {
      expect(solveA(input), equals(3713));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(const <String>[
          'fs-end',
          'he-DX',
          'fs-he',
          'start-DX',
          'pj-DX',
          'end-zg',
          'zg-sl',
          'zg-pj',
          'pj-he',
          'RW-he',
          'fs-DX',
          'pj-RW',
          'zg-RW',
          'start-pj',
          'he-WI',
          'zg-he',
          'pj-fs',
          'start-RW',
        ]),
        equals(226),
      );
    });

    test('Solution', () {
      expect(solveB(input), equals(3713));
    });
  });
}
