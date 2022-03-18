%% http://lsr.di.unimi.it/LSR/Item?id=637
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides#tweaks-and-overrides-centering-markup-on-note-heads-automatically


#(define (Text_align_engraver ctx)
  (let ((scripts '())
        (note-column #f))

    `((acknowledgers
       (note-column-interface
        . ,(lambda (trans grob source)
             ;; cache NoteColumn in this Voice context
             (set! note-column grob)))

       (text-script-interface
        . ,(lambda (trans grob source)
             ;; whenever a TextScript is acknowledged,
             ;; add it to `scripts' list
             (set! scripts (cons grob scripts)))))

      (stop-translation-timestep
       . ,(lambda (trans)
            ;; if any TextScript grobs exist,
            ;; set NoteColumn as X-parent
            (and (pair? scripts)
                 (for-each (lambda (script)
                             (set! (ly:grob-parent script X) note-column))
                           scripts))
            ;; clear scripts ready for next timestep
            (set! scripts '()))))))

\layout {
  \context {
    \Voice
    \consists #Text_align_engraver
    \override TextScript.X-offset =
      #ly:self-alignment-interface::aligned-on-x-parent
    \override TextScript.self-alignment-X = #CENTER
  }
}

\new Staff <<
  \relative c'' {
    \override NoteColumn.force-hshift = #3
    c1-\markup { \arrow-head #Y #DOWN ##t }
  }
  \\
  \relative c' {
    a4 a-\markup { \huge ^ } a a
  }
>>
