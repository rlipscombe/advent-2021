import 'package:petitparser/petitparser.dart';

class GameDefinition extends GrammarDefinition {
  @override
  Parser start() =>
      ref0(calls) & Token.newlineParser().plus() & ref0(board).plus();

  Parser calls() =>
      ref0(number).separatedBy(char(','), includeSeparators: false);

  Parser<List<List<int>>> board() =>
      ref0(row).separatedBy(Token.newlineParser(), includeSeparators: false);

  Parser<List<int>> row() =>
      ref0(number).separatedBy(char(' ').plus(), includeSeparators: false);

  Parser<int> number() => digit().plus().flatten().map(int.parse);
}

class MyDefinition extends GrammarDefinition {
  @override
  Parser start() => throw UnsupportedError('todo');

  Parser line() => char(any()).plus().flatten();
  Parser verse() => ref0(line);
}
