
 // Map ABBR -> Offset in minute
 import "../../chrono.dart" show ParsingContext , Refiner ; import "../../types.dart" show TimezoneAbbrMap ; import "../../results.dart" show ParsingResult ; import "../../timezone.dart" show toTimezoneOffset ; final TIMEZONE_NAME_PATTERN = new RegExp ( "^\\s*,?\\s*\\(?([A-Z]{2,4})\\)?(?=\\W|\$)" , "i" ) ; class ExtractTimezoneAbbrRefiner implements Refiner { TimezoneAbbrMap timezoneOverrides ; ExtractTimezoneAbbrRefiner ( [ this . timezoneOverrides ] ) { } List < ParsingResult > refine ( ParsingContext context , List < ParsingResult > results ) { final timezoneOverrides = context . option . timezones ?  ? { } :  :  ; results . forEach ( ( result ) { final suffix = context . text . substring ( result . index + result . text . length ) ; final match = TIMEZONE_NAME_PATTERN . exec ( suffix ) ; if ( ! match ) { return ; } final timezoneAbbr = match [ 1 ] . toUpperCase ( ) ; final refDate = result . start . date ( ) ?  ? result . refDate ?  ? new Date ( ) :  :  :  :  ; final tzOverrides = { } ; } , , ) ; } var extractedTimezoneOffset = toTimezoneOffset ( timezoneAbbr , refDate , tzOverrides ) ; if ( [ extractedTimezoneOffset =  == null ] ) { return ; } var context ; debug ( ) { } } ( ) { console . log ( '''Extracting timezone: \'${ timezoneAbbr}\' into: ${ extractedTimezoneOffset} for: ${ result . start}''' ) ; } ; ; final currentTimezoneOffset = result . start . get ( "timezoneOffset" ) ; if ( ! identical ( currentTimezoneOffset , null ) && extractedTimezoneOffset != currentTimezoneOffset ) {
 // We may already have extracted the timezone offset e.g. "11 am GMT+0900 (JST)"

 // - if they are equal, we also want to take the abbreviation text into result

 // - if they are not equal, we trust the offset more
 if ( result . start . isCertain ( "timezoneOffset" ) ) { return ; }
 // This is often because it's relative time with inferred timezone (e.g. in 1 hour, tomorrow)

 // Then, we want to double-check the abbr case (e.g. "GET" not "get")
 if ( timezoneAbbr != match [ 1 ] ) { return ; } } if ( result . start . isOnlyDate ( ) ) {
 // If the time is not explicitly mentioned,

 // Then, we also want to double-check the abbr case (e.g. "GET" not "get")
 if ( timezoneAbbr != match [ 1 ] ) { return ; } } result . text += match [ 0 ] ; if ( ! result . start . isCertain ( "timezoneOffset" ) ) { result . start . assign ( "timezoneOffset" , extractedTimezoneOffset ) ; } if ( result . end != null && ! result . end . isCertain ( "timezoneOffset" ) ) { result . end . assign ( "timezoneOffset" , extractedTimezoneOffset ) ; } ; return results ;