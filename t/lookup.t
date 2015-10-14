use v5.14;
use Test::More;
use Test::Output;

sub slurp { local (@ARGV,$/) = shift; <> }

stdout_is { system("$^X ./bin/wdq lookup -g fr -n < t/examples/urls") }
    slurp('t/examples/lookup-urls'), 'lookup URLs, with language';

done_testing;
