%% http://lsr.di.unimi.it/LSR/Item?id=745
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/different-editions-from-one-source#using-tags

%% Contributed by Michael Ellis

#(define empty? null?) 

%% Top level variable that holds the current 
%% outline level as music expressions are parsed.
#(define outline-level 0)
%% Procedures to increment and decrement the outline level
#(define (inc-outline-level!) (set! outline-level (+ 1 outline-level)))
#(define (dec-outline-level!) (set! outline-level (- 1 outline-level)))

%% Factory for input-tag closures that attach to Note Events.
%% and provide storage for outline level and output color.  These are set at
%% different phases of processing.  Outline level is set as the
%% music is defined, but output-color is set just before it is
%% ready to render into the score.
#(define (make-input-tag outline-level) 
    (let ((ol outline-level) 
          (outc (x11-color 'black))) 
        (lambda args
             (case (car args)
               ((get-outline-level) ol)
               ((get-output-color) outc)
               ((set-outline-level!) (set! ol (car (cdr args))))
               ((set-output-color!) (set! outc (car (cdr args))))
               (else (error "make-input-tag: Invalid method!"))))))

%% Function that replaces an input-tag with a copy and
%% returns the copy. We need this because ly:music-deep-copy doesn't
%% copy the 'input-tag property. (grrr!)
#(define (replace-input-tag music tag)
    (define newtag '())
    (set! newtag (make-input-tag 0))
    (newtag 'set-outline-level! (tag 'get-outline-level))
    (newtag 'set-output-color! (tag 'get-output-color))
    (ly:music-set-property! music 'input-tag newtag)
    newtag)

%% Function that installs and updates input-tag closures on
%% pitch elements.
#(define (setOutlineLevel! music level)
   (let ((es (ly:music-property music 'elements))
         (e (ly:music-property music 'element))
         (p (ly:music-property music 'pitch))
         (target '()))
     (cond
        ((ly:pitch? p) 
             (let ((tag (ly:music-property music 'input-tag)))
                 (if (empty? tag) 
                    (ly:music-set-property! music 'input-tag 
                        (make-input-tag level))
                    (tag 'set-outline-level! (+ 1 level)))))

         ((ly:music? e) `(set! target (list e)))
         ((pair? es)     (set! target es))
         (else (set! target '())))

     (map (lambda (x) (setOutlineLevel! x level)) target)))


%% Music function wrapper for setOutlineLevel. 
%% Usage:  \oLevel {a b c \oLevel { d e f } } ...
%% Nested calls result in deeper outlining.
oLevel = 
#(define-music-function (p l m) (ly:music?)
    (inc-outline-level!)
    (setOutlineLevel! m outline-level)
    (dec-outline-level!)
    m)

%% top level variable to hold last non-suppressed pitch value.
#(define lastp (ly:make-pitch 1 1 0))    
#(define (setlastp! p) (set! lastp p))
#(define (getlastp) lastp)

%% Function to enforce outlining on music. Any note whose outline
%% level is greater than the level specified has its pitch set to the
%% previous note and its color set to grey.
#(define (outline! music level)
   (let ((es (ly:music-property music 'elements))
         (e (ly:music-property music 'element))
         (p (ly:music-property music 'pitch))
         (tag (ly:music-property music 'input-tag))
         (newtag '())
         (target '())
         (lastp lastp))
     (cond 
        ((ly:pitch? p)
            (cond 
               ((empty? tag)   
                    (ly:music-set-property! music 'input-tag 
                        (make-input-tag level))
                    (setlastp! p))

               ((> (tag 'get-outline-level) level)
                    (set! newtag (replace-input-tag music tag))
                    (ly:music-set-property! music 'pitch (getlastp))
                    (newtag 'set-output-color! (x11-color 'grey)))

               (else 
                    (set! newtag (replace-input-tag music tag))
                    (newtag 'set-output-color! (x11-color 'black))
                    (setlastp! p))))

        ((ly:music? e)
            (outline! e level))
        ((pair? es)     
            (map (lambda (x) (outline! x level)) es)))))            

          

%% Music function wrapper for outline procedure.
outlineMusic =
#(define-music-function (parser location level m) (number? ly:music?)
   (let ((newmusic (ly:music-deep-copy m)))
      (display "outlineMusic") (newline)
      (outline! newmusic level)
      newmusic))
  

%% Function used by engraver to fetch notehead color from tag
#(define (color-notehead grob)
    (define (tag-to-color tag) (tag 'get-output-color))
    (tag-to-color (ly:event-property 
                    (ly:grob-property grob 'cause) 'input-tag)))


%% --------------------------------------------
%% Music
%% --------------------------------------------
#(set-global-staff-size 18)

melody = \relative g'' {
    \clef treble
    \key d \minor
    \time 4/4
    \tempo "" 4 = 20
    \set Staff.instrumentName = #"Violin"
    \set Staff.midiInstrument = #"violin"
    \drums { 
        %% 1 beat count-in on wood blocks
        \set Timing.measureLength = #(ly:make-moment 1/4)
        \set Staff.instrumentName = #"Click" wbh16 wbl wbl wbl 
        \unset Timing.measureLength
        } |
    << 
    {
    %{ Main Voice %}
    \override NoteHead.color = #color-notehead
    %{ 1 %} 
    <bes, g'>4 ~ 
    g'32[ \oLevel { f( ees d c \oLevel {bes a bes64 g)] }} 
    g8[ fis] ~ 
    fis32[ \oLevel { e( d e \oLevel { fis g a c64 bes)] }}

    %{ 2 %}  
    c8[ ~  \oLevel { c32 \oLevel { d64( c bes32 c]}} 
    c16.\trill[ \oLevel { bes64 c \oLevel { d16 a)]}} 
    g'8 r32   \oLevel { g,32([ \oLevel { a64 bes c d] }} 
    ees8)[ bes]
    }

    \\  { 
    %{ Voice 2 %}
    %{ 1 %}  <g, d'>8  s8 s4 a  s4
    %{ 2 %}  d8 s8 s4 g,8 s8 r8 g'8
    }
     \\  
    { %{ Voice 3 %}
    %{ 1 %}  s4 s4 c4 s4
    %{ 2 %}  fis4 s4 <d, bes'>8 s4.
    }
     >>
    \bar "|."
}

%% -----------------------------------------
%% Output
%% 3 levels of outlining + midi
%% -----------------------------------------
\book {
    %% Maximum outlining
    \markup {  \column { "BWV 1001 Excerpt"
                         "Outline Level 0" } } 
    \score {
        \new Staff {
            \outlineMusic #0 \melody         
         }
         \layout {}
    }
    % Medium outlining
    \markup {  \column { "BWV 1001 Excerpt"
                         "Outline Level 2" } } 
    \score {
        \new Staff {
            \outlineMusic #1 \melody         
         }
         \layout {}
    } 
    %% No outlining 
    \markup {  \column { "BWV 1001 Excerpt"
                         "No Outlining" } } 
    \score {
        \new Staff {
            \outlineMusic #2 \melody         
         }
         \layout {}
    }             
    %% Consecutive midi for all 3 scores
    \score {
        \new Staff {
            \outlineMusic #0 \melody         
            \outlineMusic #1 \melody         
            \outlineMusic #2 \melody
        }
        \midi {}
    }

}                            


