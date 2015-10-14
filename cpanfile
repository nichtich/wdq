requires 'perl', '>= 5.14.0';

requires 'HTTP::Tiny','0.039';  # libhttp-tiny-perl
requires 'RDF::Query','2.902';  # librdf-query-perl
    # implies RDF::Trine, JSON, URI

test_requires 'Test::More';
test_requires 'Test::Output';
