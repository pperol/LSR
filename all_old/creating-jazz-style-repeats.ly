%% http://lsr.di.unimi.it/LSR/Item?id=753
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/multi_002dmeasure_002drest_002dinterface


#(define (white-under grob) (grob-interpret-markup grob 
  (markup #:vcenter #:whiteout #:pad-x 1 (ly:grob-property grob 'text))))

inlineMMRN = {
  \once \override MultiMeasureRest.layer = #-2
  \once \override MultiMeasureRestNumber.layer = #-1
  \once \override MultiMeasureRestNumber.Y-offset = #0
  \once \override MultiMeasureRestNumber.stencil = #white-under
}


ExampleMusic = {
  \override Score.MultiMeasureRest.minimum-length = #20 
  \inlineMMRN R1*4 
  \inlineMMRN R1*6 
  \inlineMMRN R1*8 
  \inlineMMRN R1*2 
}

{
  \set Score.skipBars = ##t
  \override Score.MultiMeasureRest.expand-limit = 1
  \ExampleMusic
}
