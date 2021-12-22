// --- Day 22: Reactor Reboot ---
// https://adventofcode.com/2021/day/22

import 'dart:math';

enum Part { part1, part2 }

class Cuboid {
  Cuboid(this.x1, this.x2, this.y1, this.y2, this.z1, this.z2);

  final int x1;
  final int x2;
  final int y1;
  final int y2;
  final int z1;
  final int z2;

  bool get isValid => x1 <= x2 && y1 <= y2 && z1 <= z2;

  int get width => x2 - x1 + 1;
  int get height => y2 - y1 + 1;
  int get depth => z2 - z1 + 1;
  int get volume => width * height * depth;

  Cuboid intersect(Cuboid other) {
    final int x1 = max(this.x1, other.x1);
    final int x2 = min(this.x2, other.x2);
    final int y1 = max(this.y1, other.y1);
    final int y2 = min(this.y2, other.y2);
    final int z1 = max(this.z1, other.z1);
    final int z2 = min(this.z2, other.z2);

    return Cuboid(x1, x2, y1, y2, z1, z2);
  }

  static List<Cuboid> sum(Cuboid a, Cuboid b) {
    final Cuboid intersect = a.intersect(b);
    if (!intersect.isValid) {
      return <Cuboid>[a];
    }

    final List<Cuboid> result = <Cuboid>[];
    if (intersect.x1 > a.x1) {
      result.add(Cuboid(a.x1, intersect.x1 - 1, a.y1, a.y2, a.z1, a.z2));
    }
    if (intersect.x2 < a.x2) {
      result.add(Cuboid(intersect.x2 + 1, a.x2, a.y1, a.y2, a.z1, a.z2));
    }
    if (intersect.y1 > a.y1) {
      result.add(Cuboid(intersect.x1, intersect.x2, a.y1, intersect.y1 - 1, a.z1, a.z2));
    }
    if (intersect.y2 < a.y2) {
      result.add(Cuboid(intersect.x1, intersect.x2, intersect.y2 + 1, a.y2, a.z1, a.z2));
    }
    if (intersect.z1 > a.z1) {
      result.add(Cuboid(intersect.x1, intersect.x2, intersect.y1, intersect.y2, a.z1, intersect.z1 - 1));
    }
    if (intersect.z2 < a.z2) {
      result.add(Cuboid(intersect.x1, intersect.x2, intersect.y1, intersect.y2, intersect.z2 + 1, a.z2));
    }
    return result;
  }

  @override
  String toString() {
    return '$x1..$x2, $y1..$y2, $z1..$z2';
  }
}

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return reboot(rawInput);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  return reboot(rawInput, part: Part.part2);
}

int reboot(List<String> input, {Part part = Part.part1}) {
  final List<String> rawInput = input.toList(growable: true);

  List<Cuboid> cuboids = <Cuboid>[];
  final List<Cuboid> temp = <Cuboid>[];

  for (String line in rawInput) {
    final bool turnOn = line.startsWith('on');
    line = line.replaceAll('on ', '');
    line = line.replaceAll('off ', '');
    line = line.replaceAll('x=', '');
    line = line.replaceAll('y=', '');
    line = line.replaceAll('z=', '');
    final List<String> parts = line.split(',');
    final List<int> x = parts[0].split('..').map((String s) => int.parse(s)).toList(growable: true);
    final List<int> y = parts[1].split('..').map((String s) => int.parse(s)).toList(growable: true);
    final List<int> z = parts[2].split('..').map((String s) => int.parse(s)).toList(growable: true);

    if (part == Part.part1 && (x[0] > 50 || y[0] > 50 || z[0] > 50 || x[1] < -50 || y[1] < -50 || z[1] < -50)) {
      continue;
    }

    final Cuboid cuboid = Cuboid(x[0], x[1], y[0], y[1], z[0], z[1]);

    for (final Cuboid c in cuboids) {
      temp.addAll(Cuboid.sum(c, cuboid));
    }

    if (turnOn) {
      temp.add(cuboid);
    }

    cuboids = <Cuboid>[...temp];
    temp.clear();
  }

  return cuboids.fold(0, (int sum, Cuboid c) => sum + c.volume);
}
