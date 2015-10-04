# NAME

App::wdq - command line access to Wikidata Query Service

# STATUS

[![Build Status](https://travis-ci.org/nichtich/wdq.png)](https://travis-ci.org/nichtich/wdq)
[![Coverage Status](https://coveralls.io/repos/nichtich/App-wdq/badge.png)](https://coveralls.io/r/nichtich/App-wdq)
[![Kwalitee Score](http://cpants.cpanauthors.org/dist/App-wdq.png)](http://cpants.cpanauthors.org/dist/App-wdq)

# INSTALLATION

Either install from CPAN with all dependencies:

    cpanm App::wdq

or install dependencies as prebuild packages (for instance Debian) and copy
the \`wdq\` script at some place in your `$PATH`:

    apt-get install libhttp-tiny-perl librdf-query-perl
    wget https://github.com/nichtich/wdq/raw/master/bin/wdq
    chmod +x wdq

# USAGE

    wdq --help

# COPYRIGHT AND LICENSE

Copyright Jakob Voss, 2015-

GPL 2.0
