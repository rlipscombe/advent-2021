import 'package:day04/game.dart';

void main(List<String> arguments) async {
  var path = arguments[0];
  var game = await Game.fromFile(path);

  print("calls: ${game.calls}");
  print("boards: ${game.boards}");

  var score = play(game);
  print("$score");
}

int play(Game game) {
  for (var call in game.calls) {
    for (var board in game.boards) {
      board.call(call);
      if (board.wins) {
        print("$board wins");
        return board.score * call;
      }
    }
  }

  return -1;
}
