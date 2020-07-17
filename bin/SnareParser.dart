import 'package:petitparser/petitparser.dart';

import 'SnareGrammar.dart';
// POSSIBLY DON'T EVEN HAVE THIS FILE.  THE PARSER FOR DART DOESN'T HAVE SUCH A FILE
/// SnareParser
/*
PetitParser was written by Lukas Renggli as part of his work on the Helvetia system 1.
PetitParser makes it easy to define parsers with Smalltalk code and to dynamically
reuse, compose, transform and extend grammars. We can reflect on the resulting
grammars and modify them on-the-fly.

Grammar is a protocol that defines production methods.....
Grammar literals are more refined production methods, I guess.

 */
class SnareParser extends GrammarParser {
  SnareParser() : super(const SnareParserDefinition());
}

/// SNARE parser definition.
class SnareParserDefinition extends SnareGrammarDefinition {
  const SnareParserDefinition();

//  Parser noteToken() {
//    print('In SnareParserDefinition.noteToken() will create and return ref to notePrimitive.');
//    return ref(notePrimitive);
//  }

}
