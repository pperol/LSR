%% http://lsr.dsi.unimi.it/LSR/Item?id=506
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#polymetric-notation

%LSR contributed by John Mandereau, Reinhold Kainhofer on an idea by Werner Lemberg.
\score {
  \new StaffGroup <<
      \new Staff { c'1 c' c'4 }
      \new Staff { \clef bass d4 e f g a1 a4 }
      \new Staff \relative c' { \time 3/4 f8 e f g a4 g2.~ g4 f8 e f4 }
      \new Staff \relative c'' { a2 d, e c c4 }
  >>
  \layout {
    \context {
      \Score
      \remove Default_bar_line_engraver
      \remove Timing_translator
    }
    \context {
      \StaffGroup
      \remove Span_bar_engraver
    }
    \context {
      \Staff
      % the order of engravers matters here: e.g. if Timing_translator
      % comes after Default_bar_line_engraver, barlines are messed up.
      \consists Timing_translator
      \consists Default_bar_line_engraver
    }
  }
}

% Here is a more elaborate example:

vl = \relative c' { 
  \time 5/4 as8[ c d f]~ f[ as, c d] f[ as] | 
  \time 3/2 ces[ as f es] r des[ es f] as[ f] r4 |
}

vla = \relative c'' {
  \time 2/4 g8[( f] as[ a,!]) |
  \time 6/4 r4 e'4( f,) cis'4.( d,) | 
  \time 6/4 r4 e'( f,)
}

vlc = \relative c {
  \time 5/4 r2 r2. |
  \time 3/2 R1. |
}

cb = \relative c, {
  \time 5/4 bes4 c as g f |
  \time 3/2 des r g r r d' |
}

\new Score \with { 
                   \remove "Default_bar_line_engraver" 
                   \remove "Timing_translator" 
                   \remove "Span_bar_engraver" 
                 }
{
  \new StaffGroup="OuterGroup" \with { 
                                       \remove "Default_bar_line_engraver" 
                                       \remove "Span_bar_engraver"
                                       \remove "Timing_translator"
                                     }
  <<
    \new StaffGroup="UpperGroup" \with { 
                                              \remove "System_start_delimiter_engraver" 
                                              \consists "Default_bar_line_engraver" 
                                              \consists "Timing_translator" 
                                            } 
    <<
      \new Staff { \vl }
      \new Staff { \vl }
    >>
    \new Staff \with { 
                       \consists "Default_bar_line_engraver" 
                       \consists "Timing_translator" 
                     }
      { \clef "alto" \vla }
    \new StaffGroup="LowerGroup" \with { 
                                              \remove "System_start_delimiter_engraver" 
                                              \consists "Default_bar_line_engraver" 
                                              \consists "Timing_translator" 
                                            }
    <<
      \new Staff { \clef "bass" \vlc }
      \new Staff { \clef "bass_8" \cb }
    >>
  >>
}



