// --- Day 14: Extended Polymerization ---
// https://adventofcode.com/2021/day/14

import 'dart:math';

int solve(Iterable<String> input, {int steps = 10}) {
  final List<String> rawInput = input.toList(growable: true);

  final String template = rawInput.removeAt(0);
  rawInput.removeAt(0);
  Map<String, int> pairs = <String, int>{};
  for (int i = 0; i < template.length - 1; i++) {
    final String pair = template.substring(i, i + 2);
    pairs[pair] = (pairs[pair] ?? 0) + 1;
  }

  final Map<String, List<String>> pairMappings = <String, List<String>>{};
  for (final List<String> value in rawInput.map((String s) => s.split(' -> '))) {
    final String pair = value[0];
    final String first = pair[0];
    final String second = pair[1];
    final String element = value[1];
    pairMappings[pair] = <String>['$first$element', '$element$second'];
  }

  int step = 0;
  while (step < steps) {
    pairs = iterate(pairs, pairMappings);
    step++;
  }

  final Map<String, int> counts = countChars(pairs);
  int most = 0;
  int uncommon = counts.values.first;
  counts.forEach((String key, int value) {
    most = max(most, value);
    uncommon = min(uncommon, value);
  });

  return most - uncommon;
}

Map<String, int> countChars(Map<String, int> pairs) {
  final Map<String, int> charCount = <String, int>{};
  pairs.forEach((String key, int value) {
    final List<String> char = key.split('').toList();
    charCount[char[0]] = (charCount[char[0]] ?? 0) + value;
    charCount[char[1]] = (charCount[char[1]] ?? 0) + value;
  });
  return charCount.map((String key, int value) => MapEntry<String, int>(key, (value + 1) ~/ 2));
}

Map<String, int> iterate(Map<String, int> pairs, Map<String, List<String>> pairMappings) {
  final Map<String, int> newPairs = <String, int>{...pairs};
  pairMappings.forEach((String pattern, List<String> insert) {
    final int? value = pairs[pattern];
    if (value != null && value > 0) {
      newPairs[pattern] = (newPairs[pattern] ?? 0) - value;
      newPairs[insert[0]] = (newPairs[insert[0]] ?? 0) + value;
      newPairs[insert[1]] = (newPairs[insert[1]] ?? 0) + value;
    }
  });
  return newPairs;
}
