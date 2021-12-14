// --- Day 14: Extended Polymerization ---
// https://adventofcode.com/2021/day/14

import 'dart:io';

import 'package:advent_of_code_2021/day14.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day14.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solve(const <String>[
          'NNCB',
          '',
          'CH -> B',
          'HH -> N',
          'CB -> H',
          'NH -> C',
          'HB -> C',
          'HC -> B',
          'HN -> C',
          'NN -> C',
          'BH -> H',
          'NC -> B',
          'NB -> B',
          'BN -> B',
          'BB -> N',
          'BC -> B',
          'CC -> N',
          'CN -> C',
        ]),
        equals(1588),
      );
    });

    test('Solution', () {
      expect(solve(input), equals(2003));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(
        solve(const <String>[
          'NNCB',
          '',
          'CH -> B',
          'HH -> N',
          'CB -> H',
          'NH -> C',
          'HB -> C',
          'HC -> B',
          'HN -> C',
          'NN -> C',
          'BH -> H',
          'NC -> B',
          'NB -> B',
          'BN -> B',
          'BB -> N',
          'BC -> B',
          'CC -> N',
          'CN -> C',
        ], steps: 40),
        equals(2188189693529),
      );
    });

    test('Solution', () {
      expect(solve(input, steps: 40), equals(2276644000111));
    });
  });
}
