import 'dart:io';
import 'package:day04/game_definition.dart';

void main(List<String> arguments) async {
  final definition = GameDefinition();

  var path = arguments[0];
  var content = await File(path).readAsString();
  print(content);
  final parser = definition.build();
  var game = parser.parse(content);
  print(game);
//   var game = await Game.fromFile(path);

//   print("calls: ${game.calls}");
//   print("boards: ${game.boards}");

//   var part1 = playToWin(game);
//   print("Part 1: $part1");

//   var game2 = await Game.fromFile(path);
//   var part2 = playToLose(game2);
//   print("Part 2: $part2");
// }

// int playToWin(Game game) {
//   for (var call in game.calls) {
//     for (var board in game.boards) {
//       board.call(call);
//       if (board.wins) {
//         print("$board wins with ${board.score}, last call $call");
//         return board.score * call;
//       }
//     }
//   }

//   return -1;
// }

// int playToLose(Game game) {
//   var score = -1;

//   List<Board> winners = [];
//   for (var call in game.calls) {
//     for (var board in game.boards) {
//       board.call(call);
//       if (board.wins && !winners.contains(board)) {
//         score = board.score * call;
//         print("$board wins with ${board.score}, last call $call");
//         winners.add(board);
//       }
//     }
//   }

//   return score;
}
