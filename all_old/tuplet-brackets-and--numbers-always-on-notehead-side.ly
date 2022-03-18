%% http://lsr.di.unimi.it/LSR/Item?id=860
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms#tuplets

tupletAtNoteHeads =
        \override TupletBracket.before-line-breaking =
          #(lambda (grob)
            (let* ((tuplet-dir (ly:grob-property grob 'direction))
                   (note-columns (ly:grob-array->list (ly:grob-object grob 'note-columns)))
                   (note-heads-array-list 
                                (flatten-list
                                  (map 
                                    (lambda (x) 
                                      (ly:grob-object x 'note-heads))
                                        note-columns)))
                   (note-heads 
                   	(flatten-list 
                   	  (map 
                   	    (lambda (x) 
                   	      (ly:grob-array->list x)) 
                   	        note-heads-array-list)))
                  (stems (map (lambda (x) (ly:grob-object x 'stem)) note-heads))
                  (stem-dirs (map (lambda (x) (ly:grob-property x 'direction)) stems))
                  (sorted-stems-dirs-list (sort-list stem-dirs (lambda (a b) (< a b))))
                  (equal-stems-dir? (= (car sorted-stems-dirs-list) (car (reverse sorted-stems-dirs-list)))))
        (if (and equal-stems-dir? (= (car sorted-stems-dirs-list) tuplet-dir))
          (ly:grob-set-property! grob 'direction (* -1 (car sorted-stems-dirs-list)))
          ;; With 2.14.2 the log-warning is sometimes misleading.
          ;; Works nice with higher versions.
          (ly:warning "Kneed beam detected - if desired, adjust TupletBracket manually."))))

\relative c' {
        \override TupletBracket.bracket-visibility = ##t
        \tupletAtNoteHeads
        \tuplet 3/2 { a'8 b c }
        \tuplet 3/2 { r8 d e } 
        \tuplet 3/2 { r8 r f, }
        \tuplet 3/2 { g, a'' r } 
        \tuplet 3/2 { c,,8 c c }
        \tuplet 3/2 { r8 c c } 
        \tuplet 3/2 { r8 r c }
        \tuplet 3/2 { c c'' r }
}
