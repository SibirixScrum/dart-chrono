# chrono

This is a ported version of https://github.com/wanasit/chrono typescript library

## usage

vanilla version(same answers as original lib)

  chrono:
    git:
      url: git@gitlab.dev.sibirix.ru:singularity/chrono.git
      ref: master

our custom version

  chrono:
    git:
      url: git@gitlab.dev.sibirix.ru:singularity/chrono.git
      ref: singularity-chrono

parsing

Chrono.en.parse("aug 18");

you can also pass PasringOption and ParsingReference

Chrono.en.parse("aug 18", DateTime(2018,9,20), ParsingOption(forwardDate: true));

that's it




