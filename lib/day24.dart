// --- Day 24: Arithmetic Logic Unit ---
// https://adventofcode.com/2021/day/24

class ALU {
  ALU({required this.input});

  final List<int> input;
  int _index = 0;

  Map<String, int> register = <String, int>{
    'w': 0,
    'x': 0,
    'y': 0,
    'z': 0,
  };

  void execute(String instruction) {
    final List<String> i = instruction.split(' ');

    final String operation = i[0];
    final String a = i[1];
    final String? b = i.length > 2 ? i[2] : null;
    int? value;
    if (b != null) {
      value = int.tryParse(b) ?? register[b]!;
    }

    if (!register.containsKey(a)) {
      throw ArgumentError('Unknown register: $a');
    }

    switch (operation) {
      case 'inp':
        register[a] = readInput();
        break;
      case 'add':
        register[a] = register[a]! + value!;
        break;
      case 'mul':
        register[a] = register[a]! * value!;
        break;
      case 'div':
        register[a] = (register[a]! / value!).floor();
        break;
      case 'mod':
        register[a] = register[a]! % value!;
        break;
      case 'eql':
        register[a] = register[a]! == value! ? 1 : 0;
        break;
      default:
        throw 'Unknown instruction: $instruction';
    }
  }

  int readInput() {
    return input[_index++];
  }

  bool validMONAD() {
    return register['z'] == 0;
  }
}

/*
  Every time there is a `div z 1` operation, input gets added to the stack (add),
  every time there is a `div z 26` operation, input gets popped from the stack (pop).

  |------|--------------------|------------------|-----------------|----------------|
  | Step | Stack (add, pop)   | Input #          | Plus            | Compare number |
  |------|--------------------|------------------|-----------------|----------------|
  | 0    | add                | W0               | 0               | 10             |
  | 1    | add                | W1               | 6               | 12             |
  | 2    | add                | W2               | 4               | 13             |
  | 3    | add                | W3               | 2               | 13             |
  | 4    | add                | W4               | 9               | 14             |
  | 5    | pop                | W4 (from step 4) | 9 (from step 4) | -2             |
  |      | W5 == W4 + 9 - 2   | => W5 == W4 + 7  |                 |                |
  | 6    | add                | W6               | 10              | 11             |
  | 7    | pop                | W5               | 10              | -15            |
  |      | W7 == W6 + 10 - 15 | => W7 == W6 - 5  |                 |                |
  | 8    | pop                | W3 (from step 3) | 2 (from step 3) | -10            |
  |      | W8 == W3 + 2 - 10  | => W8 == W3 - 8  |                 |                |
  | 9    | add                | W9               | 6               | 10             |
  | 10   | pop                | W9 (from step 9) | 6 (from step 9) | -10            |
  |      | W10 == W9 + 6 - 10 | => W10 == W9 - 4 |                 |                |
  | 11   | pop                | W2 (from step 2) | 4               | -4             |
  |      | W11 == W2 + 4 - 4  | => W11 == W2     |                 |                |
  | 12   | pop                | W1 (from step 1) | 6               | -1             |
  |      | W12 == W1 + 6 - 1  | => W12 == W1 + 5 |                 |                |
  | 13   | pop                | W0 (from step 0) | 0               | -1             |
  |      | W13 == W0 + 0 - 1  | => W13 == W0 - 1 |                 |                |
  |------|--------------------|------------------|-----------------|----------------|

  Conditions:
    - Condition 5 -> W5 == W4 + 7
    - Condition 7 -> W7 == W6 - 5
    - Condition 8 -> W8 == W3 - 8
    - Condition 10 -> W10 == W9 - 4
    - Condition 11 -> W11 == W2
    - Condition 12 -> W12 == W1 + 5
    - Condition 13 -> W13 == W0 - 1
 */

int solveA(Iterable<String> data) {
  final List<String> instructions = data.toList(growable: true);

  final List<int> input = <int>[
    9, // 0
    4, // 1
    9, // 2
    9, // 3
    2, // 4
    9, // 5
    9, // 6
    4, // 7
    1, // 8
    9, // 9
    5, // 10
    9, // 11
    9, // 12
    8, // 13
  ];

  return repairALU(instructions: instructions, input: input);
}

int solveB(Iterable<String> data) {
  final List<String> instructions = data.toList(growable: true);

  final List<int> input = <int>[
    2, // 0
    1, // 1
    1, // 2
    9, // 3
    1, // 4
    8, // 5
    6, // 6
    1, // 7
    1, // 8
    5, // 9
    1, // 10
    1, // 11
    6, // 12
    1, // 13
  ];

  return repairALU(instructions: instructions, input: input);
}

int repairALU({required List<String> instructions, required List<int> input}) {
  assert(input[5] == input[4] + 7, 'Condition 5 failed');
  assert(input[7] == input[6] - 5, 'Condition 7 failed');
  assert(input[8] == input[3] - 8, 'Condition 8 failed');
  assert(input[10] == input[9] - 4, 'Condition 10 failed');
  assert(input[11] == input[2] + 0, 'Condition 11 failed');
  assert(input[12] == input[1] + 5, 'Condition 12 failed');
  assert(input[13] == input[0] - 1, 'Condition 13 failed');

  final ALU alu = ALU(input: input);
  instructions.forEach(alu.execute);

  if (alu.validMONAD()) {
    return int.parse(input.join(''));
  }

  throw Exception('No valid MONAD found');
}
