import 'package:petitparser/petitparser.dart';
//import 'package:petitparser/debug.dart'; // nec for doing trace(parser)
import 'SnareParser.dart';

void main(List<String> arguments) {
  print('In SnareLangPetit.dart.main() and will first create a SnareParser, seemingly top to bottom.');
//  final parser = trace(SnareParser()); // this produces interesting output of tracing the parse tree.
  final parser = SnareParser();

  final johWalshsWalk = '24Z . ^T ^16. 48T . . 12. ^30. 30. . . ^. ^8T 24Z . . 12t 24t 12F 24t 12. 24f 12T 24. 12. 24D 32T . . . ^16T 32. . . . . 24t z t 32. . . ^.';
//  final johWalshsWalk = '''
//    24Z . ^T ^16. 48T t t    12 ^30 30 . . ^.            ^8T 24Z . .    12t 24t 12F 24t
//    12 24f 12T 24   12 24D 32T . . .   ^16T 32 . . . .   24t z t 32 . . ^.
//  ''';

  // And here’s Annette’s Chatter first bar, which is in 12/8 time (and still same note values, right?):
  final annettesChatter1 = '^16T 16z 16Z 16z 12T 12t ^12D 24T 24t 24T 24t ^12t';
  final annettesChatter2 = '^16Tz..12.^D24T...^12^tT.';



  print('In SnareLangPetit.dart.main() got the SnareParser and will now try parsing...');
  parseMe(parser, '^8T');
  parseMe(parser, '^8:3T');
  parseMe(parser, 'T');
  parseMe(parser, '8T');
  parseMe(parser, '^T');
  parseMe(parser, '^8'); // error missing type
  parseMe(parser, 't');
  parseMe(parser, 'F');
  parseMe(parser, 'f');
  parseMe(parser, 'D');
  parseMe(parser, 'd');
  parseMe(parser, '.');
  parseMe(parser, '^8X'); // error, no such type X
  parseMe(parser, 'X');// error, no such type X
  parseMe(parser, '8X');// error, no such type X
  parseMe(parser, '^X');// error, no such type X
  parseMe(parser, 'TFD'); // should be legal?
  parseMe(parser, 'T F D'); // should be legal
  parseMe(parser, '8T 4:5F 5D');
  parseMe(parser, 'library');
  parseMe(parser, 'import');
  parseMe(parser, 'import whatever;');
  parseMe(parser, '// fritz');
//  parseMe(parser, '// fritz \n // more');
  //parseMe(parser, '\n');
  parseMe(parser, johWalshsWalk);
}

Result parseMe(Parser parser, String string) {
  final  result = parser.parse(string);
  if (result.isSuccess) {
    print('SnareLangPetit.dart.parseMe(), Success!  Done parsing $string, and result value is -->${result.value}<--');
  }
  else {
    print('SnareLangPetit.dart.parseMe(), failed to parse $string');
    print(string);
    print(' ' * result.position + '^');
  }
  return result;
}