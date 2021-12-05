import 'package:day04/game_definition.dart';
import 'package:test/test.dart';

void main() {
  // test('number', () {
  //   var defn = GameDefinition();
  //   var parser = defn.build(start: defn.number);
  //   expect(parser.parse("13").value, 13);
  // });

  // test('calls', () {
  //   var defn = GameDefinition();
  //   var parser = defn.build(start: defn.calls);
  //   expect(parser.parse("7,4,9,5").value, [7, 4, 9, 5]);
  // });

  // test('row', () {
  //   var defn = GameDefinition();
  //   var parser = defn.build(start: defn.row);
  //   expect(parser.parse("22 13 17 11  0").value, [22, 13, 17, 11, 0]);
  // });

  test('commas', () {
    var defn = MyDefinition();
    var parser = defn.build(start: defn.commas);
    expect(parser.parse("7,4,9,5").value, [7, 4, 9, 5]);
  });

  test('spaces', () {
    var defn = MyDefinition();
    var parser = defn.build(start: defn.spaces);
    expect(parser.parse("7  4 9    5").value, [7, 4, 9, 5]);
  });
}
