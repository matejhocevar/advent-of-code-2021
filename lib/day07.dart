// --- Day 7: The Treachery of Whales ---
// https://adventofcode.com/2021/day/7

import 'dart:math' as math;

enum FuelConsumptionMethod { basic, advanced }

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return findBestPosition(rawInput, method: FuelConsumptionMethod.basic);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return findBestPosition(rawInput, method: FuelConsumptionMethod.advanced);
}

int findBestPosition(List<String> rawInput, {FuelConsumptionMethod method = FuelConsumptionMethod.basic}) {
  final List<int> positions = rawInput.first.split(',').map((String s) => int.parse(s)).toList(growable: true);

  int min = positions.reduce(math.min);
  final int max = positions.reduce(math.max);

  num best = double.infinity;
  while (min <= max) {
    late int fuelConsumption;
    if (method == FuelConsumptionMethod.basic) {
      fuelConsumption = calculateFuelConsumption(position: min, positions: positions);
    } else {
      fuelConsumption = calculateFuelConsumptionAdvanced(position: min, positions: positions);
    }

    best = math.min(best, fuelConsumption);
    min++;
  }

  return best.toInt();
}

int calculateFuelConsumption({required int position, required List<int> positions}) {
  int sum = 0;
  for (final int p in positions) {
    sum += (p - position).abs();
  }
  return sum;
}

int calculateFuelConsumptionAdvanced({required int position, required List<int> positions}) {
  int sum = 0;
  for (final int p in positions) {
    final int distance = (p - position).abs();
    for (int i = 1; i <= distance; i++) {
      sum += i;
    }
  }
  return sum;
}
