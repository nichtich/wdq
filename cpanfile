requires 'perl', '>= 5.14.0';

requires 'HTTP::Tiny','0.039';  # libhttp-tiny-perl
requires 'RDF::Query','2.902';  # librdf-query-perl
requires 'RDF::Trine','1.010';
    # implies JSON and URI

test_requires 'Test::More';
test_requires 'Test::Output';
test_requires 'Test::PerlTidy';
