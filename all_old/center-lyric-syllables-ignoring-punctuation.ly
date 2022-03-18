%% http://lsr.di.unimi.it/LSR/Item?id=888
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/techniques-specific-to-lyrics

%LSR by Wolf Alight
%=>http://lists.gnu.org/archive/html/lilypond-user/2010-02/msg00444.html
%=>http://lists.gnu.org/archive/html/lilypond-user/2013-05/msg00800.html

%LSR modified by Alexander Kobel
%=>http://permalink.gmane.org/gmane.comp.gnu.lilypond.general/89675

%% Note: Only characters of the string used to define space-set
%% are recognized by 'center-on-word'
#(define space-set
  (list->char-set (string->list ".?-;,:â€œâ€â€˜â€™â€“â€” */()[]{}|<>!`~&â€¦")))

#(define (width grob text-string)
  (let* ((layout (ly:grob-layout grob))
         (props
          (ly:grob-alist-chain
           grob
           (ly:output-def-lookup layout 'text-font-defaults)))
         (X-extent (ly:stencil-extent
                    (ly:text-interface::interpret-markup layout props
                     (markup text-string)) X)))
   (if (interval-empty? X-extent)
    0 (cdr X-extent))))

#(define (center-on-word grob)
  (let* ((text (ly:grob-property-data grob 'text))
         (syllable (if (string? text) text ""))
         (word-position
          (if (integer? (string-skip syllable space-set))
           (string-skip syllable space-set)
           0))
         (word-end
          (if (integer? (string-skip-right syllable space-set))
           (+ (string-skip-right syllable space-set) 1)
           (string-length syllable)))
         (preword (substring syllable 0 word-position))
         (word (substring syllable word-position word-end))
         (preword-width (if (string? text) (width grob preword) 0))
         (word-width (if (string? text) (width grob word) (width grob text)))
         (notehead (ly:grob-parent grob X))
         (refp (ly:grob-common-refpoint notehead grob X))
         (note-extent (ly:grob-extent notehead refp X))
         (note-width (- (cdr note-extent) (car note-extent))))

   (if (= -1 (ly:grob-property-data grob 'self-alignment-X))
    (- 0 preword-width)
    (- (/ (- note-width word-width) 2) preword-width))))

\layout {
  \context {
    \Lyrics
    \override LyricText #'X-offset = #center-on-word
  }
}

melody = \relative c' { c4 d e f | g1 \bar"|." }
lyr = \lyricmode {
  Do, Re, Mi, Fa, Sol—
}

lyrA = \lyricmode {
  \repeat unfold 16 { “Do, Re, Mi, Fa... Sol!” }
}

\score {
  \new Staff <<
    \new Voice = "voice" {
      \melody
    }
    \new Lyrics = testI\lyricsto "voice" \lyr
    \new Lyrics = test \lyricsto "voice" \lyrA
  >>
  \layout {
    \context {
      \Lyrics
      \override LyricText.X-offset = #center-on-word
    }
  }
}
