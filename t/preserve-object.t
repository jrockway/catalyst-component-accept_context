#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 4;

my $app = { app => 'oh yeah' };

my $foo = Foo->COMPONENT($app, { args => 'yes' });
is $foo->{args}, 'yes', 'foo created';
is $foo->context->{app}, 'oh yeah', 'got app';

my $ctx = { ctx => 'it is' };
my $foo2 = $foo->ACCEPT_CONTEXT($ctx);
is $foo, $foo2, 'foo and foo2 are the same ref';
is $foo->context->{ctx}, 'it is', 'got ctx';

{
    package Foo;
    use base qw/Catalyst::Component::ACCEPT_CONTEXT Catalyst::Component/;

    sub new {
        my $class = shift;
        return $class->NEXT::new(@_);
    }

}
