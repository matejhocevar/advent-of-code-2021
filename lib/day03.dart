// --- Day 3: Binary Diagnostic ---
// https://adventofcode.com/2021/day/3

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: false);
  final List<List<int>> list = rawInput.map((String s) => s.split('').map(int.parse).toList()).toList();

  final List<int> values = List<int>.generate(list[0].length, (_) => 0);
  for (int a = 0; a < list.length; a++) {
    for (int b = 0; b < list[a].length; b++) {
      values[b] += list[a][b];
    }
  }

  final List<int> gammaList = <int>[...values];
  final List<int> epsList = <int>[...values];
  for (int a = 0; a < values.length; a++) {
    gammaList[a] = values[a] / list.length > 0.5 ? 1 : 0;
    epsList[a] = values[a] / list.length > 0.5 ? 0 : 1;
  }

  final int gamma = convertBinaryListToInt(gammaList);
  final int eps = convertBinaryListToInt(epsList);
  return gamma * eps;
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: false);
  final List<List<int>> list = rawInput.map((String s) => s.split('').map(int.parse).toList()).toList();

  final int oxygen = calculateLifeSupportRating(list: list, criteria: BitCriteria.high);
  final int co2 = calculateLifeSupportRating(list: list, criteria: BitCriteria.low);

  return oxygen * co2;
}

// Helpers

enum BitCriteria {
  low,
  high,
}

int calculateLifeSupportRating({required List<List<int>> list, required BitCriteria criteria}) {
  final List<List<int>> candidates = <List<int>>[...list];
  int pos = 0;

  while (candidates.length > 1 && pos < list[0].length) {
    int sum = 0;
    for (int a = 0; a < candidates.length; a++) {
      sum += candidates[a][pos];
    }
    int bit;

    if (criteria == BitCriteria.high) {
      bit = sum / candidates.length >= 0.5 ? 1 : 0;
    } else {
      bit = sum / candidates.length >= 0.5 ? 0 : 1;
    }

    candidates.removeWhere((List<int> l) => l[pos] != bit);
    pos++;
  }

  return convertBinaryListToInt(candidates.first);
}

int convertBinaryListToInt(List<int> list) {
  return int.parse(list.map((int x) => x.toString()).toList().join(), radix: 2);
}
