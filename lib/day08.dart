// --- Day 8: Seven Segment Search ---
// https://adventofcode.com/2021/day/8

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  int sum = 0;
  for (int i = 0; i < rawInput.length; i++) {
    final List<String> segments = rawInput[i].split(' | ')[0].split(' ').toList(growable: false);
    final List<String> outputs = rawInput[i].split(' | ')[1].split(' ').toList(growable: false);

    final Map<int, List<String>> groups = <int, List<String>>{};
    const int max = 10;
    for (int g = 0; g < max; g++) {
      groups[g] = segments.where((String s) => s.length == g).toList(growable: false);
    }

    final List<int> lengths = groups.values
        .where((List<String> l) => l.length == 1)
        .map((List<String> s) => s.first.length)
        .toList(growable: false);

    for (final String output in outputs) {
      if (lengths.contains(output.length)) {
        sum++;
      }
    }
  }

  return sum;
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  /*
          0:      1:      2:      3:      4:
       aaaa    ....    aaaa    aaaa    ....
      b    c  .    c  .    c  .    c  b    c
      b    c  .    c  .    c  .    c  b    c
       ....    ....    dddd    dddd    dddd
      e    f  .    f  e    .  .    f  .    f
      e    f  .    f  e    .  .    f  .    f
       gggg    ....    gggg    gggg    ....

        5:      6:      7:      8:      9:
       aaaa    aaaa    aaaa    aaaa    aaaa
      b    .  b    .  .    c  b    c  b    c
      b    .  b    .  .    c  b    c  b    c
       dddd    dddd    ....    dddd    dddd
      .    f  e    f  .    f  e    f  .    f
      .    f  e    f  .    f  e    f  .    f
       gggg    gggg    ....    gggg    gggg
  */

  int sum = 0;
  for (int i = 0; i < rawInput.length; i++) {
    final List<String> segments = rawInput[i].split(' | ')[0].split(' ').toList(growable: false);
    final List<String> outputs = rawInput[i].split(' | ')[1].split(' ').toList(growable: false);

    final Map<int, String> mapping = <int, String>{};
    int s = 0;

    while (mapping.length != 10) {
      final String segment = segments[s];
      switch (segment.length) {
        case 2:
          {
            mapping[1] = segment;
            break;
          }
        case 3:
          {
            mapping[7] = segment;
            break;
          }
        case 4:
          {
            mapping[4] = segment;
            break;
          }
        case 5:
          {
            if (mapping.keys.contains(7) && containsSubstring(segment, mapping[7]!)) {
              mapping[3] = segment;
            } else if (mapping.keys.contains(6) && containsSubstring(mapping[6]!, segment)) {
              mapping[5] = segment;
            } else if (mapping.keys.contains(3) && mapping.keys.contains(5)) {
              mapping[2] = segment;
            }
            break;
          }
        case 6:
          {
            if (mapping.keys.contains(1) && !containsSubstring(segment, mapping[1]!)) {
              mapping[6] = segment;
            } else {
              if (mapping.keys.contains(4)) {
                if (containsSubstring(segment, mapping[4]!)) {
                  mapping[9] = segment;
                } else {
                  mapping[0] = segment;
                }
              }
            }
            break;
          }
        case 7:
          {
            mapping[8] = segment;
            break;
          }
      }

      s = (s + 1) % segments.length;
    }

    String digit = '';
    for (final String output in outputs) {
      switch (output.length) {
        case 2:
          {
            digit += '1';
            break;
          }
        case 3:
          {
            digit += '7';
            break;
          }
        case 4:
          {
            digit += '4';
            break;
          }
        case 5:
          {
            if (mapping.keys.contains(7) && containsSubstring(output, mapping[7]!)) {
              digit += '3';
            } else if (mapping.keys.contains(6) && containsSubstring(mapping[6]!, output)) {
              digit += '5';
            } else if (mapping.keys.contains(3) && mapping.keys.contains(5)) {
              digit += '2';
            }
            break;
          }
        case 6:
          {
            if (mapping.keys.contains(1) && !containsSubstring(output, mapping[1]!)) {
              digit += '6';
            } else {
              if (mapping.keys.contains(4)) {
                if (containsSubstring(output, mapping[4]!)) {
                  digit += '9';
                } else {
                  digit += '0';
                }
              }
            }
            break;
          }
        case 7:
          {
            digit += '8';
            break;
          }
      }
    }

    sum += int.parse(digit);
  }

  return sum;
}

bool containsSubstring(String full, String sub) {
  for (final String a in sub.split('')) {
    if (!full.contains(a)) {
      return false;
    }
  }
  return true;
}
