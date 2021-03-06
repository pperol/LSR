%% http://lsr.di.unimi.it/LSR/Item?id=86
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/typesetting-mensural-music


upperStaff = \new VaticanaStaff = "upperStaff" <<
  \context VaticanaVoice <<
    \transpose c c {
      
      \override NoteHead.style = #'vaticana.punctum
      \key es \major
      \clef "vaticana-fa2"
      c1 des e f ges
      
      \override NoteHead.style = #'vaticana.inclinatum
      a! b ces'
      \bar "|"
      % \break % 1 (8*1)
      
      \override NoteHead.style = #'vaticana.quilisma
      b! des'! ges! fes!
      \breathe
      \clef "vaticana-fa1"
      \override NoteHead.style = #'vaticana.plica
      es d
      \override NoteHead.style = #'vaticana.reverse.plica
      c d
      \bar "|"
      % \break %2 (8*1)
      
      \override NoteHead.style = #'vaticana.punctum.cavum
      es f
      \override NoteHead.style = #'vaticana.lpes
      g as
      \override NoteHead.style = #'vaticana.upes
      bes as
      \override NoteHead.style = #'vaticana.vupes
      g f
      \override NoteHead.style = #'vaticana.linea.punctum
      \once \override Staff.BarLine.bar-extent = #'(-1 . 1) \bar "|"
      % \break % 3 (8*1)
      
      es d
      \override NoteHead.style = #'vaticana.epiphonus
      c d
      \override NoteHead.style = #'vaticana.cephalicus
      es f
      
      \override Staff.KeySignature.glyph-name-alist = #alteration-medicaea-glyph-name-alist
      \override Staff.Accidental.glyph-name-alist = #alteration-medicaea-glyph-name-alist
      \override Staff.Custos.style = #'medicaea
      \override NoteHead.style = #'medicaea.punctum
      \clef "medicaea-fa2"
      ces des
      \bar "|"
      % \break % 4 (8*1)
      
      e! f! ges
      \clef "medicaea-do2"
      \override NoteHead.style = #'medicaea.inclinatum
      a! b! ces'
      \override NoteHead.style = #'medicaea.virga
      b! a!
      \bar "|"
      % \break % 5 (8*1)
      
      ges fes
      \clef "medicaea-fa1"
      \override NoteHead.style = #'medicaea.rvirga
      e des ces
      
      \override Staff.KeySignature.glyph-name-alist = #alteration-hufnagel-glyph-name-alist
      \override Staff.Accidental.glyph-name-alist = #alteration-hufnagel-glyph-name-alist
      \override Staff.Custos.style = #'hufnagel
      \override NoteHead.style = #'hufnagel.punctum
      \clef "hufnagel-fa2"
      ces des es
      \bar "|"
      % \break % 6 (8*1)
      
      fes ges
      \clef "hufnagel-do2"
      \override NoteHead.style = #'hufnagel.lpes
      as! bes! ces'
      \override NoteHead.style = #'hufnagel.virga
      bes! as!
      \bar "|"
      % \break % 7 (8*1)
      
      ges! fes!
      \clef "hufnagel-do-fa"
      \override NoteHead.style = #'hufnagel.punctum
      es! des ces des! es! fes!
      \bar "||"
      % \break % 8 (8*1)
      
      s32*1
      % \break % 12 (32*1)
    }
  >>
>>

lowerStaff = \new MensuralStaff = "lowerStaff" <<
  \context MensuralVoice <<
    \transpose c c {
      
      \key a \major
      cis'1 d'\breve gis'\breve e'\breve \[ e'\longa fis'\longa \]
      \set Staff.forceClef = ##t
      \clef "neomensural-c2"
      cis1
      \bar "|"
      % \break % 2 (16*1)
      
      \[ g\breve dis''\longa \]
      b\breve \[ a\longa d\longa \]
      \clef "petrucci-c2"
      % \break % 4 (16*1)
      
      fis1 ces1
      \clef "petrucci-c2"
      r\longa
      \set Staff.forceClef = ##t
      \clef "mensural-c2"
      r\breve
      \bar "|"
      % \break % 5 (8*1)
      
      r2
      \clef "mensural-g"
      r4 r8 r16 r16
      \override NoteHead.style = #'mensural
      \override Rest.style = #'mensural
      \clef "petrucci-f"
      c8 b, c16 b, c32 b, c64 b, c64 b,
      d8 e d16 e d32 e d64 e d64 e
      r\longa
      \set Staff.forceClef = ##t
      \clef "petrucci-f"
      r\breve
      \bar "|"
      % \break % 6 (8*1)
      
      r\breve 
      \clef "mensural-f"
      r2 r4 r8 r16 r16
      
      \set Staff.forceClef = ##t
      \clef "mensural-f"
      e\breve f g a1
      \clef "mensural-g"
      % \break % 7 (8*1)
      
      \[ bes'!\longa a'!\longa c''!\longa \]
      e'1 d' c' d' \bar "|"
      \bar "|"
      % \break % 9 (16*1)
      
      bes'!\longa fis'!1 as'!1 ges'!\longa % lig
      \set Staff.forceClef = ##t
      \clef "mensural-g"
      e'2 d' c' \bar "|"
      % \break % 11 (16*1)
      
      \set Staff.forceClef = ##t
      \clef "petrucci-g"
      c'2 d' e' f'
      \clef "petrucci-g"
      g' as'! bes'! cis''!
      bes'! as'! gis'! fis'!
      \set Staff.forceClef = ##t
      \clef "mensural-g"
      es'! des'! cis'!1 \bar "||"
      % \break % 12 (8*1)
    }
  >>
>>

\score {
  <<
    \upperStaff
    \lowerStaff
  >>
  \layout {
    \context {
      \Score
      timing = ##f
    }
    \context {
      \MensuralVoice
      \override NoteHead.style = #'neomensural
      \override Rest.style = #'neomensural
      \override Flag.style = #'mensural
      \override Stem.thickness = #1.0
    }
    \context {
      \MensuralStaff
      \revert  BarLine.transparent
      \override KeySignature.glyph-name-alist = #alteration-mensural-glyph-name-alist
      clefGlyph = #"clefs.petrucci.c2"
    }
    \context {
      \VaticanaStaff
      \revert  BarLine.transparent
      \override StaffSymbol.thickness = #2.0
      \override KeySignature.glyph-name-alist = #alteration-vaticana-glyph-name-alist
      \override Custos.neutral-position = #4
    }
  }
}
