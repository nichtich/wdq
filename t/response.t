use v5.14;
use Test::More;
use Test::Output;

my $exit;
sub wdq { system($^X, qw(./bin/wdq --response t/examples/response.json), @_) }

stdout_is { wdq qw(-f csv -q t/examples/query.query) } <<OUT, 'csv';
z,x,y
"\x{e2}\x{98}\x{83}",http://www.wikidata.org/entity/Q123,http://www.example.org/
OUT

stdout_is { wdq qw(-f tsv -q t/examples/query.query) } <<OUT, 'tsv';
?z\t?x\t?y
"\\u2603"\@en\t<http://www.wikidata.org/entity/Q123>\t<http://www.example.org/>
OUT

stdout_is { wdq qw(-f simple -q t/examples/query.query) } <<OUT, 'simple';
[
   {
      "x" : "http://www.wikidata.org/entity/Q123",
      "y" : "http://www.example.org/",
      "z" : "☃"
   }
]
OUT

stdout_is { wdq qw(--ids -f tsv -q t/examples/query.query) } <<OUT, 'ids';
?z\t?x\t?y
"\\u2603"\@en\t"Q123"\t<http://www.example.org/>
OUT

done_testing;
