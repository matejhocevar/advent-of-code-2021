// --- Day 1: Sonar Sweep ---
// https://adventofcode.com/2021/day/1

import 'package:collection/collection.dart';

int solveA(Iterable<String> input) {
  final List<int> list = input.map(int.parse).toList(growable: false);

  int larger = 0;
  for (int a = 1; a < list.length; a++) {
    if (list[a] > list[a - 1]) {
      larger++;
    }
  }
  return larger;
}

int solveB(Iterable<String> input) {
  final List<int> list = input.map(int.parse).toList(growable: false);

  int larger = 0;
  for (int a = 3; a < list.length; a++) {
    // final int a0 = list[a];
    // final int a1 = list[a - 1];
    // final int a2 = list[a - 2];
    // final int a3 = list[a - 3];

    // final int windowA = a0 + a1 + a2;
    // final int windowB = a1 + a2 + a3;

    final int windowA = list.skip(a - 2).take(3).sum;
    final int windowB = list.skip(a - 3).take(3).sum;
    if (windowA > windowB) {
      larger++;
    }
  }
  return larger;
}
