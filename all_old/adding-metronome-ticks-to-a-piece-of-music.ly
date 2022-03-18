%% http://lsr.di.unimi.it/LSR/Item?id=876
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#metronome-marks


% LilyPond example to produce a piece of music with metronome ticks.
% The metronome ticks will (optionally) only be included in the midi file, not in
% the printed document.

% Global settings for each staff.
global = {
  \time 4/4
  \tempo 4 = 120
}

% Repeats one bar of music for the length of a reference piece.
% From: "Neil Puttock" <n.puttock@gmail.com>
% Usage: \makeUnfold \refPiece \oneBarOfMusic
makeUnfold =
#(define-music-function (parser location name mus) (ly:music? ly:music?)
  (let ((r (make-repeated-music "unfold")))
    (set! (ly:music-property r 'element) mus)
    (set! (ly:music-property r 'repeat-count)
          (ly:moment-main-numerator (ly:music-length name)))
    r))

% Chords staff.
harmonics = \chordmode {
  c2 g | c g | f1 | c2 g |
}

% Create metronome ticks. This example assumes 4/4 .
ticktock = \drummode {
  % Note that \makeUnfold \unfoldRepeats \harmonics basically is a way
  % repeat something for the duration of \harmonics. If you know the
  % number of bars you might as well write \repeat unfold ...
  \makeUnfold \unfoldRepeats \harmonics {
    hiwoodblock 4 lowoodblock lowoodblock lowoodblock
  }
}

% Everything combined.
allMusic = {
  <<
    \new ChordNames = Chords {

      \set ChordNames.midiInstrument = "percussive organ"
      \set ChordNames.midiMaximumVolume = #0.5
      \set chordChanges = ##t

      \global
      \harmonics
    }

    % Uncomment the next line if you want the ticks to be in the
    % MIDI file only.
    % \tag #'midiOnly
    \new DrumStaff = TickTock <<
      \new DrumVoice = "ticktock" {

	\set DrumStaff.instrumentName = "TickTock"
	\set DrumStaff.midiMaximumVolume = #0.8

	\global
	\ticktock
      }
    >>
  >>
}

%% Generate the printed score.
\score {
  \removeWithTag #'midiOnly \allMusic
  \layout {
  }
}

%% Generate the MIDI.
\score {
  \removeWithTag #'scoreOnly \unfoldRepeats \allMusic
  \midi {
  }
}
