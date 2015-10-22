use v5.14;
use Test::More;
use Test::Output;

my $sparql = <<SPARQL;
PREFIX bd: <http://www.bigdata.com/rdf#>
PREFIX wikibase: <http://wikiba.se/ontology#>
SELECT ?id ?idLabel ?idDescription WHERE {
\t{}
\tBIND(<http://www.wikidata.org/entity/Q243972> AS ?id)
\tSERVICE wikibase:label {
\t\tbd:serviceParam wikibase:language "fr" .
\t}
}
SPARQL

stdout_is { system("$^X script/wdq lookup -gfr -n < t/examples/lookup") }
    $sparql x 8, 'lookup given qid from STDIN';

my @sitelinks = (
    " http://de.wikipedia.org/wiki/Erdős-Zahl",  
    "\thttps://de.wikipedia.org/wiki/Erd%C5%91s-Zahl\n",
);

output_is { system($^X, 'script/wdq', '-N', 'lookup', @sitelinks) }
    "", "MediaWiki API disabled\n", "--no-mediawiki --no-execute";

SKIP: {
    skip 'release test requiring network', 1 unless $ENV{RELEASE_TESTING};
    
    output_is { system($^X, 'script/wdq', '-gfr', '-n', @sitelinks) }
        $sparql x 2, "", "N: lookup Wikidata id via MediaWiki API";

    my $cmd = "echo $sitelinks[0] | $^X script/wdq -gen lookup -f csv -Hi";
    stdout_like { system($cmd) }
        qr{^Q243972,Erdős}, "N: lookup via MediaWiki API and SPARQL (STDIN)";
}

{
    $sparql =~ s/Q243972/P7/m;
    $sparql =~ s/"fr"/"es,en-simple"/m;

    my $cmd = join ' ', 
        "$^X script/wdq --language es,en-simple -n",
        'http://www.wikidata.org/wiki/Property:P7', 
        'Property:P7', ' P7', 'p7 ';

    stdout_is { system $cmd }
        $sparql x 4, 'lookup given pid from ARGV';
}

done_testing;
