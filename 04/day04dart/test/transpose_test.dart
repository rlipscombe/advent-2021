import 'package:test/test.dart';
import 'package:day04/game.dart';

void main() {
  test('2x2', () {
    var lines = [
      [1, 2],
      [3, 4]
    ];

    var expected = [
      [1, 3],
      [2, 4]
    ];

    expect(transpose(lines), expected);
  });

  test('5x5', () {
    var lines = [
      [22, 13, 17, 11, 0],
      [8, 2, 23, 4, 24],
      [21, 9, 14, 16, 7],
      [6, 10, 3, 18, 5],
      [1, 12, 20, 15, 19],
    ];

    var expected = [
      [22, 8, 21, 6, 1],
      [13, 2, 9, 10, 12],
      [17, 23, 14, 3, 20],
      [11, 4, 16, 18, 15],
      [0, 24, 7, 5, 19]
    ];

    expect(transpose(lines), expected);
  });
}
