use v5.14;
use Test::More;
use Test::Output;

sub wdq {
    my $c = join ' ', $^X, qw(script/wdq -gde --res t/examples/search.json), @_;
    `$c`;
}

my $xml = wdq(qw(search -f xml ));
like "" . $xml, qr{xml:lang="de">IPPNW</literal>}, 'contains language tag';
is( ( () = $xml =~ /<binding name="alias">/g ), 4, 'contains some alias' );

like wdq(qw(search --ids -f simple)), qr{"id": "Q256503",}, 'option --ids';

done_testing;
