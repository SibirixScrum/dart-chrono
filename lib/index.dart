
import "chrono.dart" show Chrono, Parser, Refiner;
import "results.dart"
    show ParsingResult, ParsingComponents, ReferenceWithTimezone;
import "types.dart"
    show Component, ParsedResult, ParsingOption, ParsingReference, Meridiem, Weekday;

// export show
// en , Chrono , Parser , Refiner , ParsingResult , ParsingComponents , ReferenceWithTimezone ;
//
// export show
// Component , ParsedResult , ParsingOption , ParsingReference , Meridiem , Weekday ;
// Export all locales
// import "locales/de.dart" as de;
// import "locales/fr.dart" as fr;
// import "locales/ja.dart" as ja;
// import "locales/pt.dart" as pt;
// import "locales/nl.dart" as nl;
// import "locales/zh.dart" as zh;

// import "locales/es.dart" as es;
// import "locales/uk.dart" as uk;
import 'locales/ru/index.dart' as ru;

// export show
// de , fr , ja , pt , nl , zh , ru , es , uk ;
/**
 * A shortcut for [en | chrono.en.strict]
 */
final strict = ru.strict;
/**
 * A shortcut for [en | chrono.en.casual]
 */
final casual = ru.casual;
/**
 * A shortcut for [en | chrono.en.casual.parse()]
 */
List <ParsedResult> parse(String text,
    [ dynamic /* ParsingReference | Date */ ref, ParsingOption? option ]) {
  return casual.parse(text, ref, option);
}
/**
 * A shortcut for [en | chrono.en.casual.parseDate()]
 */
DateTime parseDate(String text,
    [ dynamic /* ParsingReference | Date */ ref, ParsingOption? option ]) {
  return casual.parseDate(text, ref, option);
}