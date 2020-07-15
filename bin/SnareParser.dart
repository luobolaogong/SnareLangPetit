import 'package:petitparser/petitparser.dart';

import 'SnareGrammar.dart';

/// SNARE parser.
class SnareParser extends GrammarParser {
  SnareParser() : super(const SnareParserDefinition());
}

/// SNARE parser definition.
class SnareParserDefinition extends SnareGrammarDefinition {
  const SnareParserDefinition();

  // does this mean we cannot use curly braces in the music?
  Parser object() {
    print('In parser.SnareParserDefinition.object(), will create and return something.');
    return super.object().map((each) {
      final result = {};
      if (each[1] != null) {
        for (final element in each[1]) {
          result[element[0]] = element[2];
        }
      }
      print('In parser.SnareParserDefinition.object() callback or something, returning result');
      return result;
    });
  }

  Parser nullToken() {
    print('in SnareParser.SnareParserDefinition.nullToken(), and will do a super on it and return it.');
    return super.nullToken().map((each) => null);
  }
//  Parser nullToken() => super.nullToken().map((each) => null);

  Parser stringToken() {
    print('In SnareParser.SnareParserDefinition.stringToken(), '
        'and will create and return a ref to a stringPrimitive (why?) and trim it.');
    final parser = ref(stringPrimitive).trim();
    return parser;
  }

//  Parser stringToken() => ref(stringPrimitive).trim();

  Parser numberToken() =>
      super.numberToken().map((each) {
        final floating = double.parse(each);
        final integral = floating.toInt();
        if (floating == integral && each.indexOf('.') == -1) {
          return integral;
        } else {
          return floating;
        }
      });

  Parser noteToken() {
    print('In SnareParserDefinition.noteToken() will create and return ref to notePrimitive.');
    return ref(notePrimitive);
  }

  Parser stringPrimitive() {
    print('parser.stringPrimitive(), gunna create parser');
    final parser = super.stringPrimitive().map((each) => each[1].join());
    print('parser.stringPrimitive(), returning parser');
    return parser;
  }
}