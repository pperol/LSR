%% http://lsr.di.unimi.it/LSR/Item?id=644
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/midi

% For each lyric element that begins with '!', change it to begin with '\n'.
#(define (bang->slashn lst)
   (cond ((null? lst) 0)
         (else (if (equal? (ly:music-property (car lst) 'name) 'LyricEvent)
                   (let ((txt (ly:music-property (car lst) 'text)))
                     (if (equal? (string-ref txt 0) #\!)
                         ;; Prepend a newline instead of the exclamation
                         ;; mark - works for both MIDI Karaoke and page layout
                         (set! (ly:music-property (car lst) 'text)
                               (string-append
                                "\n"
                                (substring txt 1 (string-length txt)))))))
               (bang->slashn (ly:music-property (car lst) 'elements))
               (bang->slashn (cdr lst)))))
% Call the above recursive function
lyr =
#(define-music-function (parser location lyrics) (ly:music?)
   (bang->slashn (ly:music-property lyrics 'elements))
   lyrics)

\new Voice {
  c'4 d' e' c'
  e'4 c' e'
}
\addlyrics {
  \lyr {
    !Doe, a deer, a fe- male deer,
    !Ray, a drop of gol- den sun,
    !Me, a name I call my- self,
    !Far, a long long way to run!
  }
}
