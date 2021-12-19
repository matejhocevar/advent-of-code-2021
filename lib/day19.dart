// --- Day 19: Beacon Scanner ---
// https://adventofcode.com/2021/day/19

import 'dart:math';

enum Part { part1, part2 }

final List<dynamic> rotations = <dynamic>[
  ({required int x, required int y, required int z}) => <int>[x, y, z],
  ({required int x, required int y, required int z}) => <int>[y, z, x],
  ({required int x, required int y, required int z}) => <int>[z, x, y],
  ({required int x, required int y, required int z}) => <int>[-x, z, y],
  ({required int x, required int y, required int z}) => <int>[z, y, -x],
  ({required int x, required int y, required int z}) => <int>[y, -x, z],
  ({required int x, required int y, required int z}) => <int>[x, z, -y],
  ({required int x, required int y, required int z}) => <int>[z, -y, x],
  ({required int x, required int y, required int z}) => <int>[-y, x, z],
  ({required int x, required int y, required int z}) => <int>[x, -z, y],
  ({required int x, required int y, required int z}) => <int>[-z, y, x],
  ({required int x, required int y, required int z}) => <int>[y, x, -z],
  ({required int x, required int y, required int z}) => <int>[-x, -y, z],
  ({required int x, required int y, required int z}) => <int>[-y, z, -x],
  ({required int x, required int y, required int z}) => <int>[z, -x, -y],
  ({required int x, required int y, required int z}) => <int>[-x, y, -z],
  ({required int x, required int y, required int z}) => <int>[y, -z, -x],
  ({required int x, required int y, required int z}) => <int>[-z, -x, y],
  ({required int x, required int y, required int z}) => <int>[x, -y, -z],
  ({required int x, required int y, required int z}) => <int>[-y, -z, x],
  ({required int x, required int y, required int z}) => <int>[-z, x, -y],
  ({required int x, required int y, required int z}) => <int>[-x, -z, -y],
  ({required int x, required int y, required int z}) => <int>[-z, -y, -x],
  ({required int x, required int y, required int z}) => <int>[-y, -x, -z],
];

class Scanner {
  Scanner({required this.name});

  final int name;
  final List<Beacon> beacons = <Beacon>[];
  List<int>? position;
  int? rotation;

  void addBeacon(int x, int y, {int? z}) {
    final Beacon beacon = Beacon(x, y, z ?? 0);
    beacons.add(beacon);
  }

  void rotate(int rotation) {
    this.rotation = rotation;
    // ignore: avoid_function_literals_in_foreach_calls
    beacons.forEach((Beacon b) => b.rotate(rotation));
  }

  bool compare(Scanner other) {
    final Map<int, Map<String, int>> c = <int, Map<String, int>>{};

    for (int r = 0; r < rotations.length; r++) {
      c[r] = <String, int>{};

      for (final Beacon b1 in beacons) {
        for (final Beacon b2 in other.beacons) {
          final Beacon rotatedBeacon = Beacon(b2.x, b2.y, b2.z).rotate(r);
          final Beacon relativeBeacon = Beacon(
            b1.x - rotatedBeacon.x,
            b1.y - rotatedBeacon.y,
            b1.z - rotatedBeacon.z,
          );
          final String relation = '$relativeBeacon';
          if (!c[r]!.containsKey(relation)) {
            c[r]![relation] = 0;
          }
          c[r]![relation] = c[r]![relation]! + 1;
        }
      }

      for (final String key in c[r]!.keys) {
        final int value = c[r]![key]!;
        if (value >= 12) {
          other.position = key.split(',').map((String s) => int.parse(s)).toList();
          other.rotate(r);
          return true;
        }
      }
    }

    return false;
  }
}

class Beacon {
  Beacon(this.x, this.y, this.z);

  int x;
  int y;
  int z;

  Beacon rotate(int i) {
    // ignore: avoid_dynamic_calls
    final List<int> r = rotations[i](x: x, y: y, z: z) as List<int>;
    x = r[0];
    y = r[1];
    z = r[2];

    return this;
  }

  @override
  String toString() {
    return '$x,$y,$z';
  }
}

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return solve(rawInput);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return solve(rawInput, part: Part.part2);
}

int solve(List<String> rawInput, {Part part = Part.part1}) {
  final List<Scanner> scanners = <Scanner>[];
  Scanner? s;
  for (final String line in rawInput) {
    if (line.contains('scanner')) {
      final int scannerName = int.parse(line.split('scanner ')[1][0]);
      s = Scanner(name: scannerName);
    } else if (line.isNotEmpty) {
      final List<int> c = line.split(',').map((String s) => int.parse(s)).toList(growable: true);
      s!.addBeacon(c[0], c[1], z: c.length > 2 ? c[2] : null);
    } else {
      scanners.add(s!);
    }
  }
  scanners.add(s!);
  scanners.first.rotation = 0;
  scanners.first.position = <int>[0, 0, 0];
  final Random random = Random();

  while (scanners.where((Scanner s) => s.rotation == null).isNotEmpty) {
    final List<Scanner> unknowns = scanners.where((Scanner s) => s.rotation == null).toList();
    final Scanner unknownScanner = unknowns.length == 1 ? unknowns.first : unknowns[random.nextInt(unknowns.length)];

    final List<Scanner> knowns = scanners.where((Scanner s) => s.rotation != null).toList();
    final Scanner knownScanner = knowns.length == 1 ? knowns.first : knowns[random.nextInt(knowns.length)];

    if (knownScanner.compare(unknownScanner)) {
      unknownScanner.position = <int>[
        unknownScanner.position![0] + knownScanner.position![0],
        unknownScanner.position![1] + knownScanner.position![1],
        unknownScanner.position![2] + knownScanner.position![2],
      ];
      continue;
    }
  }

  if (part == Part.part2) {
    int maxDistance = 0;

    for (final Scanner s in scanners) {
      for (final Scanner s2 in scanners) {
        if (s == s2) {
          continue;
        }

        final int distance = (s.position![0] - s2.position![0]).abs() +
            (s.position![1] - s2.position![1]).abs() +
            (s.position![2] - s2.position![2]).abs();
        if (distance > maxDistance) {
          maxDistance = distance;
        }
      }
    }

    return maxDistance;
  }

  final Set<String> uniqueBeacons = <String>{};
  for (final Scanner s in scanners) {
    uniqueBeacons.addAll(s.beacons.map((Beacon b) {
      b.x += s.position![0];
      b.y += s.position![1];
      b.z += s.position![2];
      return '${b.x},${b.y},${b.z}';
    }));
  }

  return uniqueBeacons.length;
}
