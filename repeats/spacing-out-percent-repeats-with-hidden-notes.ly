\version "2.18.0"

\header {
  texidoc = "
If you don't like the spacing used for percent repeats, you can enlarge
the percent bars by suitably adding hidden notes. 

"
  doctitle = "Spacing out percent repeats with hidden notes"
}
%% http://lsr.di.unimi.it/LSR/Item?id=11
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/spacing

\new Staff <<

  \new Voice {
    \repeat percent 3 \relative c'' { e e e e }
    \repeat percent 3 \relative c'' { e e e e }
  }
  
  \new Voice {
    s1 s s
    s1 \hideNotes \repeat unfold 8 c4 \unHideNotes 
  }

>>

