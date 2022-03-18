%% http://lsr.dsi.unimi.it/LSR/Item?id=391
%% see also http://www.lilypond.org/doc/v2.18/Documentation/learning/aligning-lyrics-to-a-melody
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/vocal-music
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/techniques-specific-to-lyrics
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

\header { title = "Lyrics above and/or below the staff" }

notes = \relative c' { c4 d e f | g a b c |}
lyricsAbove = \lyricmode { These ly -- rics placed a -- bove the staff... }
lyricsBelow = \lyricmode { These ly -- rics placed be -- low the staff... }

\score {
% Wrap everything in a parallel music section (otherwise you'll get errors!)
  <<
    % create empty dummy lyrics contexts, we'll do the actual assignment later
    % Important: The names will later be used to assign the correct placement!
    % We can't do the assignment before the voice has been defined, so the 
    % first Lyrics can't be replaced by \lyricsto, because the voice to which
    % it is assigned is not yet created there!!!
  
    % Lyrics above (because created before the staff)
    \new Lyrics = "above" { s4 }
    \new Staff <<
      \new Voice = "mainvoice" << \notes >>
    >>
    % Lyrics below (because created after the staff)
    \new Lyrics = "below" { s4 }
  
    % Now that we have created the Lyrics objects in the correct order, assign the lyrics
    % Notice the Lyrics = "name", where name is the same as in the above definitions!
    \context Lyrics = "above" \lyricsto "mainvoice" \lyricsAbove
    \context Lyrics = "below" \lyricsto "mainvoice" \lyricsBelow
  >>
}

