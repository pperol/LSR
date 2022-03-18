%% http://lsr.dsi.unimi.it/LSR/Item?id=401
%% Upgraded by Paul Morris on Nov 11, 2013, see : http://lilypond.1069038.n5.nabble.com/Snippet-Using-non-standard-clef-positions-and-adding-customized-clef-definitions-td153775.html

% \header { title = "Non-standard clefs added manually and as a new definition" }

% manually setting all clef properties is one possibility:

myclef = {
  \set Staff.clefGlyph = #"clefs.neomensural.c"
  \set Staff.clefPosition = #1
  \set Staff.middleCPosition = #1 
}

% defining your own clef is another possibility. 
% You can then use \clef myCustomClef 

% Add a new clef called "myCustomClef", which describes a neomensural 
% C-clef shown between the third (center) and the fourth staff line. 
% Neither octavation nor adjustment of the position of middle C 
% relative to the clef (c0-position) is needed, so these arguments are 0.

% add-new-clef arguments: clef-name clef-glyph clef-position octavation c0-position

#(add-new-clef "myCustomClef" "clefs.neomensural.c" 1 0 0)

<<
  \context Staff = "Manual" \with { instrumentName = "Manual settings" } <<
    \myclef
    \relative c' { c4 c c c }
  >>
  \context Staff = "ClefDef" \with { instrumentName = "Clef definition" } <<
    \clef myCustomClef
    \relative c' { c4 c c c }
  >>
>>

% As of 11-11-2013 "add-new-clef" is defined in "parser-clef.scm" in LilyPond's source code.


