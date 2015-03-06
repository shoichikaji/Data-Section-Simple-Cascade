requires 'perl', '5.008001';
requires 'mro';
requires 'parent';
requires 'Data::Section::Simple';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

