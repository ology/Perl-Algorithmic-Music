#!/usr/bin/env perl
use strict;
use warnings;

use Data::Dumper::Compact qw(ddc);
use MIDI::Util qw(setup_score midi_format);
use Music::Chord::Note ();

my $score = setup_score();
$score->synch(
    sub { chords($score) },
    sub { treble($score) },
) for 1 .. 2;

$score->write_score("$0.mid");

sub chords {
    my ($score) = @_;

    my $mcn = Music::Chord::Note->new;

    for my $named (qw(Cm7 F7 BbM7 EbM7 Adim7 D7 Gm Cm7)) {
        my @chord = $mcn->chord_with_octave($named, 4);
        @chord = midi_format(@chord);
        print ddc(\@chord);  # [ 'C4', 'Ds4', 'G4', 'As4' ], etc.

        $score->n('wn', @chord);
    }
}

sub treble {
    my ($score) = @_;

    set_chan_patch($score, 1, 0);

    my @pitches = (
        get_scale_MIDI('C', 4, 'major'),
        get_scale_MIDI('C', 5, 'major'),
    );

    for my $n (1 .. 4 * 8) { # bars * number of bars
        my $pitch = $pitches[int rand @pitches];
        $score->n('qn', $pitch);
        $score->r('qn');
    }
}
