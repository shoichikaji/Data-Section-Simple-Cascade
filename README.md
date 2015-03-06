# NAME

Data::Section::Simple::Cascade - read \_\_DATA\_\_ section from child to parent

# SYNOPSIS

Bar.pm

    package Bar;
    __DATA__
    @@ bar.txt
    hello from bar!

Foo.pm

    package Foo;
    use parent 'Bar';
    __DATA__
    @@ foo.txt
    hello from foo!

main.pl

    use Data::Section::Simple::Cascade;
    use Foo;
    my $reader = Data::Section::Simple::Cascade->new("Foo");

    $reader->get_data_section("foo.txt"); #=> hello from foo!
    $reader->get_data_section("bar.txt"); #=> hello from bar!

# DESCRIPTION

Data::Section::Simple::Cascade is a subclass of [Data::Section::Simple](https://metacpan.org/pod/Data::Section::Simple),
which reads `__DATA__` section from child to parent.

# LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Shoichi Kaji <skaji@cpan.org>
