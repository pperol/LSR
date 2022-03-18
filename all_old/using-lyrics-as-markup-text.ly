%% http://lsr.di.unimi.it/LSR/Item?id=744
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

#(define linebreakindicator "\\")

% \nl command that inserts the placeholder event into a lyrics
nl = #(make-music 'LineBreakEvent)

%% Function to extract strings from lyrics.
%  
#(define (lyrics->list lyrics)
"Return only syllables and hyphens from  @code{lyrics}."
         (if (ly:music? lyrics)
             (cond 
               ((eq? (ly:music-property lyrics 'name) 'LyricEvent) 
                (ly:music-property lyrics 'text))
               ((eq? (ly:music-property lyrics 'name) 'HyphenEvent) 
                (list "--"))
               ((eq? (ly:music-property lyrics 'name) 'LineBreakEvent)
                (list linebreakindicator))
               (else (let ((elt (ly:music-property lyrics 'element))
                       (elts (ly:music-property lyrics 'elements)))
                   (if (ly:music? elt)
                       (lyrics->list elt)
                       (if (null? elts)
                           '()
                           (map (lambda(x)
                                   (lyrics->list x))
                            elts)))))
                 )
             '()))

#(define (flatten-nonmarkup-list x)
  "Unnest list, but don't flatten markup constructs!"
  (cond ((null? x) '())
        ((not (pair? x)) (list x))
        (else (append (if (markup? (car x)) 
                          (list (car x)) 
                          (flatten-nonmarkup-list (car x)))
                      (flatten-nonmarkup-list (cdr x))))))

#(define (reduce-hyphens text) 
         (let eat ((wd (car text)) (wds (cdr text)))
                 (cond 
                   ((null? wds) (list wd))
                   ((and (equal? "--" (car wds)) (not (null? (cdr wds))))
                    (eat (markup #:concat (wd (cadr wds)))
                         (cddr wds)))
                   (else (cons (markup wd) (eat (car wds) (cdr wds)))))))

#(define (split-on predicate? l) 
        (let loop ((h '()) (r l))
                  (cond 
                    ((null? r)
                     (if (null? h) h (list (reverse h))))
                    ((predicate? (car r)) 
                     (if (null? h)
                         (loop h (cdr r))
                         (cons (reverse h) (loop '() (cdr r)))))
                    (else 
                      (loop (cons (car r) h) (cdr r))))))

#(define-markup-command (verse layout props lyrics) (ly:music?)
  "Verse command that marks up a column of \\nl-separated lines"
  (let* (

     (property (lambda (key default) 
                       (let ((a (assoc key (apply append props))))
                            (if (->bool a) (cdr a) default))))
     (display-nl (property 'display-nl #f))
     (make-line (property 'make-line make-justify-markup))
     
     (split-cond? (lambda (a) 
            (and (not display-nl)
                 (equal? a linebreakindicator))))
     (list-of-lines (map 
         (lambda (l) (make-line (reduce-hyphens l)))   
         (split-on split-cond? (flatten-nonmarkup-list (lyrics->list lyrics)))))
    )
    (interpret-markup layout props (make-column-markup list-of-lines)))
)
%%%%%%%%%%%%%%%%

test = \lyricmode{ 
  Du lil -- le \markup \italic fis -- \markup \italic ker \nl 
  Du \markup \italic lil -- \markup \italic le fis -- ker }

%{
<<
  \new Voice = "mel" \relative c'' { \partial 4. g8 a g e c r4 r8 g' a g | f d}
  \new Lyrics \lyricsto "mel" \test
>>
%}

\relative c'' { \partial 4. g8 a g e c r4 r8 g' a g | f d}
\addlyrics { \test }

\markup \line \bold { With line breaks (no overrides) }
\markup { \verse #test }
\markup \line \bold { With visible line break character }
\markup { \override #'(display-nl . #t) \verse #test }
%{ 
  To have left-aligned word-wrapping with 
  long lines, use 
  \markup { \override #`(make-line . ,make-wordwrap-markup) 
            \verse #words }
  (the default is make-justify-markup)
%}
