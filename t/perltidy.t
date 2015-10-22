use v5.14;
use Test::More;
use Test::PerlTidy;

if ( $ENV{RELEASE_TESTING} ) {
    my @files = ('script/wdq', Test::PerlTidy::list_files( path => 'lib' ));

    $Test::PerlTidy::MUTE=1;
    ok( Test::PerlTidy::is_file_tidy($_), $_ ) for @files;
} else {
    plan( skip_all => 'release test' );
}

done_testing;
