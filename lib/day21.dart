// --- Day 21: Dirac Dice ---
// https://adventofcode.com/2021/day/21

import 'dart:math';

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  final List<int> positions = <int>[
    int.parse(rawInput[0].split('').last),
    int.parse(rawInput[1].split('').last),
  ];
  const int maxScore = 1000;
  final List<int> scores = <int>[0, 0];

  int dice = 0;
  int diceRolls = 0;
  int player = 0;
  while (scores.reduce(max) < maxScore) {
    int diceSum = 0;
    for (int i = 0; i < 3; i++) {
      dice++;
      dice %= 100;
      diceSum += dice;
    }

    diceRolls += 3;

    positions[player] = (positions[player] + diceSum - 1) % 10 + 1;
    scores[player] += positions[player];
    player = (player + 1) % 2;
  }

  return scores.reduce(min) * diceRolls;
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  final List<int> positions = <int>[
    int.parse(rawInput[0].split('').last),
    int.parse(rawInput[1].split('').last),
  ];
  final List<int> scores = <int>[0, 0];

  final List<List<int>> possibleThrows = <List<int>>[
    <int>[1, 1, 1],
    <int>[1, 1, 2],
    <int>[1, 1, 3],
    <int>[1, 2, 1],
    <int>[1, 2, 2],
    <int>[1, 2, 3],
    <int>[1, 3, 1],
    <int>[1, 3, 2],
    <int>[1, 3, 3],
    <int>[2, 1, 1],
    <int>[2, 1, 2],
    <int>[2, 1, 3],
    <int>[2, 2, 1],
    <int>[2, 2, 2],
    <int>[2, 2, 3],
    <int>[2, 3, 1],
    <int>[2, 3, 2],
    <int>[2, 3, 3],
    <int>[3, 1, 1],
    <int>[3, 1, 2],
    <int>[3, 1, 3],
    <int>[3, 2, 1],
    <int>[3, 2, 2],
    <int>[3, 2, 3],
    <int>[3, 3, 1],
    <int>[3, 3, 2],
    <int>[3, 3, 3],
  ];

  final Map<int, int> sums = <int, int>{};
  for (final List<int> s in possibleThrows) {
    final int sum = s.reduce((int a, int b) => a + b);
    if (!sums.containsKey(sum)) {
      sums[sum] = 0;
    }
    sums[sum] = sums[sum]! + 1;
  }

  assert(
    sums.length == 9 || sums.values.reduce((int a, int b) => a + b) == 27,
    'Something went wrong while calculating the sums: Current sums: ${sums.length}',
  );

  final List<int> wins = playRound(
    initialPositions: positions,
    initialScores: scores,
    player: 0,
    sums: sums,
  );
  return wins.reduce(max);
}

List<int> playRound({
  required List<int> initialPositions,
  required List<int> initialScores,
  required int player,
  required Map<int, int> sums,
}) {
  final List<int> wins = <int>[0, 0];

  for (final MapEntry<int, int> entry in sums.entries) {
    final int sum = entry.key;
    final int universes = entry.value;

    final List<int> positions = initialPositions.toList(growable: true);
    final List<int> scores = initialScores.toList(growable: true);

    positions[player] = (positions[player] + sum - 1) % 10 + 1;
    scores[player] += positions[player];

    if (scores[player] >= 21) {
      wins[player] += universes;
    } else {
      final List<int> nextWins = playRound(
        initialPositions: positions,
        initialScores: scores,
        player: (player + 1) % 2,
        sums: sums,
      );

      for (int i = 0; i < nextWins.length; i++) {
        wins[i] += nextWins[i] * universes;
      }
    }
  }

  return wins;
}
