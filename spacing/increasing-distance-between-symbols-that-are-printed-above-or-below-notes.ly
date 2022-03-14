\version "2.18.0"

\header {
  texidoc = "
The @code{padding} property for objects with
@code{side-position-interface} can be set to increase distance between
symbols that are printed above or below notes. 

"
  doctitle = "Increasing distance between symbols that are printed above or below notes"
}
%% http://lsr.di.unimi.it/LSR/Item?id=9

\relative c' {
  c2\fermata
  \override Script.padding = #3
  b2\fermata
}

