package App::wdq;
use v5.14;

our $VERSION = '0.3.1';

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

Perl should already installed at most operating systems. Otherwise [get Perl
first](https://www.perl.org/get.html).

=head2 FROM CPAN

Install sources from CPAN including all dependencies:

  cpanm App::wdq

First [install cpanm](https://github.com/miyagawa/cpanminus/#installation) if
missing. If installation of C<App::wdq> fails try cpanm option C<--notest> or
install dependencies as packages as described below.

=item PREBUILD PACKAGES

Install dependencies as prebuild packages for your operating system:

  # Debian based systems e.g. Ubuntu
  sudo apt-get install libhttp-tiny-perl librdf-query-perl

  # Windows/ActiveState
  ppm install HTTP-Tiny
  ppm install RDF-Query

Then install `wdq` from CPAN as described above or copy the script to some
place in your C<$PATH>:

  wget https://github.com/nichtich/wdq/raw/master/bin/wdq
  chmod +x wdq

The latter method will not install this documentation. 

=head1 USAGE

Get a documented list of all command line options:

  wdq --help
 
=head2 query mode (default)

Pass a (possibly abbreviated) SPARQL query via STDIN or option C<--query>.

  wdq < queryfile

=head2 lookup mode

Pass a line-separated list of Wikidata identifiers or Wikimedia project URLs
via STDIN or command line arguments:

  wdq Q1
  wdq lookup Q1
  echo Q1 | wdq lookup
 
=head1 EXAMPLES

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

=head1 COPYRIGHT AND LICENSE

Copyright Jakob Voss, 2015-

GPL 2.0

=cut
