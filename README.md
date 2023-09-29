# chrono

This is a ported version of https://github.com/wanasit/chrono typescript library 

Caution: super slow in debug mode(idk why), but in release it is good

all tests rewritten and passed

It is designed to handle most date/time format and extract information from any given text:

* _Today_, _Tomorrow_, _Yesterday_, _Last Friday_, etc
* _17 August 2013 - 19 August 2013_
* _This Friday from 13:00 - 16.00_
* _5 days ago_
* _2 weeks from now_
* _Sat Aug 17 2013 18:40:39 GMT+0900 (JST)_
* _2014-11-30T08:15:30-05:30_

# Languages

english, russian

# usage

## vanilla version(same answers as original lib)
```
  chrono:
    git:
      url: git@gitlab.dev.sibirix.ru:singularity/chrono.git
      ref: master
```
## our custom version
```
  chrono:
    git:
      url: git@gitlab.dev.sibirix.ru:singularity/chrono.git
      ref: singularity-chrono
```
## parsing
```dart
  final result = Chrono.en.casual.parse('An appointment on Sep 12-13'); // now is 2023-09-29
  print(result[0].start.date()); // 2023-09-12 12:00:00.000
  print(result[0].end?.date()); // 2023-09-13 12:00:00.000
```
you can also pass PasringOption and ParsingReference
```dart
  final result = Chrono.en.casual.parse('An appointment on Sep 12-13',referenceDate: DateTime(2025,9,20));
  // Fri Sep 12 2014 12:00:00 GMT-0500 (CDT)
  print(result[0].start.date()); // 2025-09-12 12:00:00.000
  print(result[0].end?.date()); // 2025-09-13 12:00:00.000
```

```dart
  final result = Chrono.en.casual.parse('An appointment on Sep 12-13',referenceDate: DateTime(2025,9,20),option: ParsingOption(forwardDate: true));
  // Fri Sep 12 2014 12:00:00 GMT-0500 (CDT)
  print(result[0].start.date()); // 2026-09-12 12:00:00.000
  print(result[0].end?.date()); // 2026-09-13 12:00:00.000
```
#### ParsingReference

you can simply pass DateTime or use ParsingReference class

* `instant?: Date` The instant when the input is written or mentioned
* `timezone?: string | number` The timezone where the input is written or mentioned. 
  Support minute-offset (number) and timezone name (e.g. "GMT", "CDT"). You can see all suported strings in file timezone.dart

#### ParsingOption

`forwardDate` (boolean) to assume the results should happen after the reference date (forward into the future)
`timezones` Override or add custom mappings between timezone abbreviations and offsets. Use this when you want Chrono to parse certain text into a given timezone offset. Chrono supports both unambiguous (normal) timezone mappings and ambigous mappings where the offset is different during and outside of daylight savings.

#### ParsedResult
* `refDate: Date` The [reference date](#reference-date) of this result
* `index: number` The location within the input text of this result  
* `text: string`  The text this result that appears in the input 
* `start: ParsedComponents` The parsed date components as a [ParsedComponents](#parsedcomponents) object
* `end?: ParsedComponents`  Similar to `start`
* `date: () => Date` Create a dart DateTime for `start`

#### ParsedComponents
* `get: (c: Component) => number | null`    Get known or implied value for the component
* `isCertain: (c: Component) => boolean`    Check if the component has a known value
* `date: () => Date`    Create a dart DateTime
* if you want more information you can use `ParsedComponents as ParsingComponent` and get a bunch of extra properties


## More information

check original https://github.com/wanasit/chrono




