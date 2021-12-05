import 'package:petitparser/petitparser.dart';

class GameDefinition extends GrammarDefinition {
  @override
  Parser start() =>
      ref0(calls) & Token.newlineParser().plus() & ref0(board).plus();

  Parser calls() =>
      ref0(number).separatedBy(char(','), includeSeparators: false);

  Parser board() => ref0(row).plus();

  Parser<List<int>> row() =>
      ref0(number).separatedBy(char(' ').plus(), includeSeparators: false);

  Parser<int> number() => digit().plus().flatten().trim().map(int.parse);
}

class MyDefinition extends GrammarDefinition {
  @override
  Parser start() => throw UnsupportedError('Not yet.');
  Parser commas() =>
      ref0(number).separatedBy(char(','), includeSeparators: false);
  Parser spaces() =>
      ref0(number).separatedBy(char(' '), includeSeparators: false);
  Parser<int> number() => digit().plus().flatten().trim().map(int.parse);
}
