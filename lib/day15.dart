// --- Day 15: Chiton ---
// https://adventofcode.com/2021/day/15

// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: false);
  final List<List<int>> graph = rawInput.map((String l) => l.split('').map(int.parse).toList()).toList();

  return findShortestPath(graph);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: false);
  final List<List<int>> originalGraph =
      rawInput.map((String l) => l.split('').map(int.parse).toList(growable: true)).toList(growable: true);

  final List<List<int>> graph = List<List<int>>.generate(
      originalGraph[0].length * 5, (_) => List<int>.generate(originalGraph.length * 5, (int i) => 0));

  for (int p = 0; p < 25; p++) {
    final int pX = p ~/ 5;
    final int pY = p % 5;

    for (int x = 0; x < originalGraph[0].length; x++) {
      for (int y = 0; y < originalGraph.length; y++) {
        graph[x + pX * originalGraph[x].length][y + pY * originalGraph.length] =
            (originalGraph[x][y] + pX + pY - 1) % 9 + 1;
      }
    }
  }

  return findShortestPath(graph);
}

class Node {
  Node(this.x, this.y, this.risk);

  final int x;
  final int y;
  int risk;

  bool equals(Node other) => x == other.x && y == other.y;

  @override
  bool operator ==(Object other) {
    return other is Node && x == other.x && y == other.y;
  }

  @override
  int get hashCode => '$x,$y'.hashCode;

  @override
  String toString() {
    return '$x,$y,$risk';
  }
}

List<Node> getCandidates(List<List<int>> graph, int x, int y) {
  final List<Node> candidates = <Node>[];
  if (x > 0) {
    candidates.add(Node(x - 1, y, graph[x - 1][y]));
  }
  if (y > 0) {
    candidates.add(Node(x, y - 1, graph[x][y - 1]));
  }
  if (y < graph[x].length - 1) {
    candidates.add(Node(x, y + 1, graph[x][y + 1]));
  }
  if (x < graph.length - 1) {
    candidates.add(Node(x + 1, y, graph[x + 1][y]));
  }
  return candidates;
}

int findShortestPath(List<List<int>> graph) {
  final Node start = Node(0, 0, graph[0][0]);
  final Node end = Node(graph[0].length - 1, graph.length - 1, graph.last.last);

  final List<Node> todo = <Node>[start];
  final List<Node> visited = <Node>[];
  int? best;

  while (todo.isNotEmpty) {
    todo.sort((Node a, Node b) => a.risk - b.risk);
    final Node current = todo.removeAt(0);
    int cost = current.risk;
    if (best == null || current.risk < best) {
      final List<Node> candidates = getCandidates(graph, current.x, current.y);
      for (final Node candidate in candidates) {
        if (candidate == end) {
          cost += candidate.risk;
          if (best == null || cost < best) {
            return cost - start.risk;
          }
        }
        if (!visited.contains(candidate)) {
          todo.add(candidate);
          candidate.risk += cost;
          visited.add(candidate);
        }
      }
    }
  }

  return best ?? -1;
}
