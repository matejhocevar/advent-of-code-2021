// --- Day 6: Lanternfish ---
// https://adventofcode.com/2021/day/6

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return countFish(days: 80, rawInput: rawInput.first);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return countFish(days: 256, rawInput: rawInput.first);
}

int countFish({required int days, required String rawInput}) {
  final List<int> input = rawInput.split(',').map((String s) => int.parse(s)).toList(growable: true);
  final List<int> state = <int>[];

  for (int i = 8; i >= 0; i--) {
    final int numOfFish = input.where((int s) => s == i).length;
    state.add(numOfFish);
  }

  while (days > 0) {
    final int zeros = state.removeLast();
    state.insert(0, zeros);
    state[2] = state[2] + zeros;

    days--;
  }

  return state.fold(0, (int a, int b) => a + b);
}
