use v5.14;
use Test::More;
use Test::Output;

my $exit;
sub wdq { system( $^X, './bin/wdq', @_ ); $exit = $? >> 8 }
sub slurp { local ( @ARGV, $/ ) = shift; <> }

my $sparql = <<SPARQL;
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT * WHERE {
\t?c <http://www.wikidata.org/prop/direct/P361> <http://www.wikidata.org/entity/Q544> .
}
SPARQL

# FIXME: use namespace prefixes in expanded SPARQL query
foreach my $query (
    '?c wdt:P361 wd:Q544',
    '{ ?c wdt:P361 wd:Q544 }',
    'SELECT * WHERE { ?c wdt:P361 wd:Q544 }', $sparql
  )
{
    stdout_is { wdq -nq => $query } $sparql, substr $query, 0, 20;
}

done_testing;
