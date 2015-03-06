package Data::Section::Simple::Cascade;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";
use parent 'Data::Section::Simple';
use Exporter 'import';
our @EXPORT_OK = qw(get_data_section);

my %IGNORE = map { $_ => 1 } qw(Exporter Moose::Object Mouse::Object Moo::Object);

sub new {
    my $class = shift;
    my $package  = shift || caller;
    my $packages = do {
        require mro;
        mro::get_linear_isa($package);
    };
    $packages = [ grep { !$IGNORE{$_} } @$packages ];
    bless { _packages => $packages }, $class;
}

sub get_data_section {
    my $self = ref $_[0] ? shift : __PACKAGE__->new(scalar caller);
    return $self->SUPER::get_data_section(@_) if $self->{package};

    my @arg = @_;
    my @packages = @{$self->{_packages}};
    while (my $package = shift @packages) {
        local $self->{package} = $package;
        my $data = $self->SUPER::get_data_section(@arg);
        return $data if defined $data;
    }
    return;
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::Section::Simple::Cascade - read __DATA__ section from child to parent

=head1 SYNOPSIS

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

=head1 DESCRIPTION

Data::Section::Simple::Cascade is a subclass of L<Data::Section::Simple>,
which reads C<__DATA__> section from child to parent.

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@cpan.orgE<gt>

=cut

