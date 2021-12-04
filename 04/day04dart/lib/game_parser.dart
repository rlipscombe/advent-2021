import 'dart:io';
import 'game.dart';

class GameParser {
  static Future<Game> fromFile(path) async {
    var lines = await File(path).readAsLines();
    return fromLines(lines);
  }

  static Future<Game> fromLines(List<String> lines) async {
    var state = 0;
    List<int> calls = [];
    List<Board> boards = [];
    var builder = BoardBuilder();

    for (var line in lines) {
      if (line.isNotEmpty && state == 0) {
        calls = line
            .split(",")
            .where((s) => s.isNotEmpty)
            .map((x) => int.parse(x))
            .toList();
      } else if (line.isEmpty && state == 0) {
        state = 1;
      } else if (line.isNotEmpty && state == 1) {
        builder.addRow(line
            .split(" ")
            .where((s) => s.isNotEmpty)
            .map((x) => int.parse(x))
            .toList());
      } else if (line.isEmpty && state == 1) {
        boards.add(builder.build());
        builder = BoardBuilder();
      }
    }

    if (builder.isNotEmpty) {
      boards.add(builder.build());
    }

    return Game(calls, boards);
  }
}

class BoardBuilder {
  final List<List<int>> _lines = [];
  void addRow(line) {
    _lines.add(line);
  }

  bool get isNotEmpty => _lines.isNotEmpty;

  Board build() {
    return Board(_lines);
  }
}
