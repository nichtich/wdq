use v5.14;
use Test::More;
use Test::Output;

my $exit;
sub qid { system($^X, './bin/wdq', @_); $exit = $? >> 8 }
sub slurp { local (@ARGV,$/) = shift; <> }

output_like { qid '--help' } qr/^wdq \[OPTIONS\] < sparql/, qr/^$/,
    'help';
is $exit, 0;

output_like { qid '--version' } qr/^wdq \d+\.\d+\.\d+/, qr/^$/, 'version';
is $exit, 0;

output_like { qid '--foo' } qr/^$/, qr/^Unknown option: foo/, 'unknown option';
is $exit, 1;

stdout_is { qid qw(--dry -s t/examples/stackexchange.query) }
    slurp('t/examples/stackexchange.sparql'), '--dry and prefixes';

stderr_is { qid '-s', '{ ?s ?p x:foo }' }
    "Invalid SPARQL query!\n", "validate SPARQL";
is $exit, 1;

done_testing;
