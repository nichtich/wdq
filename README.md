# NAME

wdq - command line access to Wikidata Query Service

# STATUS

[![Build Status](https://travis-ci.org/nichtich/wdq.png)](https://travis-ci.org/nichtich/wdq)
[![Coverage Status](https://coveralls.io/repos/nichtich/App-wdq/badge.png)](https://coveralls.io/r/nichtich/App-wdq)
[![Kwalitee Score](http://cpants.cpanauthors.org/dist/App-wdq.png)](http://cpants.cpanauthors.org/dist/App-wdq)

# SYNOPSIS

Access [Wikidata Query Service](https://query.wikidata.org/) via command line
to perform SPARQL queries (`query` mode), lookup entities (`lookup`), or
search items and properties (`search` or `psearch`):

    wdq -g en solar system        # search 'solar system' in English
    wdq psearch -g es parte       # search property 'parte' in Spanish
    wdq P361 Q544                 # lookup properties and items
    wdq '?c wdt:P361 wd:Q544'     # query parts of the solar system

See the manual for details or get help via `wdq help`:

    wdq help options              # list and explain command line options
    wdq help modes                # list and explain request modes
    wdq help output               # explain output control
    wdq help formats              # list and explain output formats
    wdq help ontology             # show Wikidata ontology in a nutshell
    wdq help prefixes             # list RDF prefixes allowed in queries
    wdq help version              # show version of wdq

# DESCRIPTION

The command line script `wdq`, included in CPAN module [App::wdq](https://metacpan.org/pod/App::wdq), provides a
tool to access [Wikidata Query Service](https://query.wikidata.org/). It
supports formulation and execution of [SPARQL SELECT
queries](http://www.w3.org/TR/sparql11-query/#select) to extract selected
information from Wikidata or other Wikibase instances. 

# INSTALLATION

Perl should already installed at most operating systems. Otherwise
[get Perl!](https://www.perl.org/get.html)

## FROM CPAN

Install sources from CPAN including all dependencies:

    cpanm App::wdq

First [install cpanm](https://github.com/miyagawa/cpanminus/#installation) if
missing. If installation of `App::wdq` fails try cpanm option `--notest` or
install dependencies as packages as described below.

## PREBUILD PACKAGES

Install dependencies as prebuild packages for your operating system:

    # Debian based systems e.g. Ubuntu (>= 14.04)
    sudo apt-get install libhttp-tiny-perl librdf-query-perl

    # Windows/ActiveState
    ppm install HTTP-Tiny
    ppm install RDF-Query

Then install `wdq` from CPAN as described above or copy the script to some
place in your `$PATH`:

    wget https://github.com/nichtich/wdq/raw/master/script/wdq
    chmod +x wdq

The latter method will not install this documentation. 

# MODES

Request mode `query` (default), `lookup`, `serch`, or `psearch` can
explicitly be set via first argument or it's guessed from arguments. 

## query

Read SPARQL query from STDIN, option `--query|-q`, or argument. Namespace
definitions and `SELECT` clause are added if missing.

    wdq '?c wdt:P361 wd:Q544'
    wdq '{ ?c wdt:P361 wd:Q544 }'                 # equivalent
    wdq 'SELECT * WHERE { ?c wdt:P361 wd:Q544 }'  # equivalent
    wdq < queryfile

## lookup

Read Wikidata entity ids, URLs, or Wikimedia project URLs from STDIN or
arguments. Result fields are `label`, `description`, and `id`:

     wdq Q1
     wdq lookup Q1                                 # equivalent
     echo Q1 | wdq lookup                          # equivalent
     wdq http://de.wikipedia.org/wiki/Universum    # same result
    

## search / psearch

Search for items or properties. Result fields are `label`, `id`,
`description`, and possibly matched `alias`. Search and result language is
read from environment or option `--language`/`-g`:

    wdq search -g sv Pippi Långstrump

Default output format in search mode is `pretty`.

# OPTIONS

- --query|-q QUERY

    Query or query file (`-` for STDIN as default)

- --format|-f FORMAT|TEMPLATE

    Output format or string template. Call `wdq help formats` for details.

- --export EXPORTER

    Use a [Catmandu](https://metacpan.org/pod/Catmandu) exporter as output format.

- --no-header|-H

    Exclude header in CSV output or other exporter.

- --enumerate|-e

    Enumerate results by adding a counter variable `n`

- --limit INTEGER

    Add or override a LIMIT clause to limitate the number of results. Single-digit
    options such as `-1` can also be used to also set a limit.

- --ids|-i

    Abbreviate Wikidata identifier URIs as strings.

- --language|-g

    Language to query labels and descriptions in. Set to the locale by default.
    This option is currentl only used on lookup mode.

- --count|-c VARNAME

    Prepend SPARQL QUERY to count distinct values

- --ignore

    Ignore empty results instead of issuing warning and exit code.

- --color|-C

    By default output is colored if writing to a terminal. Disable this with
    `--no-color` or force color with `--color` or `-C`.

- --api URL

    SPARQL endpoint. Default value:
    `https://query.wikidata.org/bigdata/namespace/wdq/sparql`

- --no-mediawiki|-m

    Don't query MediaWiki API to map URLs to Wikidata items.

- --no-execute|-n

    Don't execute SPARQL queries but show them in expanded form. Useful to
    validate and pretty-print queries. MediaWiki API requests may be

- -N

    Don't execute any queries. Same as `--no-mediawiki --no-execute`.

- --help|-h|-?

    Show usage help

- --ontology

    Show information about the Wikidata Ontology

- --no-default-prefixes

    Don't add default namespace prefixes to the SPARQL query

- --man

    Show detailled manual

- --version|-V

    Show version if this script

# OUTPUT

Output can be controlled with options `--format`/`-f`, `--export`,
`--header`/`--no-header`/`-H`, and `--color`/`--no-color`/`-C`.

## Formats

Option `--format`/`-f` sets an output format or string template:

- `simple` (default in query and lookup mode)

    Flat JSON without language tags

- `ldjson`

    Line delimited Flat JSON

- `csv`

    SPARQL Query Results CSV Format. Suppress header with option
    `--no-header`/`-H`.  Use Catmandu CSV exporter for more options

- `tsv`

    SPARQL Query Results TSV Format

- `xml`

    SPARQL Query Results XML Format

- `json`

    SPARQL Query Results JSON Format

- `pretty` (default in search mode)

    Default string template to print `label`, `alias`, `id`, `description`.
    Also sets option `--ids` unless disabled

- `...`

    String template.  Call `wdq help pretty` for details

## Pretty

Option `--format` can be set to a string template with bracket expressions
with optional template parameters (for instance `{id|pre= (|post=)}`).

- style

    Highlight `n` name, `v` value, `i` identifier, `t` title, or `e` error

- length

    Abbreviate long values

- align

    Use `left` or `right` to align short values to a given `length`

- pre/post

    Add string before/after value

## Export

Option `--export` sets a [Catmandu](https://metacpan.org/pod/Catmandu) exporter to create output with.  Given
the corresponding exporter modules installed, one can write results as `YAML`,
Excel (`XLS`), and Markdown table (`Table`) among other formats:

    wdq --export YAML                               # short form
    wdq --format ldjson | catmandu convert to YAML  # equivalent

Use Catmandu config file (`catmandu.yml`) to further configure export.  See
also tools such as [jq](http://stedolan.github.io/jq/) and
[miller](http://johnkerl.org/miller/) for processing results.

# EXAMPLES

    # get all parts of the solar system
    wdq -q '?c wdt:P361 wd:Q544'

    # get all references used at an item
    wdq -q 'wd:Q1 ?prop [ prov:wasDerivedFrom ?ref ]'

    # get doctoral advisor graph (academic genealogy) as CSV
    wdq -q '?student wdt:P184 ?advisor' --ids --format csv

    # print expanded SPARQL query 
    wdq -n -q '?c wdt:P361 wd:Q544'
    
    # execute query and return first 10 tab-separated values
    wdq -f tsv --limit 10 < query

    # print result as Markdown Table (requires Catmandu::Exporter::Table)
    wdq --export Table < query

    # look up label and description
    wdq Q42 P9

    # look up German Wikipedia article and get label description in French
    wdq -g fr http://de.wikipedia.org/wiki/Argon 

    # count instances (P31) of books (Q571)
    wdq --count x '?x wdt:P31 wd:Q571' --format {count}

# WIKIDATA ONTOLOGY

    Entity (item/property)
     wd:Q_ <-- owl:sameAs --> wd:Q_
           --> rdfs:label, skos:altLabel, schema:description "_"@_
           --> schema:dateModified, schema:version
           --> wdt:P_ "_", URI, _:blank
           --> p:P_ Statement

    Item
     wd:Q_ <-- schema:about <http://_.wikipedia.org/wiki/_>
                            --> schema:inLanguage, wikibase:badge

    Property
     wd:P_ --> wikibase:propertyType PropertyType
           --> wkibase:directClaim        wdt:P_
           --> wikibase:claim             p:P_
           --> wikibase:statementProperty ps:P_
           --> wikibase:statementValue    psv:P_
           --> wikibase:qualifier         pq:P_
           --> wikibase:qualifierValue    pqv:P_
           --> wikibase:reference         pr:P_
           --> wikibase:referenceValue    prv:P_
           --> wikibase:novalue           wdno:P_

    PropertyType
     wikibase: String, Url, WikibaseItem, WikibaseProperty, CommonsMedia,
               Monolingualtext, GlobeCoordinate, Quantity, Time


    Statement
     wds:_ --> wikibase:rank Rank
           --> a wdno:P_
           --> ps:P_ "_", URI, _:blank
           --> psv:P_ Value
           --> pq:P_ "_", URI, _:blank
           --> pqv:P_ Value
           --> prov:wasDerivedFrom Reference

    Reference
     wdref:_ --> pr:P_ "_", URI
             --> prv:P_ Value

    Rank
     wikibase: NormalRank, PreferredRank, DeprecatedRank, BestRank

    Value (GlobecoordinateValue/QuantityValue/TimeValue)
     wdv:_ --> wikibase: geoLatitude, geoLongitude, geoPrecision, geoGlobe URI
           --> wikibase: timeValue, timePrecision, timeTimezone, timeCalendarModel
           --> wikibase: quantityAmount, quantityUpperBound, quantityLowerBound,
                         quantityUnit URI

# COPYRIGHT AND LICENSE

Copyright by Jakob Voss `voss@gbv.de`

Based on a PHP script by Marius Hoch `hoo@online.de`
at [https://github.com/mariushoch/asparagus](https://github.com/mariushoch/asparagus).

Licensed under GPL 2.0+
