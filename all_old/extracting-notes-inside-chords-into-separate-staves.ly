%% http://lsr.dsi.unimi.it/LSR/Item?id=545
%% see also http://lsr.dsi.unimi.it/LSR/Item?u=1&id=761
%% see for upgrade http://gillesth.free.fr/Lilypond/extractMusic/

%% by Gilles Gilles THIBAULT.
%% for Lilypond 2.16 or higher.
%% version 2013/04/16 : last change = replace chord-elts->note
%% by chord->note. You can now specified several numbers, to
%% extract several notes at one time


#(define (noteEvent? music)
(eq? (ly:music-property music 'name) 'NoteEvent))

#(define (no-duration? music)
(not (ly:duration? (ly:music-property music 'duration))))

#(define (expand-q-chords music); for q chords : see chord-repetition-init.ly
(expand-repeat-chords! (list 'rhythmic-event) music))

%%%%%%%%%%%%%%%%%%%%%%%%%%  extractNote  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#(define tagNotExtractNote (gensym))
#(use-modules (ice-9 receive)) %% for the use of receive

#(define (chord->note chord n . args)
"Return the note n of one chord, keeping articulations.
Other numbers can be specified in args"
(receive (notes others)
 (partition noteEvent? (ly:music-property chord 'elements))
 (if (null? notes)
   chord
   (let* ((len (length notes))
          (res (filter-map
            (lambda(i)
              (and (integer? i)
                   (<= i len)
                   (> i 0)
                   (list-ref notes (1- i)))) ; list-ref is zero-based
            (cons n args)))
           (one-note (cond 
             ((null? res) (list-ref notes (1- len)))
             ((null? (cdr res))(car res))
             (else #f))))
      (if one-note
        (begin
          (ly:music-set-property! one-note 'articulations 
            (append (ly:music-property one-note 'articulations) others))
          one-note)
        (make-event-chord (append res others)))))))
         
#(define (extract-note music n . args)
"Extract the note n of each chords in music, keeping articulations.
If other numbers are given in args, the function returns a chord build with all
matching notes. If no note matches, returns the last note of the chord."
 (map-some-music 
   (lambda (evt)
      (cond 
        ((eq? 'EventChord (ly:music-property evt 'name))
           (let ((tags (ly:music-property evt 'tags)))
              (if (memq tagNotExtractNote tags)
                 (ly:music-set-property! evt 'tags ; only remove the tag
                     (delq tagNotExtractNote tags))
                 (set! evt (apply chord->note evt n args)))
              evt))
        (else (and (ly:music-property evt 'duration #f) evt))))
   (expand-q-chords music)))

%% TO DO : add a parameter optional pred?
extractNote = #(define-music-function (parser location n music )
                                                            (number? ly:music?)
 (extract-note music n))

% usefull for notExtractNote
tagify = #(define-music-function (parser location tag music)(symbol? ly:music?)
"Add `tag in the tags property of all chords"
(music-map
	(lambda (evt)
    (if (eq? 'EventChord (ly:music-property evt 'name))
       (ly:music-set-property! evt 'tags
             (cons tag (ly:music-property evt 'tags))))
		evt)
	music))
notExtractNote = #(define-music-function (parser location music)(ly:music?)
"Avoids music to be extracted by \\extractNote."
#{
  \tagify #tagNotExtractNote $music
#})


music = \relative c' {
  <c e g>4-> <d f>( <b g' d'>) <c e g>-.
  g2 c2
}

\score {
  <<
    \new Staff \music 
    \new Staff \extractNote #3 \music
    \new Staff \extractNote #2 \music
    \new Staff \extractNote #1 \music
  >>
}
