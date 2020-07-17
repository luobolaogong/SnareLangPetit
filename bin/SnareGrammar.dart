import 'package:petitparser/petitparser.dart';
// documentatin for petit parser is at https://pub.dev/documentation/petitparser/latest/
// Seems there are different libraries.  Maybe all available when load one.
/// Snare grammar.
class SnareGrammar extends GrammarParser {
  SnareGrammar() : super(const SnareGrammarDefinition());
}

class SnareGrammarDefinition extends GrammarDefinition {
  const SnareGrammarDefinition(); // nec?

  // I don't understand "ref()", and I don't understand "token()"
  // You can do input.token(), and ref(token), and
  /**
   * Create and return a flattened and trimmed Parser,
   * or if we just have a string, create and return a
   * Parser for it, I guess.
   */
  Parser token(Object input, [String name]) {
    if (input is Parser) {
      print('In SnareGrammar.SnareGrammarDefinition.token(), '
          'source is a parser, so will flatten and trim it.');
//      return input.flatten('Expected $name').trim();
      return input.token().trim(ref(HIDDEN_STUFF));
    }
    else if (input is String) {
      print('In SnareGrammar.SnareGrammarDefinition.token(), '
          'source is a string -->$input<--');
      return token(input.toParser(message: 'Expected ${name ?? input}').trim());
//      return input.toParser(message: 'Expected ${name ?? input}').trim();
    }
    else {
      throw ArgumentError('Unknown token type: $input');
    }
  }
//  Parser token(Object input, [String name]) {
//    if (input is String) {
//      print('In SnareGrammar.SnareGrammarDefinition.token(), '
//          'source is a string -->$input<--');
//      return input.toParser(message: 'Expected ${name ?? input}').trim();
//    } else if (input is Parser) {
//      ArgumentError.checkNotNull(name, 'name');
//      print('In SnareGrammar.SnareGrammarDefinition.token(), '
//          'source is a parser, so will flatten and trim it.');
//      return input.flatten('Expected $name').trim(); // happens: ...
//    } else {
//      throw ArgumentError('Unknown token type: $input.');
//    }
//  }
//  Parser token(Object input) {
//    if (input is Parser) {
//      return input.token().trim(ref(HIDDEN_STUFF));
//    } else if (input is String) {
//      return token(input.toParser());
//    } else if (input is Function) {
//      return token(ref(input));
//    }
//    throw ArgumentError.value(input, 'invalid token parser');
//  }
  // -----------------------------------------------------------------
  // Keyword definitions.
  // -----------------------------------------------------------------
  Parser BREAK() => ref(token, 'break'); // means 'break' can be in input
  Parser VAR() => ref(token, 'var'); // means that 'var' can be in input
  // Pseudo-keywords that should also be valid identifiers.
  Parser IMPORT() => ref(token, 'import');
  Parser LIBRARY() => ref(token, 'library');
  Parser SET() => ref(token, 'set');

  // -----------------------------------------------------------------
  // Grammar productions.
  // -----------------------------------------------------------------
  Parser start() {
    print('In SnareGrammar.dart.SnareGrammarDefinition.start() '
        'and will return a Parser for a ref value followed by an end');
    //print('value is $value'); // Closure: () => Parser<dynamic> from Function 'value':
//    return ref(noteParser).end();
    return ref(notes).end();
//    return ref(value).end();

  }

  Parser notes() =>
      ref(noteParser) & whitespace().plus() & ref(notes)
      | ref(noteParser);
  // flatten

//  Parser notes() {
    //    final something = ref(noteParser).star(); // could also use Parser.matchesSkipping somewhere?
//    return something;

//    print('In SnareGrammar.value(), will return a parser based on the'
//        ' existence of a ref to something based on precedence, maybe');
//    // Is this how to do precedence?
//    //    return ref(noteToken) | ref(stringToken) | ref(nullToken);
//
//    return ref(noteTokenParser);
//  }



  Parser noteParser() {
    final wholeNumberParser = digit().plus().flatten().trim().map(int.parse);
    final durationParser = wholeNumberParser & (char(':') & wholeNumberParser).optional();
    return pattern('>^').optional() & durationParser.optional() & pattern('TtFfDdZz.');
  }
//  Parser note() {
//    final wholeNumberParser = digit().plus().flatten().trim().map(int.parse);
////    final durationParser = ref(numberPrimitive) & ref(token, ':') & ref(numberPrimitive).optional();
////    final durationParser = ref(numberPrimitive) & (char(':') & ref(numberPrimitive)).optional();
//    final durationParser = wholeNumberParser & (char(':') & wholeNumberParser).optional();
//    final articulationParser = pattern('>^');
//    final typeParser = pattern('TtFfDdZz.');
//    final noteParser = articulationParser.optional() & durationParser.optional() & typeParser;
//    //return noteParser.flatten(); // flatten here, or elsewhere?
//    return noteParser;
//  }

//  // What's the purpose of 'token'?  What does it do for you?  Why not
//  // just skip this and let noteParser reference notePrimitiveParser?
//  Parser noteTokenParser() {
//    print('In SnareGrammarDefinition.noteToken() and will try to create and return a ref to a noteToken.');
//    final notePrimitiveTokenRef = ref(token, ref(notePrimitiveParser), 'notePrimitiveToken');
//    print('In SnareGrammarDefinition.noteToken() and will now return that ref to a noteToken');
//    return notePrimitiveTokenRef;
//  }

//  // In what way is this a primitive?  It's not a char or a number.
//  // Probably get rid of this method and put the guts in noteTokenParser, or
//  // just in noteParser.
//  // I forgot about string() and word() as parsers, but so far don't need them.
//  Parser notePrimitiveParser() {
//    print('In SnareGrammarDefinition.notePrimitive(), will create and return parser for a single note');
//    final wholeNumberParser = digit().plus().flatten().trim().map(int.parse);
//    final durationParser = wholeNumberParser & (char(':') & wholeNumberParser).optional();
//    final articulationParser = pattern('>^');
//    final typeParser = pattern('TtFfDdZz.');
//    final noteParser = articulationParser.optional() & durationParser.optional() & typeParser;
//    return noteParser.flatten(); // flatten here, or elsewhere?
////    return noteParser;
//  }

//  Parser noteParser() {
//    print('In SnareGrammarDefinition.note() and will return a ref to a noteToken, I think');
//    final noteTokenRef = ref(token, noteTokenParser()); // wild guess
//    return noteTokenRef;
//  }





//  Parser statements() => ref(statement).star();
//
//  Parser statement() => ref(label).star() & ref(nonLabelledStatement);
//
//  Parser label() => ref(identifier) & ref(token, ':');
//
//  Parser identifier() => ref(token, ref(IDENTIFIER));


  // -----------------------------------------------------------------
  // Lexical tokens.
  // -----------------------------------------------------------------
  Parser STRING() =>
      char('@').optional() & ref(MULTI_LINE_STRING) | ref(SINGLE_LINE_STRING);

  Parser MULTI_LINE_STRING() =>
      string('"""') & any().starLazy(string('"""')) & string('"""') |
      string("'''") & any().starLazy(string("'''")) & string("'''");

  Parser SINGLE_LINE_STRING() =>
      char('"') & ref(STRING_CONTENT_DQ).star() & char('"') |
      char("'") & ref(STRING_CONTENT_SQ).star() & char("'") |
      string('@"') & pattern('^"\n\r').star() & char('"') |
      string("@'") & pattern("^'\n\r").star() & char("'");

  Parser STRING_CONTENT_DQ() =>
      pattern('^\\"\n\r') | char('\\') & pattern('\n\r');

  Parser STRING_CONTENT_SQ() =>
      pattern("^\\'\n\r") | char('\\') & pattern('\n\r');

  Parser NEWLINE() => pattern('\n\r');

  Parser HASHBANG() =>
      string('#!') & pattern('^\n\r').star() & ref(NEWLINE).optional();

  Parser HIDDEN_STUFF() =>
      ref(WHITESPACE) | ref(SINGLE_LINE_COMMENT) | ref(MULTI_LINE_COMMENT);

  Parser WHITESPACE() => whitespace();

  Parser SINGLE_LINE_COMMENT() =>
      string('//') & ref(NEWLINE).neg().star() & ref(NEWLINE).optional();

  Parser MULTI_LINE_COMMENT() =>
      string('/*') &
      (ref(MULTI_LINE_COMMENT) | string('*/').neg()).star() &
      string('*/');

}

