%% http://lsr.di.unimi.it/LSR/Item?id=101
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-chords#customizing-chord-names

scm = \chordmode {
  c1/c | cis/cis
  b1/b | bis/bis | bes/bes
} 


\layout {
    ragged-right = ##t 
    \context {\ChordNames \consists "Instrument_name_engraver" }
}

<<
    \new ChordNames {
	\set instrumentName = #"default"
	\scm
    }
    \new ChordNames {
	\set instrumentName = #"german"
	\germanChords \scm }
    \new ChordNames {
	\set instrumentName = #"semi-german"
	\semiGermanChords \scm }
    \new ChordNames {
	\set instrumentName = #"italian"
	\italianChords \scm }
    \new ChordNames {
	\set instrumentName = #"french"
	\frenchChords \scm }

    \context Voice { \scm }
>>