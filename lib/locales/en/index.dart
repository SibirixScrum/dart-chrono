
 /**
 * Chrono components for English support (*parsers*, *refiners*, and *configuration*)
 *
 * 
 */
 import "../../chrono.dart" show Chrono , Parser , Refiner ; import "../../results.dart" show ParsingResult , ParsingComponents , ReferenceWithTimezone ; import "../../types.dart" show Component , ParsedResult , ParsingOption , ParsingReference , Meridiem , Weekday ; export show Chrono , Parser , Refiner , ParsingResult , ParsingComponents , ReferenceWithTimezone ; export show Component , ParsedResult , ParsingOption , ParsingReference , Meridiem , Weekday ; final enConfig = new ENDefaultConfiguration ( ) ;
 /**
 * Chrono object configured for parsing *casual* English
 */
 final casual = new Chrono ( enConfig . createCasualConfiguration ( false ) ) ;
 /**
 * Chrono object configured for parsing *strict* English
 */
 final strict = new Chrono ( enConfig . createConfiguration ( true , false ) ) ;
 /**
 * Chrono object configured for parsing *UK-style* English
 */
 final GB = new Chrono ( enConfig . createConfiguration ( false , true ) ) ;
 /**
 * A shortcut for en.casual.parse()
 */
 List < ParsedResult > parse ( String text , [ Date ref , ParsingOption option ] ) { return casual . parse ( text , ref , option ) ; }
 /**
 * A shortcut for en.casual.parseDate()
 */
 Date parseDate ( String text , [ Date ref , ParsingOption option ] ) { return casual . parseDate ( text , ref , option ) ; }