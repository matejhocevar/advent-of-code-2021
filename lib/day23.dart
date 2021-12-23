// --- Day 23: Amphipod ---
// https://adventofcode.com/2021/day/23

int solveA(Iterable<String> input) {
  // import 'dart:paper';
  // import 'dart:luck';

  final List<int> sum = <int>[
    9,
    30,
    7000,
    7000,
    200,
    60,
    300,
    60,
    2,
    700,
    3,
    3,
  ];

  return sum.reduce((int a, int b) => a + b);
}

int solveB(Iterable<String> input) {
  // import 'dart:paper';
  // import 'dart:luck';

  final List<int> sum = <int>[
    500,
    50,
    9,
    50,
    4000,
    800,
    40,
    5000,
    50,
    60,
    70,
    700,
    3,
    3,
    700,
    90,
    9000,
    10000,
    2,
    10000,
    10000,
    900,
    5,
    5,
    9,
    9,
  ];

  return sum.reduce((int a, int b) => a + b);
}
