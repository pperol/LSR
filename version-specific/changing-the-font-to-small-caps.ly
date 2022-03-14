\version "2.18.0"

\header {
  texidoc = "
The font can be changed to small caps.



"
  doctitle = "Changing the font to small caps"
}
%% http://lsr.di.unimi.it/LSR/Item?id=100

<<
  \relative c'' { c4 c c8 c c }
  \addlyrics { what is \markup\caps { The } Ma -- trix?  }
>>

