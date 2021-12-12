// --- Day 12: Passage Pathing ---
// https://adventofcode.com/2021/day/12

// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

enum SearchPath { part1, part2 }

class Graph {
  Graph();

  final Map<Node, List<Node>> nodes = <Node, List<Node>>{};

  void addNode(Node start, Node node) {
    if (!nodes.containsKey(start)) {
      nodes[start] = <Node>[];
    }
    nodes[start]!.add(node);
  }

  int getAllPaths(SearchPath path) {
    final Node start = nodes.keys.firstWhere((Node n) => n.isStart);
    return getAllPathsRec(
      current: start,
      visited: <Node>[start],
      localPath: <Node>[start],
      path: path,
    );
  }

  int getAllPathsRec({
    required Node current,
    required List<Node> visited,
    required List<Node> localPath,
    SearchPath path = SearchPath.part1,
    int paths = 0,
  }) {
    if (current.isEnd) {
      paths++;
      return paths;
    }

    visited.add(current);
    for (final Node node in nodes[current]!) {
      bool canVisitSmallRoom = node.isBig || !visited.contains(node);
      if (path == SearchPath.part2) {
        final Map<Node, int> visitTimes = getVisitTimes(visited);
        canVisitSmallRoom = !visited.contains(node) ||
            (visitTimes.values.where((int times) => times > 1).isEmpty &&
                (visitTimes.containsKey(node) && visitTimes[node]! < 2));
      }

      if (!node.isStart && (node.isBig || canVisitSmallRoom)) {
        localPath.add(node);
        paths += getAllPathsRec(
          current: node,
          visited: visited,
          localPath: localPath,
        );
        localPath.removeLast();
      }
    }
    visited.removeLast();

    return paths;
  }
}

class Node {
  Node(this.name, this.isBig, this.isStart, this.isEnd);

  final String name;
  final bool isBig;
  final bool isStart;
  final bool isEnd;

  bool equals(Node other) => name == other.name;

  @override
  bool operator ==(Object other) {
    return other is Node && name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => name;
}

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  final Graph graph = buildGraph(rawInput);
  return graph.getAllPaths(SearchPath.part1);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);
  final Graph graph = buildGraph(rawInput);
  return graph.getAllPaths(SearchPath.part2);
}

// Helpers

Graph buildGraph(List<String> rawInput) {
  final Graph graph = Graph();
  for (final String s in rawInput) {
    final List<String> parts = s.split('-');
    final Node start = Node(parts[0], parts[0].toUpperCase() == parts[0], parts[0] == 'start', parts[0] == 'end');
    final Node end = Node(parts[1], parts[1].toUpperCase() == parts[1], parts[1] == 'start', parts[1] == 'end');
    graph.addNode(start, end);
    graph.addNode(end, start);
  }
  return graph;
}

Map<Node, int> getVisitTimes(List<Node> visited) {
  final Map<Node, int> map = <Node, int>{};
  for (final Node n in visited) {
    if (!n.isBig && !n.isStart && !n.isEnd) {
      if (!map.containsKey(n)) {
        map[n] = 0;
      }
      map[n] = map[n]! + 1;
    }
  }
  return map;
}
