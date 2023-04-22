#!/usr/bin/env perl
use strict;
use warnings;

use MIDI::Util qw(setup_score);

my $score = setup_score();

$score->synch(
    sub { bass($score) },
    sub { treble($score) },
);

$score->write_score("$0.mid");

sub bass {
    my ($score) = @_;

    for my $note (qw(C3 E3 G3 C4)) {
        $score->n('wn', $note);
    }
}

sub treble {
    my ($score) = @_;

    for my $note (qw(E4 E4 F4 G4  G4 F4 E4 D4  C4 C4 D4 E4  E4 D4 D4)) {
        $score->n('qn', $note);
    }
}
