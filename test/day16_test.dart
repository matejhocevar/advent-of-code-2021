// --- Day 16: Packet Decoder ---
// https://adventofcode.com/2021/day/16

import 'dart:io';

import 'package:advent_of_code_2021/day16.dart';
import 'package:test/test.dart';

final List<String> input = File('test/data/day16.txt').readAsLinesSync();

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(<String>['D2FE28']), 6);
      expect(solveA(<String>['38006F45291200']), 9);
      expect(solveA(<String>['EE00D40C823060']), 14);
      expect(solveA(<String>['8A004A801A8002F478']), 16);
      expect(solveA(<String>['620080001611562C8802118E34']), 12);
      expect(solveA(<String>['C0015000016115A2E0802F182340']), 23);
      expect(solveA(<String>['A0016C880162017C3686B18A3D4780']), 31);
    });

    test('Solution', () {
      expect(solveA(input), equals(981));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(<String>['C200B40A82']), 3);
      expect(solveB(<String>['04005AC33890']), 54);
      expect(solveB(<String>['880086C3E88112']), 7);
      expect(solveB(<String>['CE00C43D881120']), 9);
      expect(solveB(<String>['D8005AC2A8F0']), 1);
      expect(solveB(<String>['F600BC2D8F']), 0);
      expect(solveB(<String>['9C0141080250320F1802104A08']), 1);
    });

    test('Solution', () {
      expect(solveB(input), equals(299227024091));
    });
  });
}
