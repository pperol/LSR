%% http://lsr.dsi.unimi.it/LSR/Item?id=608
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v-2-18-quot-Function-to-create-WYGIWYM-Chord-Names-quot-does-not-compile-tc159364.html

%LSR created by TaoCG

\markup\magnify #1.5 "This snippet needs v2.18 upgrade"

%{
#(define-macro when
   (lambda (test . branch)
     (list 'if test
       (cons 'begin branch))))
   
#(define (music-elts x)
   (ly:music-property x 'elements))

#(define (EventChord? x)
   (eq? (ly:music-property x 'name) 'EventChord))
   
#(define (NoteEvent? x)
   (eq? (ly:music-property x 'name) 'NoteEvent))
   
#(define (RestEvent? x)
   (eq? (ly:music-property x 'name) 'RestEvent))
   
#(define (SkipEvent? x)
   (eq? (ly:music-property x 'name) 'SkipEvent))
   
#(define (root-name x)
   (let ((n (ly:pitch-notename (ly:music-property x 'pitch))))
     (case n
       ((0) "C")
       ((1) "D")
       ((2) "E")
       ((3) "F")
       ((4) "G")
       ((5) "A")
       ((6) "B"))))

#(define (root-alter x)
   (let ((a (ly:pitch-alteration (ly:music-property x 'pitch))))
     (case a
       ((-1) "<")
       ((-1/2) "b")
       ((0) "")
       ((1/2) "#")
       ((1) ">"))))

#(define (bass-name x)
   (let ((n (ly:pitch-notename (ly:music-property x 'pitch))))
     (case n
       ((0) "e")
       ((1) "r")
       ((2) "t")
       ((3) "z")
       ((4) "u")
       ((5) "q")
       ((6) "w"))))

#(define (bass-alter x)
   (let ((a (ly:pitch-alteration (ly:music-property x 'pitch))))
     (case a
       ((-1) ";")
       ((-1/2) ",")
       ((0) "")
       ((1/2) "'")
       ((1) "\""))))

#(define (symbolize-chord music)
   (if (EventChord? music)
     (let* ((i (length (music-elts music)))
            (event (car (music-elts music)))
            (dur (ly:music-property event 'duration))
	    (root "")
	    (bass "")
	    (r-alt "")
	    (b-alt "")
	    (suffix "")
	    (paren-left "")
	    (paren-right ""))
       (when (NoteEvent? event)
         (set! root (root-name event))
	 (set! r-alt (root-alter event))
	 (if (eq? (ly:music-property event 'parenleft) #t)
	   (set! paren-left "["))
	 (if (eq? (ly:music-property event 'parenright) #t)
	   (set! paren-right "]"))
	 (if (= i 2)
	   (let ((event-two (cadr (music-elts music))))
	     (if (NoteEvent? event-two)
	       (when (NoteEvent? event-two)
	         (set! bass (string-append "_" (bass-name event-two)))
	         (set! b-alt (bass-alter event-two)))
	       (set! suffix (ly:music-property event-two 'text)))))
	 (if (= i 3)
	   (let ((event-two (cadr (music-elts music)))
	         (event-three (car (cddr (music-elts music)))))
	     (set! bass (string-append "_" (bass-name event-two)))
	     (set! b-alt (bass-alter event-two))
	     (set! suffix (ly:music-property event-three 'text)))))
       (when (RestEvent? event)
         (set! root "N.C.")
	 (if (eq? (ly:music-property event 'parenleft) #t)
	   (set! paren-left "["))
	 (if (eq? (ly:music-property event 'parenright) #t)
	   (set! paren-right "]")))
       (if (and (SkipEvent? event) (> i 1))
	 (set! suffix (ly:music-property (cadr (music-elts music)) 'text)))
       (set! music (make-music
                     'LyricEvent
		     'duration dur
		     'text
                     (string-append paren-left root r-alt suffix bass b-alt paren-right)))))
   music)

chordSymbols =
#(define-music-function (parser location music) (ly:music?)
   (music-map (lambda (x) (symbolize-chord x)) music))
   
parenLeft =
#(define-music-function (parser location music) (ly:music?)
   (ly:music-set-property! (car (ly:music-property music 'elements)) 'parenleft #t)
     music)
     
parenRight =
#(define-music-function (parser location music) (ly:music?)
   (ly:music-set-property! (car (ly:music-property music 'elements)) 'parenright #t)
     music)
     
parenBoth =
#(define-music-function (parser location music) (ly:music?)
   (ly:music-set-property! (car (ly:music-property music 'elements)) 'parenleft #t)
   (ly:music-set-property! (car (ly:music-property music 'elements)) 'parenright #t)
     music)
     
     
<<
\new Staff = "s" \new Voice = "v" { g'2 c' f'1 bes'2 es' a' d' }
\new Lyrics \with { alignAboveContext = "s" }
{
%\override LyricText.font-name = "JazzChords"
% next line is commented for 2.14.2
%        \set associatedVoice = "v"
        {
                \chordSymbols
                {
                        \transpose c f
                        {
                                \parenLeft 
                                d2-"m7"
                                <g b>-"13"
                                c1-"M" 
                                
                                s2
                                s-"|: A7 :|"
                                \parenRight 
                                r
                        }
                }
        }
}
>>
%}

