%% http://lsr.di.unimi.it/LSR/Item?id=682
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/keyboards#keyboards-changing-the-text-for-sustain-markings

sustainNotes = { c4\sustainOn d e\sustainOff\sustainOn f\sustainOff }

\relative c' {
  \sustainNotes 
  \set Staff.pedalSustainStrings = #'("P" "P-" "-")
  \sustainNotes 
  \set Staff.pedalSustainStrings = #'("d" "de" "e")
  \sustainNotes 
  \set Staff.pedalSustainStrings = #'("M" "M-" "-")
  \sustainNotes 
  \set Staff.pedalSustainStrings = #'("Ped" "*Ped" "*")
  \sustainNotes 
}
