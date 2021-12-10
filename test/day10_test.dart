// --- Day 10: Syntax Scoring ---
// https://adventofcode.com/2021/day/10

import 'dart:io';

import 'package:advent_of_code_2021/day10.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day10.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
        solveA(const <String>[
          '[({(<(())[]>[[{[]{<()<>>',
          '[(()[<>])]({[<{<<[]>>(',
          '{([(<{}[<>[]}>{[]{[(<()>',
          '(((({<>}<{<{<>}{[]{[]{}',
          '[[<[([]))<([[{}[[()]]]',
          '[{[{({}]{}}([{[{{{}}([]',
          '{<[[]]>}<{[{[{[]{()[[[]',
          '[<(<(<(<{}))><([]([]()',
          '<{([([[(<>()){}]>(<<{{',
          '<{([{{}}[<[[[<>{}]]]>[]]',
        ]),
        equals(26397),
      );
    });

    test('Solution', () {
      expect(solveA(input), equals(367059));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(
        solveB(const <String>[
          '[({(<(())[]>[[{[]{<()<>>',
          '[(()[<>])]({[<{<<[]>>(',
          '{([(<{}[<>[]}>{[]{[(<()>',
          '(((({<>}<{<{<>}{[]{[]{}',
          '[[<[([]))<([[{}[[()]]]',
          '[{[{({}]{}}([{[{{{}}([]',
          '{<[[]]>}<{[{[{[]{()[[[]',
          '[<(<(<(<{}))><([]([]()',
          '<{([([[(<>()){}]>(<<{{',
          '<{([{{}}[<[[[<>{}]]]>[]]',
        ]),
        equals(288957),
      );
    });

    test('Solution', () {
      expect(solveB(input), equals(1952146692));
    });
  });
}
