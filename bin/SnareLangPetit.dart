import 'package:petitparser/petitparser.dart';

import 'SnareGrammar.dart';
import 'SnareParser.dart';

void main(List<String> arguments) {
  print('In SnareLangPetit.dart.main() and will first create a SnareParser.');
  //final grammar = SnareGrammar();

  // this calls constructor for SnareParser, which extends GrammarParser
  // which does a GrammarDefinition which does a SnareGrammarDefinition.start
  final parser = SnareParser();
  parseMe(parser, '^8T');
  parseMe(parser, 'T');
  parseMe(parser, '8T');
  parseMe(parser, '^T');
  parseMe(parser, '^8');
  parseMe(parser, 't');
  parseMe(parser, 'F');
  parseMe(parser, 'f');
  parseMe(parser, 'D');
  parseMe(parser, 'd');
  parseMe(parser, '.');
  parseMe(parser, '^8X');
  parseMe(parser, 'X');
  parseMe(parser, '8X');
  parseMe(parser, '^X');
//  final  result = parser.parse('^8T');
//  if (result.isSuccess) {
//    print('main(), done parsing ^8T, and result: ${result.value}');
//  }
//  else {
//    print('failed to parse ^8T');
//  }
}

Result parseMe(Parser parser, String string) {
  final  result = parser.parse(string);
  if (result.isSuccess) {
    print('SnareLangPetit.dart.parseMe(), done parsing $string, and result is -->${result.value}<--');
  }
  else {
    print('SnareLangPetit.dart.parseMe(), failed to parse $string');
  }

}