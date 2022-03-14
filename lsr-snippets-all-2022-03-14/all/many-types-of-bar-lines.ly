\header {
  texidoc = "
There are many types of bar lines available. 

"
  doctitle = "Many types of bar lines"
}
%% http://lsr.di.unimi.it/LSR/Item?id=89
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/bars.fr.html

%% Updated/modified by P.P.Schneider on Feb. 2014

\score {
  {  
    s4 \bar "|"    \mark \markup {  \simple "|" }
    s \bar "."     \mark \markup {  \simple "." }
    s \bar "||"    \mark \markup {  \simple "||" }
    s \bar ".|"    \mark \markup {  \simple ".|" }
    s \bar ".."    \mark \markup {  \simple ".." }
    s \bar "|.|"   \mark \markup {  \simple "|.|" }
    s \bar "|."    \mark \markup {  \simple "|." }
    s \bar ";"     \mark \markup {  \simple ";" }
    s \bar "!"     \mark \markup {  \simple "!" }
    s \bar ".|:"   \mark \markup {  \simple ".|:" }
    s \bar ":..:"  \mark \markup {  \simple ":..:" }
    s \bar ":|.|:" \mark \markup {  \simple ":|.|:" }
    s \bar ":|.:"  \mark \markup {  \simple ":|.:" }
    s \bar ":.|.:" \mark \markup {  \simple ":.|.:" }
    s \bar "[|:"   \mark \markup {  \simple "[|:" }
    s \bar ":|][|:"\mark \markup {  \simple ":|][|:" }
    s \bar ":|]"   \mark \markup {  \simple ":|]" }
    s \bar ":|."   \mark \markup {  \simple ":|." }
    s \bar "'"     \mark \markup {  \simple "'" }
    s \bar ""
  }
  \layout {
    indent = 0
    \context {
      \Score
      \override TimeSignature.stencil = ##f
      \override Clef.stencil = ##f
      \override RehearsalMark.padding = #3
    }
  }
}

