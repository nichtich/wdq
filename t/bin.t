use v5.14;
use Test::More;
use Test::Output;

my $exit;
sub wdq { system($^X, 'script/wdq', @_); $exit = $? >> 8 }
sub slurp { local (@ARGV,$/) = shift; <> }

foreach my $opt (qw(--help -h -?)) {
    output_like { wdq $opt } qr/^wdq /, qr/^$/, 'help';
    is $exit, 0;
}

foreach my $opt (qw(--version -V)) {
    output_like { wdq $opt } qr/^wdq \d+\.\d+\.\d+/, qr/^$/, 'version';
    is $exit, 0;
}

output_like { wdq '--foo' } qr/^$/, qr/^Unknown option: foo/, 'unknown option';
is $exit, 1;

stderr_is { wdq '--no-color', '--query', '{ ?s ?p x:foo }' }
    "invalid SPARQL query\n", "validate SPARQL";
is $exit, 1;

stderr_is { wdq '--no-color', '--format', 'x' }
    "unknown format: x\n", "unknown format";
is $exit, 1;

stdout_is { wdq qw(-nq t/examples/stackexchange.query) }
    slurp('t/examples/stackexchange.sparql'), 'no-execute';

stderr_is { wdq '-g123' }
    "invalid language(s): 123\n", "invalid language(s)";
is $exit, 1;

done_testing;
