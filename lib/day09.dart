// --- Day 9: Smoke Basin ---
// https://adventofcode.com/2021/day/9

// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'dart:math' as math;

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  final List<List<int>> heightmap =
      rawInput.map((String l) => l.split('').map((String s) => int.parse(s)).toList()).toList();

  final Map<String, int> lowPoints = <String, int>{};
  for (int x = 0; x < heightmap.length; x++) {
    for (int y = 0; y < heightmap[x].length; y++) {
      if (isLowest(heightmap, x, y)) {
        lowPoints['$x,$y'] = heightmap[x][y];
      }
    }
  }

  return lowPoints.values.fold(0, (int acc, int val) => acc + (val + 1));
}

bool isLowest(List<List<int>> map, int x, int y) {
  final int value = map[x][y];

  final bool p1 = x > 0 && y > 0 ? value < map[x - 1][y - 1] : true;
  final bool p2 = y > 0 ? value < map[x][y - 1] : true;
  final bool p3 = y > 0 && x + 1 < map.length ? value < map[x + 1][y - 1] : true;
  final bool p4 = x > 0 ? value < map[x - 1][y] : true;
  final bool p6 = x + 1 < map.length ? value < map[x + 1][y] : true;
  final bool p7 = x > 0 && y + 1 < map.length ? value < map[x - 1][y + 1] : true;
  final bool p8 = y + 1 < map[x].length ? value < map[x][y + 1] : true;
  final bool p9 = x + 1 < map.length && y + 1 < map[x].length ? value < map[x + 1][y + 1] : true;

  return p1 && p2 && p3 && p4 && p6 && p7 && p8 && p9;
}

class Basin {
  Basin({required this.x, required this.y, required this.value});

  final int x;
  final int y;
  final int value;

  bool isAdjacent(Basin other) {
    return (x == other.x && (y == other.y - 1 || y == other.y + 1)) ||
        (y == other.y && (x == other.x - 1 || x == other.x + 1));
  }
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  final List<List<int>> heightmap =
      rawInput.map((String l) => l.split('').map((String s) => int.parse(s)).toList()).toList();

  final List<Basin> basins = <Basin>[];
  for (int x = 0; x < heightmap.length; x++) {
    for (int y = 0; y < heightmap[x].length; y++) {
      if (heightmap[x][y] < 9) {
        basins.add(Basin(x: x, y: y, value: heightmap[x][y]));
      }
    }
  }

  final List<List<Basin>> groups = findBasinGroups(basins);

  final List<int> sizes = groups.map((List<Basin> group) => group.length).toList();
  final List<int> largest3 = <int>[];

  while (largest3.length != 3) {
    final int max = sizes.reduce(math.max);
    largest3.add(max);
    sizes.removeAt(sizes.lastIndexWhere((int size) => size == max));
  }

  return largest3.fold(1, (int acc, int next) => acc * next);
}

List<List<Basin>> findBasinGroups(List<Basin> all) {
  final List<List<Basin>> groups = <List<Basin>>[];

  // Diving basins per groups
  while (all.isNotEmpty) {
    if (groups.isEmpty) {
      groups.add(<Basin>[all.removeAt(0)]);
    }

    bool wasAdded = false;
    for (final List<Basin> group in groups) {
      if (all.isEmpty) {
        break;
      }

      if (isBasinAdjacentToGroup(all.first, group)) {
        group.add(all.removeAt(0));
        wasAdded = true;
      }
    }

    if (!wasAdded && all.isNotEmpty) {
      groups.add(<Basin>[all.removeAt(0)]);
    }
  }

  // Merge basin groups together
  for (int i = 0; i < groups.length; i++) {
    for (int j = 0; j < groups.length; j++) {
      if (i != j) {
        if (areGroupsAdjacent(groups[i], groups[j])) {
          while (groups[j].isNotEmpty) {
            groups[i].add(groups[j].removeLast());
          }
          break;
        }
      }
    }
  }

  return groups.where((List<Basin> group) => group.isNotEmpty).toList();
}

bool isBasinAdjacentToGroup(Basin basin, List<Basin> group) {
  return group.any((Basin b) => b.isAdjacent(basin));
}

bool areGroupsAdjacent(List<Basin> groupA, List<Basin> groupB) {
  return groupB.any((Basin b) => isBasinAdjacentToGroup(b, groupA));
}
