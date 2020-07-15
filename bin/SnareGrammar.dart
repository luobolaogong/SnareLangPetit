import 'package:petitparser/petitparser.dart';

// Hmmm this file is called SnareGrammar, but it's mostly SnareGrammarDefinition.  Whatever.
class SnareGrammar extends GrammarParser {
  SnareGrammar() : super(const SnareGrammarDefinition());
}

/// SNARE grammar definition.
class SnareGrammarDefinition extends GrammarDefinition {
  const SnareGrammarDefinition();

  Parser start() {
    print('In SnareGrammar.dart.SnareGrammarDefinition.start() '
        'and will return a Parser for a ref value followed by an end');
    // what the heck is 'value'??????
    print('value is $value'); // Closure: () => Parser<dynamic> from Function 'value':
    return ref(value).end();
  }

//  Parser start() => ref(value).end();

  // What does this mean?  We're trying to parse stuff to generate tokens?
  // The object passed in is either a String or a Parser.
  // String is overloaded to do a call to toParser (method or function?)
  // Who calls this?
  Parser token(Object source, [String name]) {
    if (source is String) {
      // Wow, calling toParser on a String.  Returns a Parser.
      print(
          'In SnareGrammar.dart.SnareGrammarDefinition.token(), source is a string -->$source<--  I do not know who calls this token method in SnareGrammarDefinition');
      return source.toParser(message: 'Expected ${name ?? source}').trim();
    } else if (source is Parser) {
      // Wow, just check if not null and then flatten and trim it.
      ArgumentError.checkNotNull(name, 'name');
      return source.flatten('Expected $name').trim(); // happens: ...
    } else {
      throw ArgumentError('Unknown token type: $source.');
    }
  }

  //Parser comment() => ref(token, '//') & ref(elements).optional(); // total guess by me
//  Parser note() => ref(token,'^8T');
  Parser note() {
    print('In SnareGrammarDefinition.note() and will return a parser if can');
//    final noteParserIGuess = ref(token, '^8T');
    final noteParserIGuess = ref(token, stringToken()); // wild guess
    final noteParserIGuess2 = ref(token, stringPrimitive()); // wild guess
    print('In SnareGrammarDefinition.note() and Will now return a '
        'noteParserIGuess, which is a reference to a token expecting '
        '^8T maybe.');
    return noteParserIGuess;
  }

  Parser elements() {
    return ref(value).separatedBy(ref(token, ','), includeSeparators: false);
  }

//  Parser elements() =>
//      ref(value).separatedBy(ref(token, ','), includeSeparators: false);

  Parser members() {
    return ref(pair).separatedBy(ref(token, ','), includeSeparators: false);
  }

  Parser object() {
    return ref(token, '{') & ref(members).optional() & ref(token, '}');
  }

//  Parser object() =>
//      ref(token, '{') & ref(members).optional() & ref(token, '}');

  Parser pair() {
    return ref(stringToken) & ref(token, ':') & ref(value);
  }

//  Parser pair() => ref(stringToken) & ref(token, ':') & ref(value);
  // Not sure who calls this, but it is invoked after SnareGrammarDefinition.start(), which has a    return ref(value).end();
  Parser value() {
    print('In SnareGrammar.value(), will return a parser based on ref of either noteToken or stringToken or nullToken');
    print('what the heck are these tokens?  '
        'noteToken: ${noteToken}  '
        'stringToken: ${stringToken} '
        'nullToken: ${nullToken}');
    return ref(noteToken) | ref(stringToken) | ref(nullToken);
  }

//  Parser value() =>
//      ref(noteToken) |
//      ref(stringToken) |
//      ref(nullToken);

  Parser nullToken() {
    print('In SnareGrammarDefinition.nullToken() and will create and return a ref to a null token');
    return ref(token, 'null');
  }

//  Parser nullToken() => ref(token, 'null');

  Parser stringToken() {
    print('In SnareGrammarDefinition.stringToken() and will try to create and return a ref to stringPrimitive.');
    return ref(token, ref(stringPrimitive), 'string');
  }

//  Parser stringToken() => ref(token, ref(stringPrimitive), 'string');

  Parser numberToken() {
    return ref(token, ref(numberPrimitive), 'number');
  }

//    Parser numberToken() => ref(token, ref(numberPrimitive), 'number');

  // What calls this?
  Parser noteToken() {
    print('In SnareGrammarDefinition.noteToken() and will try to create and return a ref to a noteToken.');
    final aReferenceToSomething = ref(token, ref(notePrimitive), 'noteToken');
    print('In SnareGrammarDefinition.noteToken() and will now return that ref to a noteToken');
    return aReferenceToSomething;
  }

  // Hopefully I'll never need floats, but keep this I think:
  Parser numberPrimitive() =>
      char('-').optional() &
      char('0').or(digit().plus()) &
      char('.').seq(digit().plus()).optional() &
      pattern('eE')
          .seq(pattern('-+').optional())
          .seq(digit().plus())
          .optional();

  // A string has to be in double quotes, it seems:
  Parser stringPrimitive() {
    print('In SnareGrammarDefinition.stringPrimitive() return parser of something in quotes');
    return char('"') & ref(characterPrimitive).star() & char('"');
  }

//  Parser stringPrimitive() =>
//      char('"') & ref(characterPrimitive).star() & char('"');

  // What calls this?
  Parser notePrimitive() {
    print('In SnareGrammarDefinition.notePrimitive(), will return parser of ^8T');
//    return char('^') & char('8') & char('T');


    final wholeNumber = digit().plus().flatten().trim().map(int.parse);
    final durationParser = wholeNumber & (char(':') & wholeNumber).optional();
    final articulationParser = pattern('>^');
    final typeParser = pattern('TtFfDdZz.');
    final noteParser = articulationParser.optional() & durationParser.optional() & typeParser;
    return noteParser;



  }

  Parser characterPrimitive() =>
      ref(characterNormal);

//  Parser characterPrimitive() =>
//      ref(characterNormal) | ref(characterEscape) | ref(characterUnicode);

  // Will I want this?
  Parser characterNormal() => pattern('^"\\');
}

//  // Will I want this?:
//  Parser characterEscape() => char('\\') & pattern(snareEscapeChars.keys.join());

//  // I doubt I'll want this:
//  Parser characterUnicode() => string('\\u') & pattern('0-9A-Fa-f').times(4); // huh????

//}

