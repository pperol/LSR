%% http://lsr.di.unimi.it/LSR/Item?id=871
%% see also http://lsr.di.unimi.it/LSR/Item?id=219
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/different-editions-from-one-source#using-tags

%by: ArnoldTheresius

%tested: \version "2.22.0"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START of my personal include file 'tagging.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (remove-all-tags music)
  (if (ly:music? music)
   (let*
    ((es (ly:music-property music 'elements))
     (e (ly:music-property music 'element))
     (as (ly:music-property music 'articulations))
     (tags (ly:music-property music 'tags)))
    (if (not (eq? tags '()))
     (ly:music-set-property! music 'tags '()))
    (for-each remove-all-tags es)
    (remove-all-tags e)
    (for-each remove-all-tags as))
   music))

removeAllTags =
#(define-music-function
  (music) (ly:music?)
  (_i "Delete all the tags in all elements of @var{music}")
  (let
   ((new-music (ly:music-deep-copy music)))
   (remove-all-tags new-music)
   new-music))


#(define (copy-tags-in-music tag-from tag-to music)
  (if (ly:music? music)
   (let*
    ((es (ly:music-property music 'elements))
     (e (ly:music-property music 'element))
     (as (ly:music-property music 'articulations))
     (tags (ly:music-property music 'tags)))
    (if (memq tag-from tags)
     (if (not (memq tag-to tags))
      (ly:music-set-property! music 'tags (cons tag-to tags))))
    (for-each (lambda (x) (copy-tags-in-music tag-from tag-to x)) es)
    (copy-tags-in-music tag-from tag-to e)
    (for-each (lambda (x) (copy-tags-in-music tag-from tag-to x)) as))
   music))

copyTag =
#(define-music-function
  (tag-from tag-to music) (symbol? symbol? ly:music?)
  (_i "To all elements of @var{music} which are tagged with @var{tag-from} add a tag @var{tag-to}.")
  (let
   ((new-music (ly:music-deep-copy music)))
   (copy-tags-in-music tag-from tag-to new-music)
   new-music))


#(define (rename-tag-in-music tag-from tag-to music)
  (if (ly:music? music)
   (let*
    ((es (ly:music-property music 'elements))
     (e (ly:music-property music 'element))
     (as (ly:music-property music 'articulations))
     (tags (ly:music-property music 'tags)))
    (if (memq tag-from tags)
     (let
      ((nt (delq tag-from tags)))
      (if (memq tag-to tags)
       (ly:music-set-property! music 'tags nt)
       (ly:music-set-property! music 'tags (cons tag-to nt)))))
    (for-each (lambda (x) (rename-tag-in-music tag-from tag-to x)) es)
    (rename-tag-in-music tag-from tag-to e)
    (for-each (lambda (x) (rename-tag-in-music tag-from tag-to x)) as))
   music))

renameTag =
#(define-music-function
  (tag-from tag-to music) (symbol? symbol? ly:music?)
  (_i "Replace an existing tag @var{tag-from} with tag @var{tag-to} in all elements of @var{music}")
  (let
   ((new-music (ly:music-deep-copy music)))
   (rename-tag-in-music tag-from tag-to new-music)
   new-music))


#(define (remove-tag-in-music tag music)
  (if (ly:music? music)
   (let*
    ((es (ly:music-property music 'elements))
     (e (ly:music-property music 'element))
     (as (ly:music-property music 'articulations))
     (tags (ly:music-property music 'tags)))
    (if (memq tag tags)
     (ly:music-set-property! music 'tags
      (filter (lambda (x) (not (eq? x tag))) tags)))
    (for-each (lambda (x) (remove-tag-in-music tag x)) es)
    (remove-tag-in-music tag e)
    (for-each (lambda (x) (remove-tag-in-music tag x)) as))
   music))

removeTag =
#(define-music-function
  (tag music) (symbol? ly:music?)
  (_i "Remove the specified tag @var{tag} in all elements of @var{music}")
  (let
   ((new-music (ly:music-deep-copy music)))
   (remove-tag-in-music tag new-music)
   new-music))


#(define (remove-tags-in-music tag-list music)
  (if (ly:music? music)
   (let*
    ((es (ly:music-property music 'elements))
     (e (ly:music-property music 'element))
     (as (ly:music-property music 'articulations))
     (tags (ly:music-property music 'tags)))
    (ly:music-set-property! music 'tags
     (filter (lambda (x) (not (memq x tag-list))) tags))
    (for-each (lambda (x) (remove-tags-in-music tag-list x)) es)
    (remove-tags-in-music tag-list e)
    (for-each (lambda (x) (remove-tags-in-music tag-list x)) as))
   music))

removeTags =
#(define-music-function
  (tag-list music) (list? ly:music?)
  (_i "Remove all the tags specified in the list @var{tag-list} in all elements of @var{music}")
  (let
   ((new-music (ly:music-deep-copy music)))
   (remove-tags-in-music tag-list new-music)
   new-music))


keepWithTags =
#(define-music-function
  (taglist music) (list? ly:music?)
  (_i "Include only elements of @var{music} that are tagged with at least one tag out of the list @var{taglist}.")
  (music-filter
   (lambda (m)
    (let*
     ((tags (ly:music-property m 'tags))
      (res #f))
     (for-each
      (lambda (tag) (if (memq tag tags) (set! res #t)))
      taglist)
     (or
      (eq? tags '())
      res)))
   music))


#(define (remove-with-tags taglist music)
  (music-filter
   (lambda (m)
    (let*
     ((tags (ly:music-property m 'tags))
      (result #t))
     (for-each
      (lambda (tag) (if (memq tag tags) (set! result #f)))
      taglist)
     (or
      (eq? tags '())
      result)))
   music))


#(define (keep-or-remove-with-tag keep-tag remove-taglist music)
  (music-filter
   (lambda (m)
    (let*
     ((tags (ly:music-property m 'tags))
      (res #t))
     (if (not (memq keep-tag tags))
      (for-each
       (lambda (tag) (if (memq tag tags) (set! res #f)))
       remove-taglist))
     (or
      (eq? tags '())
      res)))
   music))

keepOrRemoveWithTag =
#(define-music-function
  (keep-tag remove-taglist music) (symbol? list? ly:music?)
  (_i "Keep the elements of @var{music} which are tagged with @var{keep-tag}, otherwise remove them only if they are tagged with at least one symbol out the list @var{remove-taglist}.")
  (music-filter
   (lambda (m)
    (let*
     ((tags (ly:music-property m 'tags))
      (res #t))
     (if (not (memq keep-tag tags))
      (for-each
       (lambda (tag) (if (memq tag tags) (set! res #f)))
       remove-taglist))
     (or
      (eq? tags '())
      res)))
   music))


cleansedKeepOrRemoveWithTag =
#(define-music-function
  (keep-tag remove-taglist music) (symbol? list? ly:music?)
  (_i "Keep the elements of @var{music} which are tagged with @var{keep-tag}, otherwise remove them only if they are tagged with at least one symbol out the list @var{remove-taglist}. Finally wipe out all tags listed in the @var{remove-taglist} so they will not harm any future keepWithTag.")
  (let
   ((new-music (ly:music-deep-copy 
      (music-filter
       (lambda (m)
        (let*
         ((tags (ly:music-property m 'tags))
          (res #t))
         (if (not (memq keep-tag tags))
          (for-each
           (lambda (tag) (if (memq tag tags) (set! res #f)))
           remove-taglist))
         (or
          (eq? tags '())
          res)))
       music))))
   (remove-tags-in-music remove-taglist new-music)
   new-music))


taggedRep =
#(define-music-function
  (start-tag end-tag rep-count music) (symbol? symbol? integer? ly:music?)
  (_i "Repeat the @var{music} unfolded @var{rep-count} times. In the first repeat output keep @var{start-tag} and remove @var{end-tag} tagged elements, in the middle remove both, and at the end keep @var{end-tag} and remove @var{start-tag} tagged elements.")
  (if (<= rep-count 1)
   music
   (make-music 'SequentialMusic 'elements
    (if (<= rep-count 2)
     (list
      (keep-or-remove-with-tag start-tag (list start-tag end-tag) (ly:music-deep-copy music))
      (keep-or-remove-with-tag end-tag (list start-tag end-tag) (ly:music-deep-copy music)))
     (list
      (keep-or-remove-with-tag start-tag (list start-tag end-tag) (ly:music-deep-copy music))
      (make-music 'UnfoldedRepeatedMusic
       'elements '() 'repeat-count (- rep-count 2) 'element
       (remove-with-tags (list start-tag end-tag) (ly:music-deep-copy music)))
      (keep-or-remove-with-tag end-tag (list start-tag end-tag) (ly:music-deep-copy music)))))))

cleansedTaggedRep =
#(define-music-function
  (start-tag end-tag rep-count music) (symbol? symbol? integer? ly:music?)
  (_i "Repeat the @var{music} unfolded @var{rep-count} times. In the first repeat output keep @var{start-tag} and remove @var{end-tag} tagged elements, in the middle remove both, and at the end keep @var{end-tag} and remove @var{start-tag} tagged elements. Finally 'rub out' the remaining tags @var{start-tag} and @var{end-tag} from the music so they will not harm any \\keepWithTag in the future.")
  (let
   ((new-music
     (if (<= rep-count 1)
      music
      (make-music 'SequentialMusic 'elements
       (if (<= rep-count 2)
        (list
         (keep-or-remove-with-tag start-tag (list start-tag end-tag) (ly:music-deep-copy music))
         (keep-or-remove-with-tag end-tag (list start-tag end-tag) (ly:music-deep-copy music)))
        (list
         (keep-or-remove-with-tag start-tag (list start-tag end-tag) (ly:music-deep-copy music))
         (make-music 'UnfoldedRepeatedMusic
          'elements '() 'repeat-count (- rep-count 2) 'element
          (remove-with-tags (list start-tag end-tag) (ly:music-deep-copy music)))
         (keep-or-remove-with-tag end-tag (list start-tag end-tag) (ly:music-deep-copy music))))))))
   (remove-tags-in-music (list start-tag end-tag) new-music)
   new-music))

PSM = #'(Part Score Midi)

keepPart =
#(define-music-function (music) (ly:music?)
  #{ \cleansedKeepOrRemoveWithTag #'Part \PSM $music #} )

keepScore =
#(define-music-function (music) (ly:music?)
  #{ \cleansedKeepOrRemoveWithTag #'Score \PSM $music #} )

keepMidi =
#(define-music-function (music) (ly:music?)
  #{ \cleansedKeepOrRemoveWithTag #'Midi \PSM $music #} )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END of my personal include file 'tagging.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\markup { \null \translate #'( 1 . -3 ) \null } % 2.14.2 LSR problem workaroud

% Settings to keep all on one page:

\header  { tagline = ##f }

myLayout = \with {
  fontSize = #-4.5
  \override StaffSymbol.staff-space = #(magstep -4.5)
  \override StaffSymbol.thickness = #(magstep -4.5)
}

\paper { 
  score-markup-spacing =
    #'((basic-distance . 0)
       (minimum-distance . 0)
       (padding . 3.5)
       (stretchability . 0))
}

Music = {
  \tag #'A { a'4_"A"-\tag #'Strings ^"arco [for Strings]" -\tag #'Winds ^"non legato [for Winds]"}
  \tag #'B { b'4_"B" }
  \tag #'C { c''4_"C" }

  \tag #'Midi { d''32(_"Midi" \repeat unfold 7 { e''32 d'' } e'') }
  \tag #'Part \tag #'Score { e''2\trill -\tag #'Part _"Part" -\tag #'Score _"Score" }

  \tag #'InExposition { f''4_"Exp." }
  \tag #'InCoda { c''4_"Coda" }
}

\markup \fontsize #-3 \typewriter \override #'(baseline-skip . 1.7) \column {
  "Music = {"
  "  \\tag #'A { a'4_\"A\"-\\tag #'Strings ^\"arco [for Strings]\" -\\tag #'Winds ^\"non legato [for Winds]\"}"
  "  \\tag #'B { b'4_\"B\" }"
  "  \\tag #'C { c''4_\"C\" }"
  "  "
  "  \\tag #'Midi { d''32(_\"Midi\" \\repeat unfold 7 { e''32 d'' } e'') }"
  "  \\tag #'Part \\tag #'Score { e''2\\trill -\\tag #'Part _\"Part\" -\\tag #'Score _\"Score\" }"
  "  "
  "  \\tag #'InExposition { f''4_\"Exp.\" }"
  "  \\tag #'InCoda { c''4_\"Coda\" }"
  "}"
  " "
}

\score {
  \new Staff \with \myLayout {
    \keepWithTag #'FOO \removeAllTags \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \with-color #grey "\\keepWithTag #'FOO" \bold "\\removeAllTags" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \keepWithTags #'(Strings A Part InCoda) \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \bold "\\keepWithTags #'(Strings A Part InCoda)" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \keepWithTag #'Part \copyTag #'A #'Part \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \with-color #grey "\\keepWithTag #'Part" \bold "\\copyTag #'A #'Part" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \keepWithTag #'FOO \removeTag #'B \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \with-color #grey "\\keepWithTag #'FOO" \bold "\\removeTag #'B" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \keepWithTag #'FOO \removeTags #'(A B C) \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \with-color #grey "\\keepWithTag #'FOO" \bold "\\removeTags #'(A B C)" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \keepWithTag #'Part \renameTag #'B #'Part \renameTag #'InCoda #'Part \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \with-color #grey "\\keepWithTag #'Part"
                      \bold "\\renameTag #'B #'Part \\renameTag #'InCoda #'Part" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \keepOrRemoveWithTag #'Part #'(Part Score Midi) \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \bold "\keepOrRemoveWithTag #'Part #'(Part Score Midi)" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \keepWithTag #'FOO \cleansedKeepOrRemoveWithTag #'Part #'(Part Score Midi) \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \with-color #grey "\\keepWithTag #'FOO" \bold "\\cleansedKeepOrRemoveWithTag #'Part #'(Part Score Midi)" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \keepWithTag #'FOO \keepPart \Music
  }
  \header {
    piece = \markup \fontsize #-3 { \with-color #grey "\\keepWithTag #'FOO" \bold "\\keepPart" \italic "\\Music" }
  }
}

\score {
  \new Staff \with \myLayout {
    \taggedRep #'FirstOnly #'LastOnly #5 {
      c'16 -\tag #'FirstOnly \f \< d' e' f' g' a' b' c''
      d''\> c'' b' a' g' f' e' d' -\tag #'LastOnly \p
    }
  }
  \header {
    piece = \markup \fontsize #-3 {
      \bold "\\taggedRep #'FirstOnly #'LastOnly #5 "
      \scale #'(0.95 . 1.0) "{ c'16 -\\tag #'FirstOnly \\f \\< d' ... d''\\> ... d' -\\tag #'LastOnly \\p }"
    }
  }
}
