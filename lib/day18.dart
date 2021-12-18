// --- Day 18: Snailfish ---
// https://adventofcode.com/2021/day/18

// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

class Explosion {
  Explosion({required this.result, this.left, this.right, this.exploded = false});

  final dynamic result;
  final dynamic left;
  final dynamic right;
  final bool exploded;
}

class Split {
  Split({required this.result, this.split = false});

  final dynamic result;
  final bool split;
}

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  dynamic result = json.decode(rawInput[0]);
  for (final String line in rawInput.skip(1)) {
    result = addition(result, json.decode(line));
  }

  return magnitude(result);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: true);

  int max = 0;
  dynamic result = json.decode(rawInput[0]);
  for (final String line in rawInput.skip(1)) {
    result = addition(result, json.decode(line));
  }

  for (int i = 0; i < rawInput.length; i++) {
    for (int j = 0; j < rawInput.length; j++) {
      if (i != j) {
        final int m = magnitude(addition(json.decode(rawInput[i]), json.decode(rawInput[j])));
        if (m > max) {
          max = m;
        }
      }
    }
  }

  return max;
}

dynamic addition(dynamic a, dynamic b) {
  dynamic result = <dynamic>[a, b];

  while (true) {
    final Explosion explosion = explode(result);
    result = explosion.result;
    if (explosion.exploded) {
      continue;
    }

    final Split s = split(result);
    result = s.result;
    if (!s.split) {
      break;
    }
  }

  return result;
}

Explosion explode(dynamic input, {int n = 4}) {
  if (input is int) {
    return Explosion(result: input);
  }

  if ((input as List<dynamic>).isEmpty) {
    return Explosion(result: input);
  }

  if (n == 0) {
    return Explosion(result: 0, left: input[0], right: input[1], exploded: true);
  }

  final dynamic a = input[0];
  final dynamic b = input[1];

  final Explosion leftExplosion = explode(a, n: n - 1);
  if (leftExplosion.exploded) {
    return Explosion(
      result: <dynamic>[leftExplosion.result, addLeft(b, leftExplosion.right as int?)],
      left: leftExplosion.left,
      right: null,
      exploded: true,
    );
  }

  final Explosion rightExplosion = explode(b, n: n - 1);
  if (rightExplosion.exploded) {
    return Explosion(
      result: <dynamic>[addRight(a, rightExplosion.left as int?), rightExplosion.result],
      left: null,
      right: rightExplosion.right,
      exploded: true,
    );
  }

  return Explosion(result: input);
}

dynamic addLeft(dynamic input, int? n) {
  if (n == null) {
    return input;
  }

  if (input is int) {
    return input + n;
  }

  if ((input as List<dynamic>).isEmpty) {
    return input;
  }

  return <dynamic>[addLeft(input[0], n), input[1]];
}

dynamic addRight(dynamic input, int? n) {
  if (n == null) {
    return input;
  }

  if (input is int) {
    return input + n;
  }

  if ((input as List<dynamic>).isEmpty) {
    return input;
  }

  return <dynamic>[input[0], addRight(input[1], n)];
}

Split split(dynamic input) {
  if (input is int) {
    if (input > 9) {
      return Split(result: <dynamic>[input ~/ 2, (input / 2).ceil()], split: true);
    }
    return Split(result: input);
  }

  if ((input as List<dynamic>).isEmpty) {
    return Split(result: input);
  }

  final dynamic a = input[0];
  final dynamic b = input[1];

  final Split sa = split(a);
  if (sa.split) {
    return Split(result: <dynamic>[sa.result, b], split: true);
  }

  final Split sb = split(b);
  return Split(result: <dynamic>[a, sb.result], split: sb.split);
}

int magnitude(dynamic input) {
  if (input is int) {
    return input;
  }

  return 3 * magnitude(input[0]) + 2 * magnitude(input[1]);
}
