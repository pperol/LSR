%% http://lsr.di.unimi.it/LSR/Item?id=869

%by: ArnoldTheresius

%tested: \version "2.22.0"


% lilypond 2.14.x:
% Allmost copied from .../scm/translation-functions.scm:
% --> added »-approx« to the function names of
%     »format-metronome-markup« and »metronome-markup«
% --> replaced "=" with "≈" (approx. instead of equal)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START of my personal include file 'tempo-approx.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define-public (format-metronome-markup-approx event context)
  (let ((eq-sym-def (ly:context-property context 'tempoEquationText))             ; added option
        (hide-paren (eq? #t (ly:context-property context 'tempoHideParenthesis))) ; added option
        (num-color (ly:context-property context 'tempoNumberColor #f))            ; added option
        (hide-note (ly:context-property context 'tempoHideNote #f))
	(text (ly:event-property event 'text))
	(dur (ly:event-property event 'tempo-unit))
	(count (ly:event-property event 'metronome-count)))
    (metronome-markup-approx text dur count hide-note eq-sym-def hide-paren num-color)))

#(define-public (metronome-markup-approx text dur count hide-note eq-sym-def hide-paren col)
  (let* ((note-mark (if (and (not hide-note) (ly:duration? dur))
			(make-smaller-markup
			 (make-note-by-number-markup (ly:duration-log dur)
						     (ly:duration-dot-count dur)
						     1))
			#f))
	 (count-markup (cond ((number? count)
			      (if (> count 0)
				  (make-simple-markup (number->string count))
				  #f))
			     ((pair? count)
			      (make-concat-markup
			       (list
				(make-simple-markup (number->string (car count)))
				(make-simple-markup (ly:wide-char->utf-8 #x2009))
				(make-simple-markup (ly:wide-char->utf-8 #x2013))
				(make-simple-markup (ly:wide-char->utf-8 #x2009))
				(make-simple-markup (number->string (cdr count))))))
			     (else #f)))
         (note-markup (if (and (not hide-note) count-markup)
			  (make-concat-markup
			   (list
			    (make-general-align-markup Y DOWN note-mark)
			    (make-simple-markup " ")
			    (make-simple-markup (if (string? eq-sym-def)
                                                 eq-sym-def
                                                 (ly:wide-char->utf-8 #x2248)))
			    (make-simple-markup " ")
			    (if (eq? col #f)
                             count-markup
                             (make-with-color-markup col count-markup))))
			  #f))
         (text-markup (if (not (null? text))
			  (make-bold-markup text)
			  #f)))
    (if text-markup
	(if (and note-markup (not hide-note))
	    (make-line-markup (list text-markup
                                   (if hide-paren
                                    note-markup
				    (make-concat-markup
				     (list (make-simple-markup "(")
					   note-markup
					   (make-simple-markup ")"))))))
	    (make-line-markup (list text-markup)))
	(if note-markup
	    (make-line-markup (list note-markup))
	    (make-null-markup)))))



% Make this new formatter the default:
\layout {
  \context {
    \Score
    metronomeMarkFormatter = #format-metronome-markup-approx
  }
}

#(define (define-translator-property symbol type? description)
  (if (not (and (symbol? symbol)
	(procedure? type?)
	(string? description)))
      (ly:error "error in call of define-translator-property"))
  (if (not (equal? (object-property symbol 'translation-doc) #f))
      (ly:error (_ "symbol ~S redefined") symbol))

  (set-object-property! symbol 'translation-type? type?)
  (set-object-property! symbol 'translation-doc description)
  symbol)

#(for-each
  (lambda (x)
    (apply define-translator-property x))
    `((tempoHideParenthesis
       ,boolean?
       "Hide the parenthesis around the metronome markup with text")
      (tempoEquationText
       ,string?
       "initially ''='' in the metronome markup, but here the default is altered to ''≈''")
      (tempoNumberColor
       ,list?
       "alternate color, in which the tempo value should be displayed")))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END of my personal include file 'tempo-approx.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\paper { system-system-spacing.basic-distance = #18 }

\markup { \null \translate #'( 1 . -3 ) \null } % 2.14.2 LSR problem workaroud

\score {
  \new Staff {
    \tempo 4 = 80
    c'1^" "_"»originaly after included this code sample«"
    \tempo "Allegro di Largo" 4 = 84
    c' \break

    \once \set Score.tempoHideParenthesis = ##t
    \tempo "Allegro di Larghetto" 4 = 88
    c'^" "_"\\once \\set Score.tempoHideParenthesis = ##t"
    \break

    \set Score.tempoEquationText = "= ca."
    \tempo "Allegro lento" 4 = 96
    c'^" "_"\\set Score.tempoEquationText = \"= ca.\""
    \break

    \unset Score.tempoEquationText
    \once \set Score.tempoNumberColor = #red
    \tempo 4 = 108
    c'^" "_"\\unset Score.tempoEquationText   \\set Score.tempoNumberColor = #red"
    \break

    \set Score.tempoNumberColor = #blue
    \set Score.tempoEquationText = "="
    \tempo "Allegro monumentale" 4 = 80-88
    c'^" "_"\\set Score.tempoNumberColor = #blue   \\set Score.tempoEquationText = \"=\""
    \break

    \set Score.metronomeMarkFormatter = #format-metronome-markup
    \override TextScript.outside-staff-priority = #1000
    \tempo "Tempo I" 4 = 80
    c'^" "_\markup \column {
      "\\set Score.metronomeMarkFormatter = #format-metronome-markup"
      "(which is LILYPOND's default Metronome Mark Formatter)"
    }

    \bar "|."
  }
  \header {
    piece = \markup \column {
      "»Score.metronomeMarkFormatter = #format-metronome-markup-approx«"
      "is assigned by a layout definition in this example"
      \null
    }
  }
}
