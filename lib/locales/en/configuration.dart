 ; show ; Configuration ; ; show ; includeCommonConfiguration ; class ENDefaultConfiguration {
 /**
     * Create a default *casual* {@Link Configuration} for English chrono.
     * It calls {@Link createConfiguration} and includes additional parsers.
     */
 var Configuration = createCasualConfiguration ( [ littleEndian = false ] ) ; } { final ; option = this . createConfiguration ( false , littleEndian ) ; option . parsers . unshift ( new ENCasualDateParser ( ) ) ; option . parsers . unshift ( new ENCasualTimeParser ( ) ) ; option . parsers . unshift ( new ENMonthNameParser ( ) ) ; option . parsers . unshift ( new ENRelativeDateFormatParser ( ) ) ; option . parsers . unshift ( new ENTimeUnitCasualRelativeFormatParser ( ) ) ; return option ; }
 /**
     * Create a default {@Link Configuration} for English chrono
     *
     * 
     * 
     */
 Configuration ; createConfiguration ( [ strictMode = true , littleEndian = false ] ) ; { final ; options = includeCommonConfiguration ( { "parsers" : [ new SlashDateFormatParser ( littleEndian ) , new ENTimeUnitWithinFormatParser ( strictMode ) , new ENMonthNameLittleEndianParser ( ) , new ENMonthNameMiddleEndianParser ( ) , new ENWeekdayParser ( ) , new ENCasualYearMonthDayParser ( ) , new ENSlashMonthFormatParser ( ) , new ENTimeExpressionParser ( strictMode ) , new ENTimeUnitAgoFormatParser ( strictMode ) , new ENTimeUnitLaterFormatParser ( strictMode ) ] , "refiners" : [ new ENMergeRelativeDateRefiner ( ) , new ENMergeDateTimeRefiner ( ) ] } , strictMode ) ;
 // Re-apply the date time refiner again after the timezone refinement and exclusion in common refiners.
 options . refiners . push ( new ENMergeDateTimeRefiner ( ) ) ;
 // Keep the date range refiner at the end (after all other refinements).
 options . refiners . push ( new ENMergeDateRangeRefiner ( ) ) ; return options ; }