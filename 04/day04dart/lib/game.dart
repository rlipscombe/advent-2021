import 'dart:async';
import 'game_parser.dart';

List<List<int>> transpose(List<List<int>> _Lines) {
  List<List<int>> result = List.generate(_Lines[0].length, (_) => []);
  for (var _Line in _Lines) {
    for (var i = 0; i < _Line.length; i++) {
      result[i].add(_Line[i]);
    }
  }
  return result;
}

class _Line {
  final List<int> _values;
  int _remaining;

  _Line(List<int> values)
      : _values = values,
        _remaining = values.reduce((value, element) => value + element);

  bool get wins => _remaining == 0;
  int get score => _remaining;

  void call(int call) {
    // XXX: Assumes calls are not duplicated.
    if (_values.contains(call)) {
      _remaining -= call;
      assert(_remaining >= 0);
    }
  }

  @override
  String toString() {
    return _values.toString();
  }
}

class Board {
  final List<_Line> _rows;
  final List<_Line> _columns;

  Board(List<List<int>> lines)
      : _rows = lines.map((x) => _Line(x)).toList(),
        _columns = transpose(lines).map((x) => _Line(x)).toList();

  bool get wins =>
      _rows.any((row) => row.wins) || _columns.any((column) => column.wins);

  get score => _rows.fold<int>(0, (sum, row) => sum + row.score);

  void call(int call) {
    for (var row in _rows) {
      row.call(call);
    }

    for (var column in _columns) {
      column.call(call);
    }
  }

  @override
  String toString() {
    return _rows[0].toString();
  }
}

class Game {
  static Future<Game> fromFile(path) async {
    return GameParser.fromFile(path);
  }

  List<int> calls;
  List<Board> boards;

  Game(this.calls, this.boards);
}
