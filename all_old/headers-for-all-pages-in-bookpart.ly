%% http://lsr.dsi.unimi.it/LSR/Item?id=655

odbolTagline = \markup {
  Music engraving by \italic { Score Your Music } (url.example.net)
  using LilyPond (www.lilypond.org)
}

%LSR The part to cut and paste follows

#(define (part-not-first-page layout props arg)
   (if (not (= (chain-assoc-get 'page:page-number props -1)
               (ly:output-def-lookup layout 'first-page-number)))
       (interpret-markup layout props arg)
       empty-stencil))

\paper {
  oddHeaderMarkup = \markup
  \fill-line {
    " " 
    \on-the-fly #part-not-first-page \fontsize #-4.0 \fromproperty #'header:subtitle
    \on-the-fly #print-page-number-check-first \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \on-the-fly #print-page-number-check-first \fromproperty #'page:page-number-string
    \on-the-fly #part-not-first-page \fontsize #-4.0 \fromproperty #'header:subtitle
    " "
  }
}

%LSR End of the part to cut and paste follows

bNC = % Abbreviation for barNumberCheck to reduce typing
#(define-music-function (parser location barNumber) (integer?)
  #{
    \barNumberCheck #barNumber
  #}
)

timeKey = {
  \key e \minor
  \time 3/4
}

firstPart = {
  r8 b'8 e'' fis'' g''4 ~ |
  g''8 fis'' a'' g'' fis'' e'' |
  dis''16 cis'' b' cis'' d''8 e'' fis''4 ~ |
  fis''8 e'' g'' fis'' e'' d'' |

  cis''8 cis'' fis'' g'' a''4 ~ |
  a''8 fis'' a'' g'' fis'' e'' |
  dis''8 fis'' g'' a'' b'' g'' |
  e''4 ~ e''8 e'' fis'' g'' |

  a''4 g''2 ~ |
  g''8 e'' g'' fis'' e'' d'' |
  cis''4. d''8 e'' fis'' |
  g''4 fis''8 e'' d''4 ~ |

  d''8 cis'' e'' d'' cis'' b' |
  b'4 r4 r4 |
  R2. | \bNC #16
  r8 fis'8 b' cis'' d''4 ~ |

  d''8 cis'' e'' d'' cis'' b' |
  ais'16 fis'' e'' d''  cis'' fis'' cis'' b'  ais' cis'' ais' gis' |
  fis'4 r4 fis''4 ~ |
  fis''16 b'' g'' fis'' e''  g'' e'' d'' cis''  g'' cis'' b' |

  a'4 r4 e''4 ~ |
  e''16 a'' fis'' e''   d'' fis'' d'' cis''   b' fis'' b' a' |
  g'2. ~ |
  g'2. |

  fis'8 a' d'' e'' fis''4 ~ |
  fis''8 e'' g'' fis'' e'' d'' |
  c''16 e'' a'' g''  fis'' a'' fis'' e''  d'' a'' d'' cis'' |
  b'16 d'' g'' fis''  e'' g'' e'' d''  cis'' g'' cis'' b' |

  a'2 ~ a'16 a' g' fis' |
  g'16 e' ais' b'  cis'' fis' cis''  d'' e'' fis'' g'' e'' |
  fis''16 g'' fis'' e''  d'' fis'' d'' cis''  b' fis'' b' a' | \bNC #32
  gis'16 fis' gis' a'  b' gis' b' c''  d'' gis' d'' e'' |

  f''16 b'' e'' d''  c'' e'' c'' b'  a' e'' a' g' |
  fis'16 e' fis' g'  a' fis' a' b'  c'' fis' c'' d'' |
  ees''16 a'' ees'' d''  c'' ees'' c'' bes'  a' c'' a' g' |
  fis'16 e' dis' e'  fis' dis' fis' g'  a' dis' a' b' |

  c''8 b' e'' fis'' g''4 ~ |
  g''8 fis'' a'' g'' fis'' e'' |
  dis''4 d''2 ~ |
  d''8 gis' a' b' c''4 ~ |

  c''8 e'' a'' b'' c'''4 ~ |
  c'''16 b'' a'' g'' fis'' a'' dis'' e'' fis''4 ~ |
  fis''16 b'' dis'' e'' e''4 dis''4 | \bNC #44
  e''2. |
}

secondPart = {
  R2. |
  R2. |
  r8 fis'8 b' cis'' d''4 ~ |
  d''8 cis'' e'' d'' cis'' b' |

  ais'16 gis' fis' gis'  a'8 b' c''4 ~ |
  c''8 a' c'' b' a' g' |
  fis'4 r8 b'8 e'' dis'' |
  cis''4 ~ cis''8 cis'' dis'' e'' |

  fis''4. b'8 e'' d'' |
  cis''4. d''8 cis'' b' |
  ais'4. b'8 cis'' d'' |
  e''8 d'' cis''4. fis'8 |

  ais'2 ais'4 |
  b'8 b e' fis' g'4 ~ |
  g'8 fis' a' g' fis' e' | \bNC #16
  dis'4 r8 fis'8 b'16 a' g' fis' |

  e'4. fis'8 g' e' |
  cis'8 fis cis' d' e'4 ~ |
  e'16 g' fis' e'  d' fis' d' cis'  b fis' b a |
  g4 r4 g'4 ~ |

  g'16 g' e' d'  cis' e' cis' b  a e' a g |
  fis4 r4 fis'4 ~ |
  fis'8 e'16 d'  cis' e' cis' b  a8 b |
  cis'8 a16 b  cis'8 e' a cis' |

  d'8 d16 e  fis d fis g  a d a b |
  cis'16 a cis' d' e' a e' fis'  g' a' b' g' |
  a'2. |
  g'2. ~ |

  g'16 g' fis' e' d' fis' d' cis'  b4 ~ |
  b8 r8 r4 r4 |
  r8 fis8 b cis' d'4 ~ | \bNC #32
  d'8 b d' c' b a |

  gis8 e a b c'4 ~ |
  c'8 a c' b a g |
  fis4. g8 a4 ~ |
  a8 g c' b a g |

  fis4 r4 r8 b'8 |
  e''8 d'' c'' b' a' g' |
  fis'8 c'' b' a' gis' b' |
  e'4 fis'8 gis' a' e' |

  a' b' c'' e'' a'' g'' |
  fis''4 r4 r16 c''16 b' a' |
  g'4 fis'8 g' a'4 | \bNC #44
  gis'2. |
}

thirdPart = {
  e8 e, r8 b8 e' d' |
  c'4. b8 a c' |
  b4. a8 g fis |
  e4. fis8 g e |

  fis4 ~ fis16 g a g fis e dis e |
  dis4 r8 e8 c a, |
  b,8 b e' fis' g'4 ~ |
  g'8 fis' a' g' fis' e' |

  dis'8 b e' d' cis' b |
  ais4. b8 cis' d' |
  e'16 d' e' fis' g'8 fis' e' d' |
  cis'8 b ais fis b ais |

  g8 e fis4 fis,4 |
  b,16 fis b a  g b g fis e b e d |
  c16 g e d  c e c b,  a, b, c a, | \bNC #16
  b,16 g fis e  d fis d cis  b, fis b, a, |

  g,16 d b, a,  g, b, g, fis,  e, fis, g, e, |
  fis,8 fis ais b cis' fis |
  b4 r8 b,8 cis d |
  e4 r8 fis8 e d |

  cis4 r8 a, b, cis |
  d4 r8 e d cis |
  b,16 b g fis  e g e d  cis g cis b, |
  a, e cis b,  a, cis a, g,  fis, cis fis, e, |

  d,8 r8 r4 r4 |
  R2. |
  r8 a,8 d e fis4 ~ |
  fis8 e g fis e d |

  cis8 fis, b, cis d4 ~ |
  d8 cis e d cis b, |
  ais,4 b, r8 d8 | \bNC #32
  e8 d f e d c |

  b,8 gis, r4 r8 c8 |
  d8 c e d c a, |
  d8 a, d e fis4 ~ |
  fis8 e a g fis e |

  dis4 r8 b,8 e dis |
  c2. ~ |
  c16 c' b a  gis b gis fis  e b e d |
  c16 f e d  c e c b,  a, e a, g, |

  fis,16 d c b,  a, c a, g,  fis, c fis, e, |
  dis,4 r4 r4 |
  e,4 b,2 | \bNC #44
  e,2. |
}

toUpperStaff = {
  \change Staff = "upper"
  \voiceTwo
}

toLowerStaff = {
  \change Staff = "lower"
  \stemUp
}

firstPartLayout = {
  \voiceOne

  s2.*30 | % 1

  \oneVoice

  s2.*6 | % 1

  \voiceOne

  s2.*8 | % 1
}

secondPartLayout = {
  s2.*17 | % 1-17

  \barNumberCheck #18

  s8
  \toLowerStaff
  s8
  \toUpperStaff
  s2 | % 18

  s2 s16*3
  \toLowerStaff
  s16 | % 19

  \showStaffSwitch
  s4
  \toUpperStaff
  s2 | % 20
  \hideStaffSwitch

  \showStaffSwitch
  s2
  \toLowerStaff
  s16
  \hideStaffSwitch
  \toUpperStaff
  s16
  \toLowerStaff
  s16*2 | % 21

  s4
  \showStaffSwitch
  \toUpperStaff
  s2 | % 22
  \hideStaffSwitch

  \showStaffSwitch
  s2
  \toLowerStaff
  s4 | % 23
  \toUpperStaff

  s8
  \hideStaffSwitch
  \toLowerStaff
  s8
  \toUpperStaff
  s4
  \toLowerStaff
  s8
  \toUpperStaff
  s8 | % 24

  s8
  \toLowerStaff
  s8 s2 | % 25

  \toUpperStaff
  s16
  \toLowerStaff
  s16
  \toUpperStaff
  s16*2 s16
  \toLowerStaff
  s16
  \toUpperStaff
  s8 s4 | % 26

  s2.*4 | % 27-30

  \barNumberCheck #31

  \showStaffSwitch
  \toLowerStaff
  s2.*6 | % 31-36
  \hideStaffSwitch

  s4
  \showStaffSwitch
  \toUpperStaff
  s2 | % 37
  \hideStaffSwitch

  s2.*7 | % 38-44

  \barNumberCheck #45
}

thirdPartLayout = {
  \oneVoice

  s2.*17 | % 1-17

  \barNumberCheck #18

  \voiceTwo

  s2.*2 | % 18-19

  \barNumberCheck #20

  \oneVoice

  s2. | % 20

  \voiceTwo

  s2.*6 | % 21-26

  \barNumberCheck #27

  \oneVoice

  s2.*4 | % 27-30

  \barNumberCheck #31

  \voiceTwo

  s2.*6 | % 31-36

  \barNumberCheck #37

  s4
  \oneVoice
  s2 | % 37

  s2.*7 | % 38-44

  \barNumberCheck #45
}

thirdPartClefChanges = {
  \clef bass

  s2.*6 | % 1-6

  \barNumberCheck #7

  s8 \clef alto \key e \minor s8 s2 | % 7

  s2.*5 | % 8-12

  \barNumberCheck #13

  \clef bass \key e \minor

  s2.*32 | % 13-44

  \barNumberCheck #45
}

\header {
  title = \markup { \center-column { "Three-Part Inventions" \null } }
  subtitle = \markup{ \fontsize #5.0 "Sinfonia 7" }
  composer = "Johann Sebastian Bach"
  copyright = \markup { \center-column { "Music in the public domain" } }
  tagline = \odbolTagline
}

\bookpart {
  \score {
    \new PianoStaff = Keyboard <<
      \new Staff = "upper" <<
        { \timeKey \clef soprano }
        \new Voice = "first" { << { \firstPartLayout } { \voiceOne \firstPart } >> }
        \new Voice = "second" { << { \secondPartLayout } { \voiceTwo \secondPart \bar "|." } >> }
      >>
      \new Staff = "lower" <<
        { \timeKey \clef bass }
        \new Voice = "third" { <<
            { \thirdPartLayout } { \thirdPartClefChanges }
            { \thirdPart \bar "|." }
        >> }
      >>      
    >>
  }
}



