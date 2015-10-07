package App::wdq;
use v5.14;

our $VERSION = '0.2.0';

1;
__END__

=head1 NAME

App::wdq - command line access to Wikidata Query Service

=begin markdown

# STATUS

[![Build Status](https://travis-ci.org/nichtich/wdq.png)](https://travis-ci.org/nichtich/wdq)
[![Coverage Status](https://coveralls.io/repos/nichtich/App-wdq/badge.png)](https://coveralls.io/r/nichtich/App-wdq)
[![Kwalitee Score](http://cpants.cpanauthors.org/dist/App-wdq.png)](http://cpants.cpanauthors.org/dist/App-wdq)

=end markdown

=head1 DESCRIPTION

The command line script L<wdq>, included in CPAN module L<App::wdq>, provides a
tool to access L<Wikidata Query Service|https://query.wikidata.org/>. It
supports formulation and execution of L<SPARQL SELECT
queries|http://www.w3.org/TR/sparql11-query/#select> to extract selected
information from Wikidata or other Wikibase instances. 

=head1 INSTALLATION

Either install from CPAN with all dependencies:

  cpanm App::wdq

or install dependencies as prebuild packages (for instance Debian) and copy
the L<wdq> script to some place in your C<$PATH>:

  sudo apt-get install libhttp-tiny-perl librdf-query-perl
  wget https://github.com/nichtich/wdq/raw/master/bin/wdq
  chmod +x wdq

The latter method will not install this documentation. 

=head1 USAGE
 
Get a documented list of all command line options:

  wdq --help
  
=head1 EXAMPLES

  # get all parts of the solar system
  wdq -q '{ ?c wdt:P361 wd:Q544 }'

  # print expanded SPARQL query 
  wdq -n -q '{ ?c wdt:P361 wd:Q544 }'
  
  # execute query and return tab-separated values
  wdq -f tsv < query

  # execute query, abbreviate Wikidata identifier, emit simple JSON
  wdq -f simple --ids < query

  # print result as Markdown Table (requires Catmandu::Exporter::Table)
  wdq --export Table < query

=head1 COPYRIGHT AND LICENSE

Copyright Jakob Voss, 2015-

GPL 2.0

=cut
