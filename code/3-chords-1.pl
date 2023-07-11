#!/usr/bin/env perl
use strict;
use warnings;

use Data::Dumper::Compact qw(ddc);
use MIDI::Util qw(setup_score midi_format);
use Music::Chord::Note ();
use Music::Scales qw(get_scale_MIDI);

my $score = setup_score();
$score->synch(
    sub { chords($score) },
);

$score->write_score("$0.mid");

sub chords {
    my ($score) = @_;

    my $mcn = Music::Chord::Note->new;

    for my $named (qw(Cm7 F7 BbM7 EbM7 Adim7 D7 Gm)) {
        my @chord = $mcn->chord_with_octave($named, 4);
        @chord = midi_format(@chord);
        print ddc(\@chord);  # [ 'C4', 'Ds4', 'G4', 'As4' ], etc.

        $score->n('wn', @chord);
    }
}
