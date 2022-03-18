%% http://lsr.dsi.unimi.it/LSR/Item?id=780
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/text

bar = {
  \override TextScript.extra-spacing-width = #'(0 . 0)
  \override TextScript.Y-offset = #0
  \override TextScript.outside-staff-priority = ##f
  \override TextScript.self-alignment-X = #LEFT
  \override Stem.transparent = ##t
  \override NoteHead.transparent = ##t
  \override NoteHead.no-ledgers = ##t
}

<<
  \new Staff 
  \with { 
    \override StaffSymbol.line-count = #1 
    \override BarLine.bar-extent = #'(-1.5 . 1.5) 
  }
  \repeat unfold 6 
  \relative c' { 
    \bar c-\markup { i } c-\markup { hope } c-\markup { this } c-\markup { works } 
  }
  \new Staff 
  \with { 
    \override StaffSymbol.line-count = #1 
    \override BarLine.bar-extent = #'(-1.5 . 1.5) 
  }
  \repeat unfold 8 
  \relative c' { 
    \bar c-\markup { o } c-\markup { ooooooo } c-\markup { o } 
  }
>>
