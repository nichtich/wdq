use v5.14;
use Test::More;
use Test::Output;

sub wdq { system( $^X, 'script/wdq', '-n', @_ ) }
sub slurp { local (@ARGV,$/) = shift; <> }

my $sparql = <<SPARQL;
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT * WHERE {
    ?c wdt:P361 wd:Q544 .
}
SPARQL

foreach my $query (
    '?c wdt:P361 wd:Q544',
    '{ ?c wdt:P361 wd:Q544 }',
    'SELECT * WHERE { ?c wdt:P361 wd:Q544 }', $sparql
  )
{
    stdout_is { wdq -q => $query } $sparql, substr $query, 0, 20;
    stdout_is { wdq $query } $sparql, substr $query, 0, 20;
}

stdout_is { wdq( -q => '?a ?b ?c', '--limit' => 1 ) }
"SELECT * WHERE {\n    ?a ?b ?c .\n}\nLIMIT 1\n", '--limit';

stdout_is { wdq( -q => 'SELECT * WHERE { ?a ?b ?c } LIMIT 2', '--limit' => 3 ) }
"SELECT * WHERE {\n    ?a ?b ?c .\n}\nLIMIT 3\n", '--limit (override)';

stdout_is { wdq( '-53q' => '?a ?b ?c', '--limit' => 6 ) }
"SELECT * WHERE {\n    ?a ?b ?c .\n}\nLIMIT 3\n", 'limit -3';

stdout_is { wdq( '-cx', '?x wdt:P31 wd:Q5633421' ) } <<SPARQL, 'count';
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT (COUNT(DISTINCT ?x) AS ?count) WHERE {
    ?x wdt:P31 wd:Q5633421 .
}
SPARQL

stdout_is { system( $^X, 'script/wdq', '-cx', '?x wdt:P31 wd:Q5633421', 
                         '--response', 't/examples/count.json', '-ftext' ) }
    "63107\n", 'text format for count';

stdout_is { wdq( '-lid,x', '-tx', '-gde', '?id ?p ?x' ) }
    slurp('t/examples/label.sparql'), '--label/description';

done_testing;
