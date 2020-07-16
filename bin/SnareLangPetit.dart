import 'package:petitparser/petitparser.dart';

//import 'SnareGrammar.dart';
import 'SnareParser.dart';

void main(List<String> arguments) {
  print('In SnareLangPetit.dart.main() and will first create a SnareParser.');
  //final grammar = SnareGrammar();

  // this calls constructor for SnareParser, which extends GrammarParser
  // which does a GrammarDefinition which does a SnareGrammarDefinition.start
  final parser = SnareParser();
  print('Here is the SnareParser: ${parser.toString()}');
  print('In SnareLangPetit.dart.main() got the SnareParser and will now try parsing...');
  parseMe(parser, '^8T');
  parseMe(parser, '^8:3T');
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
  parseMe(parser, 'T F D');
  parseMe(parser, '8T 4F 5D');
}

Result parseMe(Parser parser, String string) {
  final  result = parser.parse(string);
  if (result.isSuccess) {
    print('SnareLangPetit.dart.parseMe(), Success!  Done parsing $string, and result is -->${result.value}<--');
  }
  else {
    print('SnareLangPetit.dart.parseMe(), failed to parse $string');
  }
}