%% http://lsr.dsi.unimi.it/LSR/Item?id=193
%% see also : http://www.lilypond.org/doc/v2.18/Documentation/internals/glissando
%% see also : http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#glissando
%% see also : http://www.lilypond.org/doc/v2.17/Documentation/snippets/expressive-marks

\relative c' {
	\clef treble
	\key c \major
	\time 3/8

	fis16.[-> a64 g]

	% Make tuplet markings invisible
	\once \override TupletNumber.stencil = ##f
	\once \override TupletBracket.bracket-visibility = ##f

	% Prepare for small notes
	\override NoteHead.font-size = #-4
	\override Accidental.font-size = #-4

	% Force stem direction down
	\stemDown

	% Tuplet with small notes
	\tuplet 42/3 { fis8[( g gis a bes b c cis d dis e f fis g gis a bes! b c cis d] }

	% Restore normal note size
	\revert NoteHead.font-size
	\revert Accidental.font-size

	es32.[) fis,,64]
}
