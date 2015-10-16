# wdq coding guidelines

**wdq** is written in Perl. The current version is one single Perl script,
located in `bin/wdq`. Files in `lib/` are optional for documentation only.  A
future version may better be organized in modules and use `App::FatPacker` to
build a single executable.

Code MUST be cleaned up with standard `perltidy`:

    perltidy -b bin/wdq lib/App/wdq.pm

Please enable this git pre-commit hook in executable `.git/hooks/pre-commit` to
prevent against committing failing tests:

    #!/bin/sh
    RELEASE_TESTING=1 prove -l -j8

