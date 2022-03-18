%% http://lsr.di.unimi.it/LSR/Item?id=866
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats

%by: ArnoldTheresius

%tested: \version "2.22.0"

#(define-public (volta-repeats-only-once music)
  "This function replaces all 'percent volta' with 'sequential music', discarding all but the last alternative."
  (let*
   ((es (ly:music-property music 'elements))
    (e  (ly:music-property music 'element)))
   (if (memq 'repeated-music (ly:music-property music 'types))
    (let*
     ((props (ly:music-mutable-properties music))
      (old-name (ly:music-property music 'name)))
     (if (equal? old-name 'VoltaRepeatedMusic)
      (let*
       ((newprops (alist-copy props))
        (newprops (assoc-remove! newprops 'repeat-count))
        (last-of-elements (last-pair es))
        (newprops (assoc-set! newprops 'elements '()))
        (newprops (assoc-set! newprops 'element '()))
        (flattened  (flatten-alist newprops)))
       (set! es (cons e (if (pair? last-of-elements) last-of-elements '())))
       (set! e '())
       (set! music (apply make-music (cons 'SequentialMusic flattened)))))))
   (if (pair? es)
    (set! (ly:music-property music 'elements) (map volta-repeats-only-once es)))
   (if (ly:music? e)
    (set! (ly:music-property music 'element) (volta-repeats-only-once e)))
   music))

senzaRipet =
#(define-music-function (music) (ly:music?)
 (volta-repeats-only-once music))



M = {
  c'1 \tag #'a \repeat volta 2 { d' }
  \repeat volta 3 { e'1 }
  \alternative { { f'1 } { g' } { a' } }
}

\markup { \null \translate #'( 1 . -3 ) \null } % 2.14.2 LSR problem workaroud

\score {
  \new Staff { \M }
  \header {
    piece = "\\Music ="
  }
}

\score {
  \new Staff { \senzaRipet { \M } }
  \header {
    piece = "\\senzaRipet { \\Music } ="
  }
}

