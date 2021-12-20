// --- Day 20: Trench Map ---
// https://adventofcode.com/2021/day/20

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return enhanceImage(rawInput, steps: 2);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return enhanceImage(rawInput, steps: 50);
}

int enhanceImage(List<String> rawInput, {int steps = 2}) {
  final List<String> enhancementAlgorithm = rawInput.first.split('').toList();
  List<List<String>> image = <List<String>>[];
  for (final String line in rawInput.skip(2)) {
    image.add(line.split('').toList(growable: true));
  }

  while (steps > 0) {
    final int backgroundBit = (enhancementAlgorithm[0] == '#' ? 1 : 0) & (steps % 2);
    final List<List<String>> newImage = <List<String>>[];
    for (int i = -1; i < image.length + 1; i++) {
      final List<String> newImageRow = <String>[];
      for (int j = -1; j < image[0].length + 1; j++) {
        final List<int> bits = <int>[];
        for (int di = -1; di <= 1; di++) {
          for (int dj = -1; dj <= 1; dj++) {
            final int x = i + di;
            final int y = j + dj;
            if (x < 0 || x >= image.length || y < 0 || y >= image[0].length) {
              bits.add(backgroundBit);
            } else if (image[x][y] == '.') {
              bits.add(0);
            } else {
              bits.add(1);
            }
          }
        }
        final int number = int.parse(bits.join(''), radix: 2);
        final String pixel = enhancementAlgorithm[number];
        newImageRow.add(pixel);
      }
      newImage.add(newImageRow);
    }
    image = newImage;

    steps--;
  }

  return image.fold(0, (int sum, List<String> row) {
    return sum +
        row.fold(0, (int sum, String pixel) {
          return sum + (pixel == '#' ? 1 : 0);
        });
  });
}
