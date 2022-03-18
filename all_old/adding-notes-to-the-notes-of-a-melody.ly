%% http://lsr.dsi.unimi.it/LSR/Item?u=1&id=761
%% see also http://lsr.dsi.unimi.it/LSR/Item?u=1&id=545
%% see for snippet upgrade http://gillesth.free.fr/Lilypond/addAt/

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

%%%%%%%%%%%%%%%%%%%%%%%%%%  extractVoice  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#(define tagNotExtractVoice (gensym))

#(define (extract-voice voices n)
(let ((len (length voices)))
 (list-ref voices (1-     ; list-ref is zero-based
  (if (and (<= n len)(> n 0)) n len)))))

extractVoice = #(define-music-function (parser location x music )
                                                            (number? ly:music?)
"Round x to the natural number just underneath (let's call it n), then extract
music from the n-th voice of all simultaneous music of the same level, keeping 
only basic music events (no more \\Voicexxx or \\new Voice).
If a voice then splits itself into another voices, the first decimal digit is 
taken as number for the extraction, and so on ..."
(let loop ((evt (music-filter
              (lambda(x) 
                (let ((name (ly:music-property x 'name)))
                  (not (or (memq name (list 
                                'OverrideProperty 'PropertySet 'VoiceSeparator))
                           (and (eq? name 'ContextSpeccedMusic)
                                (null? (ly:music-property x 'element)))))))
               music)))
  (if (no-duration? evt)
    (let ((elt (ly:music-property evt 'element))
          (elts (ly:music-property evt 'elements))
          (name (ly:music-property evt 'name)))
      (if (ly:music? elt) 
        (case name
           ((ContextSpeccedMusic) (set! evt (loop elt)))
           (else (ly:music-set-property! evt 'element (loop elt)))))
      (if (pair? elts)
        (case name
           ((EventChord) evt)                       ; don't enter inside chords
           ((SimultaneousMusic)
              (let ((tags (ly:music-property evt 'tags)))
                 (if (memq tagNotExtractVoice tags)
                   (ly:music-set-property! evt 'tags ; only remove the tag
                                                 (delq tagNotExtractVoice tags))
                   (let*((save-x x)                 ; for x = 4.321, we have :
                         (n  (truncate x))          ; n = 4
                         (y (- (* 10  x)(* 10 n)))) ; y = 43.21 - 40 = 3.21
                      (set! evt (extract-voice elts (inexact->exact n)))
                      (set! x (if (< y 1) n y)) ; keep n if (truncate y) = 0
                      (set! evt (loop evt))     ; SimultaneousMusic inside?
                      (set! x save-x)))))
           (else (ly:music-set-property! evt 'elements (map loop elts)))))))
  evt))

notExtractVoice = #(define-music-function (parser location music)(ly:music?)
"Inside an \\extractVoice section, avoids that a part of this section (called
here `music) to be extracted."
#{
  \tag #tagNotExtractVoice $music
#})


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% derivated functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% If you have enter << <c e g> \\ <ais cis fis> >>, the first function will
%% give you c, the second fis
extractPartUpper = #(define-music-function (parser location music )(ly:music?)
 #{ \extractNote #1000 \extractVoice #1 $music    #})

extractPartLower = #(define-music-function (parser location music )(ly:music?)
 #{ \extractNote #1 \extractVoice #1000 $music    #})
                          %%%%%% shortcuts %%%%%%%
#(define ePU extractPartUpper)
#(define ePL extractPartLower)


%%%%%%%%%%%%%%%%%%%%% addNote

#(define (add-note music notes-to-add)                ; notes-to-add as music
  (define (note->chords-arti note)                    ; note as a NoteEvent
    (receive (note-arti chord-arti)
      (partition      ; separates arti for NoteEvent from arti for EventChord
        (lambda (evt)(memq (ly:music-property evt 'name)
                       (list 'StringNumberEvent 'StrokeFingerEvent 'FingeringEvent)))
        (ly:music-property note 'articulations))
      (ly:music-set-property! note 'articulations note-arti)
      chord-arti))
  (let* ((alist      ; a list of pairs of 2 lists : '(notes . articulations)
          (reverse (let loop ((m (expand-q-chords notes-to-add)) ; q to chords
                              (p '())) ; m = music, p previous value of the list
            (case (ly:music-property m 'name)
              ((or SkipEvent SkipMusic) ; a skip in notes-to-add means : add nothing
                 (cons #f p))           ; add #f to the list
              ((NoteEvent) 
                 (acons (list m) (note->chords-arti m) p))
              ((EventChord)
                 (receive (notes arti) ; separates notes from scripts, dynamics etc
                   (partition noteEvent? (ly:music-property m 'elements))
                   (if (pair? notes)(acons notes arti p) p)))
              (else (let ((e (ly:music-property m 'element)))
                 (fold loop
                       (if (ly:music? e)(loop e p) p)
                       (ly:music-property m 'elements))))))))
        (entry #f)  ; will be (car alist)
        (entry? (lambda() (and
                  (pair? alist)
                  (begin (set! entry (car alist))
                         (set! alist (cdr alist))
                         entry))))
        (do-add (lambda (notes arti)
                  (let* ((dur (ly:music-property (car notes) 'duration))
                         (new-notes (map            ; fix all durations to dur
                           (lambda(evt)(ly:music-set-property! evt 'duration dur)
                                       evt)
                           (car entry)))            ; the list of new notes
                         (new-arti (cdr entry)))    ; the articulations
                     (append new-notes notes new-arti arti)))))
    ;; combine in chords, each element of alist with notes of music  
   (map-some-music
     (lambda(x)
       (case (ly:music-property x 'name)
           ((NoteEvent)(if (entry?)
              (make-event-chord (do-add (list x) (note->chords-arti x)))
              x))
           ((EventChord)
              (if (entry?)(receive (notes arti) ; separates notes from scripts, dynamics etc
                (partition noteEvent? (ly:music-property x 'elements))
                (if (pair? notes)(ly:music-set-property! x 'elements (do-add notes arti)))))
              x)
           (else (and (ly:music-property x 'duration #f) x)))) ; #f means : go deeper
     (expand-q-chords music))))


addNote = #(define-music-function (parser location music notes)
                                                          (ly:music? ly:music?)

(add-note #{\relative c' $music  #}   ; the 2 music-parameters will
          #{\relative c' $notes  #})) % be seen in \relative mode
          

%%%%%%%%%%%%%%%%%%%% addVoice
addVoice = #(define-music-function (parser location music newVoice)
                                                          (ly:music? ly:music?)
;; #{
;;  <<
;;      { \voiceOne $music }
;;      \new Voice { \voiceTwo $newVoice }
;;  >>
;; \oneVoice
;;#})
#{
  <<
      $music  \\ $newVoice
  >>
#})

addVoiceReverse = #(define-music-function (parser location music newVoice)
                                                          (ly:music? ly:music?)
#{
  <<
      { \voiceOne $newVoice }
      \new Voice { \voiceTwo $music }
  >>
  \oneVoice
#})
                                                          
%%%%%%%%%%%%%%%%%%%%
deleteDynamics = #(define-music-function (parser location music) (ly:music?)
	(music-filter
		(lambda (evt)
			(not (memq (ly:music-property evt 'name) (list
							'AbsoluteDynamicEvent
							'CrescendoEvent
							'DecrescendoEvent))))
   		music))

%%%%%%%%%%%%%%%%%%%%
#(define (rest-score r)
  (let ((score 0)
	(yoff (ly:grob-property-data r 'Y-offset))
	(sp (ly:grob-property-data r 'staff-position)))
    (if (number? yoff)
	(set! score (+ score 2))
	(if (eq? yoff 'calculation-in-progress)
	    (set! score (- score 3))))
    (and (number? sp)
	 (<= 0 2 sp)
	 (set! score (+ score 2))
	 (set! score (- score (abs (- 1 sp)))))
    score))

#(define (merge-rests-on-positioning grob)
  (let* ((can-merge #f)
	 (elts (ly:grob-object grob 'elements))
	 (num-elts (and (ly:grob-array? elts)
			(ly:grob-array-length elts)))
	 (two-voice? (= num-elts 2)))
    (if two-voice?
	(let* ((v1-grob (ly:grob-array-ref elts 0))
	       (v2-grob (ly:grob-array-ref elts 1))
	       (v1-rest (ly:grob-object v1-grob 'rest))
	       (v2-rest (ly:grob-object v2-grob 'rest)))
	  (and
	   (ly:grob? v1-rest)
	   (ly:grob? v2-rest)
	   (let* ((v1-duration-log (ly:grob-property v1-rest 'duration-log))
		  (v2-duration-log (ly:grob-property v2-rest 'duration-log))
		  (v1-dot (ly:grob-object v1-rest 'dot))
		  (v2-dot (ly:grob-object v2-rest 'dot))
		  (v1-dot-count (and (ly:grob? v1-dot)
				     (ly:grob-property v1-dot 'dot-count -1)))
		  (v2-dot-count (and (ly:grob? v2-dot)
				     (ly:grob-property v2-dot 'dot-count -1))))
	     (set! can-merge
		   (and
		    (number? v1-duration-log)
		    (number? v2-duration-log)
		    (= v1-duration-log v2-duration-log)
		    (eq? v1-dot-count v2-dot-count)))
	     (if can-merge
		 ;; keep the rest that looks best:
		 (let* ((keep-v1? (>= (rest-score v1-rest)
				      (rest-score v2-rest)))
			(rest-to-keep (if keep-v1? v1-rest v2-rest))
			(dot-to-kill (if keep-v1? v2-dot v1-dot)))
		   ;; uncomment if you're curious of which rest was chosen:
		   ;;(ly:grob-set-property! v1-rest 'color green)
		   ;;(ly:grob-set-property! v2-rest 'color blue)
		   (ly:grob-suicide! (if keep-v1? v2-rest v1-rest))
		   (if (ly:grob? dot-to-kill)
		       (ly:grob-suicide! dot-to-kill))
		   (ly:grob-set-property! rest-to-keep 'direction 0)
		   (ly:rest::y-offset-callback rest-to-keep)))))))
    (if can-merge
	#t
	(ly:rest-collision::calc-positioning-done grob))))

%%%%%%%%%%%%%%%%%%%%%%%%
absolute = #(define-music-function (parser location music) (ly:music?)
"A \\relative command will have no effect in the resulting music."
(make-music 'UnrelativableMusic 'element music))

doubleNote = #(define-music-function (parser location music) (ly:music?)
"Double each note with the note an octave higher."
 #{
   \addNote \transpose c c' \relative { $music } $music
 #})


%%%%%%%%%%%%%%%%%%%%%%%%
doubleDur = #(define-music-function (parser location music)(ly:music?)
 (music-filter
	(lambda (evt)
		(let ((dur (ly:music-property evt 'duration)))
			(if (ly:duration? dur)
				(ly:music-set-property! evt 'duration
				  (ly:make-duration
					  (1- (ly:duration-log dur))
					  (ly:duration-dot-count dur))))
		  #t))
	music))

halfDur = #(define-music-function (parser location music)(ly:music?)
 (music-filter
	(lambda (evt)
		(let ((dur (ly:music-property evt 'duration)))
			(if (ly:duration? dur)
				(ly:music-set-property! evt 'duration
				  (ly:make-duration
					  (1+ (ly:duration-log dur))
					  (ly:duration-dot-count dur))))
		  #t))
	music))
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
music = \relative c''{
	<c e g>4-> <d f>( <b g' d'>) <c e g>-.
	<<
	  {e4 f g2 << {<a c>4 b c2} \new Voice { \voiceThree f,2 e} >> }
	\\
	{ c2 b4 d <<{d4 r c2}  \new Voice  {\voiceFour g4 r c,2}>>}
	>>
}

\score {
		\new Staff \music
		\header { piece = "Music with chords and voices"}
}
\score { <<
	  \new Staff	\extractNote #3 \extractVoice #1 \music   %% same result
	                                             %%  with \extractPartUpper \music
 	  \new Staff 	\extractNote #2 \extractVoice #1.2 \music
	  \new Staff	\extractNote #1 \extractVoice #2.1 \music
	  \new Staff	\extractNote #1 \extractVoice #4 \music     %% same result
	                                             %% with \extractPartLower\music
	>>
	\header { piece = "Music splited in 4 staffs"}
}

 musicA = {c'4.-> d8-. c4(\p b8) r c4\f c c2}
 musicB = {e f e d e s e}
 music = \addNote \musicA \musicB

 \new Voice \music

  music =  {
   g'2  g4 g
   a b c d
   c1
 }
 musicB = \addNote \addNote \music { e d e f g e f e}{ c b c f, e a g c}
 \score {<<
 \new Staff \musicB
 \new Staff \extractNote #3 \musicB
 \new Staff \extractNote #2 \musicB
 \new Staff {\clef bass \extractNote #1 \musicB}
>>
 }


mus = \relative { a4 c e f g a b c }
music = \doubleNote \mus
\new Staff \music
\new Staff \ePU \music
\new Staff \ePL \music


 %}

 
music = \relative c''{
	<c e g>4-> <d f>( <b g' d'>) <c e g>-.
	<<
	  {e4 f g2 << {<a c>4 b c2} \new Voice { \voiceThree f,2 e} >> }
	\\
	{ c2 b4 d <<{ d4 r c2 }  \new Voice  { \voiceFour g4 r c,2 }>>}
	>>
}

\score {
		\new Staff \music
		\header { piece = "Music with chords and voices"}
}
\score { <<
	  \new Staff	\extractNote #3 \extractVoice #1 \music   %% same result
	                                             %%  with \extractPartUpper \music
 	  \new Staff 	\extractNote #2 \extractVoice #1.2 \music
	  \new Staff	\extractNote #1 \extractVoice #2.1 \music
	  \new Staff	\extractNote #1 \extractVoice #4 \music     %% same result
	                                             %% with \extractPartLower\music
	>>
	\header { piece = "Music splited in 4 staffs"}
}

 musicA = {c'4.-> d8-. c4(\p b8) r c4\f c c2}
 musicB = {e f e d e s e}
 music = \addNote \musicA \musicB

 \new Voice \music

  music =  {
   g'2  g4 g
   a b c d
   c1
 }
 musicB = \addNote \addNote \music { e d e f g e f e}{ c b c f, e a g c}
 \score {<<
 \new Staff \musicB
 \new Staff \extractNote #3 \musicB
 \new Staff \extractNote #2 \musicB
 \new Staff {\clef bass \extractNote #1 \musicB}
>>
 }


mus = \relative { a4 c e f g a b c }
music = \doubleNote \mus
\new Staff \music
\new Staff \ePU \music
\new Staff \ePL \music
