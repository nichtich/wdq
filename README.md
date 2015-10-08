# NAME

App::wdq - command line access to Wikidata Query Service

# STATUS

[![Build Status](https://travis-ci.org/nichtich/wdq.png)](https://travis-ci.org/nichtich/wdq)
[![Coverage Status](https://coveralls.io/repos/nichtich/App-wdq/badge.png)](https://coveralls.io/r/nichtich/App-wdq)
[![Kwalitee Score](http://cpants.cpanauthors.org/dist/App-wdq.png)](http://cpants.cpanauthors.org/dist/App-wdq)

# DESCRIPTION

The command line script [wdq](https://metacpan.org/pod/wdq), included in CPAN module [App::wdq](https://metacpan.org/pod/App::wdq), provides a
tool to access [Wikidata Query Service](https://query.wikidata.org/). It
supports formulation and execution of [SPARQL SELECT
queries](http://www.w3.org/TR/sparql11-query/#select) to extract selected
information from Wikidata or other Wikibase instances. 

# INSTALLATION

Either install from CPAN with all dependencies:

    cpanm App::wdq

or install dependencies as prebuild packages (for instance Debian) and copy
the [wdq](https://metacpan.org/pod/wdq) script to some place in your `$PATH`:

    sudo apt-get install libhttp-tiny-perl librdf-query-perl
    wget https://github.com/nichtich/wdq/raw/master/bin/wdq
    chmod +x wdq

The latter method will not install this documentation. 

# USAGE

Get a documented list of all command line options:

    wdq --help
    

# EXAMPLES

    # get all parts of the solar system
    wdq -q '{ ?c wdt:P361 wd:Q544 }'

    # get all references used at an item
    wdq -q '{ wd:Q1 ?prop [ prov:wasDerivedFrom ?ref ] }'

    # print expanded SPARQL query 
    wdq -n -q '{ ?c wdt:P361 wd:Q544 }'
    
    # execute query and return tab-separated values
    wdq -f tsv < query

    # execute query, abbreviate Wikidata identifier, emit simple JSON
    wdq -f simple --ids < query

    # print result as Markdown Table (requires Catmandu::Exporter::Table)
    wdq --export Table < query

# COPYRIGHT AND LICENSE

Copyright Jakob Voss, 2015-

GPL 2.0
