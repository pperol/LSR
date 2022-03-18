%% http://lsr.di.unimi.it/LSR/Item?id=461
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#arpeggio


\new PianoStaff \relative c'' <<
  \set PianoStaff.connectArpeggios = ##t
  \new Staff {
    <c e g c>4\arpeggio
    <g c e g>4\arpeggio
    <e g c e>4\arpeggio
    <c e g c>4\arpeggio
  }
  \new Staff {
    \clef bass
    \repeat unfold 4 {
      <c,, e g c>4\arpeggio
    }
  }
>>
