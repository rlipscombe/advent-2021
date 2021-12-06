import 'package:day04/game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('number', () {
    var defn = GameDefinition();
    var parser = defn.build(start: defn.number);
    expect(parser.parse("13").value, 13);
  });

  test('calls', () {
    var defn = GameDefinition();
    var parser = defn.build(start: defn.calls);
    expect(parser.parse("7,4,9,5").value, [7, 4, 9, 5]);
  });

  test('row', () {
    var defn = GameDefinition();
    var parser = defn.build(start: defn.row);
    expect(parser.parse("22 13 17 11  0").value, [22, 13, 17, 11, 0]);
  });

  test('board', () {
    var input = """
22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19""";
    var defn = GameDefinition();
    var parser = defn.build(start: defn.board);
    expect(parser.parse(input).value, [
      [22, 13, 17, 11, 0],
      [8, 2, 23, 4, 24],
      [21, 9, 14, 16, 7],
      [6, 10, 3, 18, 5],
      [1, 12, 20, 15, 19]
    ]);
  });

  test('verse', () {
    var defn = MyDefinition();
    var parser = defn.build(start: defn.verse);

    var input = """
a
b
c
""";
    var expected = ["a", "b", "c"];
    expect(parser.parse(input).value, expected);
  });
}
