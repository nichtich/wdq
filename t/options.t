use v5.14;
use Test::More;
use Test::Output;

my $exit;
sub qid {
    system('./wdq', @_); 
    $exit = $? >> 8;
}

output_like { qid '--help' } qr/^wdq \[OPTIONS\] < sparql/, qr/^$/,
    'help';
is $exit, 0;

output_like { qid '--version' } qr/^wdq \d+\.\d+\.\d+/, qr/^$/, 'version';
is $exit, 0;

output_like { qid '--foo' } qr/^$/, qr/^Unknown option: foo/, 'unknown option';
is $exit, 1;

done_testing;
