use v5.14;
use Test::More;
use Test::Output;

my $wdq = "$^X script/wdq";
my $res = "--response t/examples";

# enumerate (-e), identifier (-i)
{
    stdout_like { system("$wdq query -eifcsv $res/response.json '?x ?y ?z'") }
        qr/^n,x,y,z\n1,Q123/m,
        '-e -i (query)'
}

# enumerate (-e), format (-f)
{
    stdout_like { system("$wdq search -ef{n}:{id} $res/search.json") }
        qr/^1:Q256503\n2:Q39631/m,
        '-e -f (search)'
}

done_testing;
