%% http://lsr.dsi.unimi.it/LSR/Item?id=781
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

\score {
  \new Staff <<
    \new Voice = "melody" {
      \relative c'' {
        a1 \repeat volta 2 {a} 
        b \repeat volta 2 {b}
    } }
    \context Lyrics ="line1" \with{ associatedVoice = "melody" } \lyricmode 
    {
      one 
      <<  % this is the 1st temporary lyric part
        \context Lyrics = "line1" { one }
        \context Lyrics = "line2" { two } 
        % the context "line2" dies here
      >>
      one 
      <<  % this is the 2nd temporary lyric part
        \context Lyrics = "line1" { one }
        \context Lyrics = "line2" { two }
      >>
    }
  >>
}
