import 'dart:io';
import 'package:day04/game_parser.dart';
import 'package:test/test.dart';

void main() {
  test('fromLines', () {
    var lines = File("example").readAsLinesSync();
    var _ = GameParser.fromLines(lines);
  });
}
