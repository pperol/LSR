%% http://lsr.di.unimi.it/LSR/Item?id=195
%% see also http://lsr.di.unimi.it/LSR/Item?id=454
%% see also http://lsr.di.unimi.it/LSR/Item?id=170
%% see also http://lsr.di.unimi.it/LSR/Item?id=403
%% see also http://lsr.di.unimi.it/LSR/Item?id=640
%% see also http://lsr.di.unimi.it/LSR/Item?id=213
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves#breath-marks

\relative c'' {
\time 3/4
e4 d e
					% default
e_\markup { "default - breathe" }
	\breathe d e |
					% rcomma
	% by default, \breathe uses the rcomma, just as if saying:
	 	\override BreathingSign.text =
		#(make-musicglyph-markup "scripts.rcomma")
e_\markup rcomma \breathe d e |
					% lcomma
	 	\override BreathingSign.text =
		#(make-musicglyph-markup "scripts.lcomma")
e_\markup lcomma \breathe d e |
					% rvarcomma
		\override BreathingSign.text =
		#(make-musicglyph-markup "scripts.rvarcomma")
e_\markup rvarcomma \breathe d e | \break
					% lvarcomma
		\override BreathingSign.text =
		#(make-musicglyph-markup "scripts.lvarcomma")
e_\markup lvarcomma \breathe d e |
					% upbow or wedge
		\override BreathingSign.text =
		 #(make-musicglyph-markup "scripts.upbow")
e_\markup upbow \breathe d e |
					% caesura
		\override BreathingSign.text =
		 #(make-musicglyph-markup "scripts.caesura.curved")
e_\markup caesura \breathe d e |
					% fetura, tramlines, or railroad tracks
<<{
\hideNotes a16 a a a a4 a \unHideNotes
}\\{
	\once\override TextScript.extra-offset = #'(4.0 . -2.7)
e^\markup {\fontsize #2 {\bold "/" \hspace #-1.4 \bold "/"}}
d_\markup { \hspace #-10 "fetura" } e |
}>>
	\once\override TextScript.font-name = #"cmb10"
	\once\override TextScript.extra-offset = #'(4.0 . -2.2)
e^\markup {\magnify #1.3 { "/" \hspace #-1.5 "/"}}
d_\markup { \hspace #-10 "fetura" } e |

e d e \bar "||"
						}%end relative
					\layout{
indent = 0.00\in
					}%end layout