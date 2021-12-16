// --- Day 16: Packet Decoder ---
// https://adventofcode.com/2021/day/16

// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
// ignore_for_file: non_constant_identifier_names

import 'dart:math';

List<int> VERSIONS = <int>[];

int solveA(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: false);

  String bits = '';
  for (final String hex in rawInput[0].split('')) {
    bits += int.parse(hex, radix: 16).toRadixString(2).padLeft(4, '0');
  }

  VERSIONS = <int>[];
  parsePacket(bits, 0);

  return VERSIONS.reduce((int a, int b) => a + b);
}

int solveB(Iterable<String> input) {
  final List<String> rawInput = input.toList(growable: false);

  String bits = '';
  for (final String hex in rawInput[0].split('')) {
    bits += int.parse(hex, radix: 16).toRadixString(2).padLeft(4, '0');
  }

  return parsePacket(bits, 0).value!;
}

MapEntry<int, int?> parsePacket(String bits, int pos) {
  if (!bits.contains('1')) {
    return MapEntry<int, int?>(pos, null);
  }

  if (pos >= bits.length) {
    return MapEntry<int, int?>(pos, null);
  }

  final int version = int.parse(bits.substring(pos, pos + 3), radix: 2);
  final int typeId = int.parse(bits.substring(pos + 3, pos + 6), radix: 2);

  VERSIONS.add(version);

  if (typeId == 4) {
    return parseLiteralGroups(bits, pos + 6);
  }

  final String lengthTypeId = bits[pos + 6];
  final List<int> subPacketLiteralValues = <int>[];

  int? posNext;
  if (lengthTypeId == '0') {
    final int subPacketLength = int.parse(bits.substring(pos + 7, pos + 22), radix: 2);
    posNext = pos + 22;
    while (posNext! < pos + 22 + subPacketLength) {
      final MapEntry<int, int?> subPacket = parsePacket(bits, posNext);
      posNext = subPacket.key;
      if (subPacket.value != null) {
        subPacketLiteralValues.add(subPacket.value!);
      }
    }
  } else if (lengthTypeId == '1') {
    final int packetCount = int.parse(bits.substring(pos + 7, pos + 18), radix: 2);
    posNext = pos + 18;
    for (int i = 0; i < packetCount; i++) {
      final MapEntry<int, int?> subPacket = parsePacket(bits, posNext!);
      posNext = subPacket.key;
      if (subPacket.value != null) {
        subPacketLiteralValues.add(subPacket.value!);
      }
    }
  } else {
    throw Exception('Unknown length type id: $lengthTypeId');
  }

  int? value;
  switch (typeId) {
    case 0:
      value = subPacketLiteralValues.reduce((int a, int b) => a + b);
      break;
    case 1:
      value = 1;
      for (final int v in subPacketLiteralValues) {
        value = value! * v;
      }
      break;
    case 2:
      value = subPacketLiteralValues.reduce(min);
      break;
    case 3:
      value = subPacketLiteralValues.reduce(max);
      break;
    case 5:
      value = subPacketLiteralValues[0] > subPacketLiteralValues[1] ? 1 : 0;
      break;
    case 6:
      value = subPacketLiteralValues[0] < subPacketLiteralValues[1] ? 1 : 0;
      break;
    case 7:
      value = subPacketLiteralValues[0] == subPacketLiteralValues[1] ? 1 : 0;
      break;
  }

  return MapEntry<int, int?>(posNext!, value);
}

MapEntry<int, int?> parseLiteralGroups(String bits, int pos) {
  final List<String> literalValuesBits = <String>[];

  while (bits[pos] == '1' && pos + 5 <= bits.length) {
    literalValuesBits.add(bits.substring(pos + 1, pos + 5));
    pos += 5;
  }

  literalValuesBits.add(bits.substring(pos + 1, pos + 5));
  pos += 5;

  final int literalValue = int.parse(literalValuesBits.join(''), radix: 2);
  return MapEntry<int, int?>(pos, literalValue);
}
