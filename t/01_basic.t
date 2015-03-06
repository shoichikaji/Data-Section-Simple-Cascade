use strict;
use warnings;
use utf8;
use Test::More;
use lib "t/lib";
use Data::Section::Simple::Cascade;
use Foo;

my $r = Data::Section::Simple::Cascade->new("Foo");
for my $i (1..6) {
    my $data = $r->get_data_section("data$i");
    $data =~ s/\s+$//;
    is $data, "data${i}0";
}



done_testing;
