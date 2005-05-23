#!/usr/bin/perl
# $Id: 01run.t,v 1.1 2005/05/23 15:31:25 rousse Exp $

use Test::More tests => 7;
use File::Temp qw/tempfile/;
use Dict::FSA;
use strict;

my @words = map { chomp; $_} <DATA>;
my ($hf, $file) = tempfile(CLEANUP => 1);
Dict::FSA->create_dict(\@words, $file);

ok(-f $file);

my $dict = Dict::FSA->new(1, [ $file ]);
isa_ok($dict, 'Dict::FSA');

ok($dict->check("paume"));
ok($dict->check("plume"));
ok(!$dict->check("poume"));

ok(eq_array([ $dict->suggest("poume") ], [ qw/plume paume/ ])); 
ok(eq_array([ $dict->suggest("paume") ], [ qw/plume/ ])); 

__DATA__
paume
plume
