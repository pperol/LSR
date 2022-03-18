%% http://lsr.dsi.unimi.it/LSR/Item?id=661
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-wind-instruments

%LSR contributed by Libero Mureddu

centermarkup = {
  \once \override TextScript.self-alignment-X = #CENTER
  \once \override TextScript.X-offset =#(ly:make-simple-closure
    `(,+
      ,(ly:make-simple-closure (list
        ly:self-alignment-interface::centered-on-x-parent))
      ,(ly:make-simple-closure (list
        ly:self-alignment-interface::x-aligned-on-self))))
}

\score {
  \relative c'{
    g\open
    \once \override TextScript.staff-padding = #-1.0 
    \centermarkup
    g^\markup { 
      \combine 
        \musicglyph #"scripts.open" 
        \musicglyph #"scripts.tenuto"
    }
    \centermarkup 
    g^\markup {
      \combine 
        \musicglyph #"scripts.open"
        \musicglyph #"scripts.stopped"
    }
    g\stopped
  }
}
