%% http://lsr.dsi.unimi.it/LSR/Item?id=311

%% LSR: Created on Sat Aug 17 2007 by ak
%% see : http://www.lilypond.org/doc/v2.18/Documentation/snippets/templates#templates-score-for-diatonic-accordion

verse = \lyricmode { Wie gross bist du! Wie gross bist du! }

harmonies = \new ChordNames \chordmode {
  \germanChords
  \set chordChanges = ##t
  bes8 bes8 bes8
  es2 f
  bes1
}

NoStem = { \hide Stem }
NoNoteHead = \hide NoteHead
ZeroBeam = \override Beam.positions = #'(0 . 0)

staffTabLine = \new Staff \with {
  \remove "Time_signature_engraver"
  \remove "Clef_engraver"
} {
  \override Staff.StaffSymbol.line-positions = #'(0)
  % Shows one horizontal line. The vertical line (simulating a bar-line) is simulated with a gridline
  \set Staff.midiInstrument = #"choir aahs"
  \key c \major
  \relative c''
  {
    % disable the following line to see the the noteheads while writing the song
    \NoNoteHead
    \override NoteHead.no-ledgers = ##t

    % The beam between 8th-notes is used to draw the push-line
    %How to fast write the push-lines:
    %  1. write repeatedly 'c c c c c c c c |' for the whole length of the song
    %  2. uncomment the line \NoNoteHead
    %  3. compile
    %  4. Mark the positions on which push/pull changes.
    %     In the score-picture click on the position the push- or pull-part starts
    %           (on the noteHead, the cursor will change to a hand-icon).
    %     The cursor in the source code will jump just at this position.
    %   a) If a push-part starts there, replace the 'c' by an 'e['
    %   b) If a pull-part starts there, replace the 'c' by an 's'
    %  5. Switch into 'overwrite-mode' by pressing the 'ins' key.
    %  6. For the pull-parts overwrite the 'c' with 's'
    %  7. For every push-part replace the last 'c' with 'e]'
    %        8. Switch into 'insert-mode' again
    %  9. At last it should look lik e.g. (s s e[ c | c c c c c c c c | c c c c c c e] s s)
    % 10. re-enable the line \NoNoteHead
    \autoBeamOff
    \ZeroBeam
    s8 s s e[ c c c c c c e] | s s s s s
  }
}

%{
%}

% Accordion melody in tabulator score
% 1. Place a copy of the piano melody below
% 2. Separate piano melody into pull- and push-parts according to the staffTabLine you've already made
% 3. For each line: Double the line. Remark the 1st one (Keeps unchanged as reference) and then change the second line using the transformation paper
%    or the macros 'conv2diaton push.bsh' and 'conv2diaton pull.bsh'
% Tips:
% - In jEdit Search & Replace mark the Option 'Keep Dialog'

AccordionTabTwoCBesDur = {
  % pull 1
  %<f' bes'>8 <f' a'>8 <d' bes'>8 |
  <g'' a''>8 <g'' b''>8 <e'' a''>8 |
  % push 2
  %<g' c''>4 <f' d''> <g' ees''> <f' a'> |
  <g'' a''>4 <d'' eisis''> <g'' bisis''> <d'' f''> |
  % pull 3
  % <f' bes'>2 r8 }
  <g'' a''>2 r8 }

AccordionTab= { \dynamicUp
  % 1. Place a copy of the piano melody above
  % 2. Separate piano melody into pull- and push-parts according to the staffTabLine you've already made
  % 3. For each line: Double the line. Remark the 1st one (Keeps unchanged as reference) and then
  %    change the second line using the transformation paper
  % Tips:
  % - In jEdit Search & Replace mark the Option 'Keep Dialog'
  % -
  \AccordionTabTwoCBesDur
}



\layout {
  \context {
    \Score
    % The vertical line (simulating a bar-line) in
    % the staffBassRhytm is a gridline
    \consists "Grid_line_span_engraver"
  }
  \context {
    \Staff
    \consists "Grid_point_engraver"
    gridInterval = #(ly:make-moment 4/4) % 4/4 - tact. How many beats per bar
    % The following line has to be adjusted O-F-T-E-N.
    \override GridPoint.Y-extent = #'(-2 . -21)
  }
  \context {
    \ChoirStaff
    \remove "System_start_delimiter_engraver"
  }
}

staffVoice = \new Staff = astaffvoice  {
  \time 4/4
  \set Staff.instrumentName = "Voice"
  \set Staff.midiInstrument = "voice oohs"
  \key bes \major
  \partial 8*3
  \clef treble
  {
    \context Voice = "melodyVoi"
    { <f' bes'>8 <f' a'>8 <d' bes'>8 | <g' c''>4 <f' d''> <g' es''> <f' a'> | <f' bes'>2 r8 }
    \bar "|."
  }
}

staffAccordionMel =
\new Staff  \with { \remove "Clef_engraver" } {
  \accidentalStyle forget %Set the accidentals (Vorzeichen) for each note,
  %do not remember them for the rest of the measure.
  \time 4/4
  \set Staff.instrumentName="Accordion"
  \set Staff.midiInstrument="voice oohs"
  \key c \major
  \clef treble
  { \AccordionTab \bar "|." }
}

AltOn =
#(define-music-function (parser location mag) (number?)
  #{ \override Stem.length = #(* 7.0 mag)
      \override NoteHead.font-size =
#(inexact->exact (* (/ 6.0 (log 2.0)) (log mag))) #})

AltOff = {
  \revert Stem.length
  \revert NoteHead.font-size
}

BassRhytm = {s4 s8 | c2 c2 | c2 s8 }
LyricBassRhythmI=  \lyricmode { c b | c }

staffBassRhytm =
\new Staff = staffbass \with { \remove "Clef_engraver" } {
  % This is not a RhythmicStaff  because it must be possible to append lyrics.

  \override Score.GridLine.extra-offset = #'( 13.0 . 0.0 ) % x.y
  \override Staff.StaffSymbol.line-positions = #'( 0 )
  % Shows one horizontal line. The vertical line (simulating a bar-line) is simulated by a grid
  % Search for 'grid' in this page to find all related functions
  \time 4/4
  {
    \context Voice = "VoiceBassRhytm"
    \stemDown \AltOn #0.6
    \relative c''
    {
      \BassRhytm
    }
    \AltOff
    \bar "|."
  }
}

\score {
  \new ChoirStaff <<
    \harmonies
    \staffVoice
    \context Lyrics = "lmelodyVoi"
      \with { alignBelowContext = astaffvoice }
      \lyricsto melodyVoi \verse
    \staffAccordionMel
    \staffTabLine
    \staffBassRhytm
    \context Lyrics = "lBassRhytmAboveI"
      \with { alignAboveContext = staffbass }
      \lyricsto VoiceBassRhytm \LyricBassRhythmI
  >>
}


% LSR: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR: %                            APPENDIX                          %
% LSR: %     macro 'macro_conv2diaton_push.bsh' for jedit editor      %
% LSR: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR:
% LSR: { 
% LSR: // original saved in 'Handorg_Adria_Diaton_III.xls'
% LSR: // Save this buffer, to the other recorded macros in the jedit editor
% LSR: // and the macro should appear in the
% LSR: // Macros menu.

% LSR: // /ak 17.8.07 This macro from converts lilypond piano notation into 
% LSR: // lilypond tabulator notation for the push-part (at the bottom the pull-part) of a diatonic accordion
% LSR: // It replaces the piano notes of the line where the cursor is by the accordion notation
% LSR:
% LSR: // Known issues: 1) A note at the end of line is not replaced
% LSR:
% LSR: textArea.goToEndOfWhiteSpace(false);
% LSR: textArea.goToStartOfWhiteSpace(true);
% LSR:
% LSR: String firstName, lastName; 

% LSR: int ReplaceTextInSelection(String sfind, String sreplace)
% LSR: {
% LSR: //MsgConcat = new StringBuffer(512);
% LSR: //MsgConcat.append("Ha");
% LSR:
% LSR: //Macros.message(view, "On that line replace \"" + sfind + "\" by \"" + sreplace+ "\"");
% LSR: SearchAndReplace.setSearchString(sfind.toString());
% LSR: SearchAndReplace.setReplaceString(sreplace.toString());
% LSR: SearchAndReplace.setBeanShellReplace(false);
% LSR: SearchAndReplace.setIgnoreCase(true);
% LSR: SearchAndReplace.replace(view);
% LSR: SearchAndReplace.setRegexp(true);
% LSR: return 1;
% LSR: }
% LSR:
% LSR:
% LSR: String % LSR: smainfind;
% LSR: String smainrepl;
% LSR:
% LSR:
% LSR: // Push-part tmp
% LSR: smainfind="(\\s|^|<|\\{)(c,)([^\'^is^es])"; smainrepl="$1tmpd\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(cis,)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(des,)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(d,)([^\'^is^es])"; smainrepl="$1tmpbisis-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(dis,)([^\'^is^es])"; smainrepl="$1tmpdisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ees,)([^\'^is^es])"; smainrepl="$1tmpdisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(e,)([^\'^is^es])"; smainrepl="$1tmpg$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(f,)([^\'^is^es])"; smainrepl="$1tmpf$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(fis,)([^\'^is^es])"; smainrepl="$1tmpe$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ges,)([^\'^is^es])"; smainrepl="$1tmpe$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(g,)([^\'^is^es])"; smainrepl="$1tmpb$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(gis,)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(aes,)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(a,)([^\'^is^es])"; smainrepl="$1tmpa$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ais,)([^\'^is^es])"; smainrepl="$1tmpfisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(bes,)([^\'^is^es])"; smainrepl="$1tmpfisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(b,)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(c)([^\'^is^es])"; smainrepl="$1tmpd\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(cis)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(des)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(d)([^\'^is^es])"; smainrepl="$1tmpbisis$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(dis)([^\'^is^es])"; smainrepl="$1tmpdisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ees)([^\'^is^es])"; smainrepl="$1tmpdisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(e)([^\'^is^es])"; smainrepl="$1tmpf\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(f)([^\'^is^es])"; smainrepl="$1tmpe\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(fis)([^\'^is^es])"; smainrepl="$1tmpaisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ges)([^\'^is^es])"; smainrepl="$1tmpaisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(g)([^\'^is^es])"; smainrepl="$1tmpa\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(gis)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(aes)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(a)([^\'^is^es])"; smainrepl="$1tmpg\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ais)([^\'^is^es])"; smainrepl="$1tmpfisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(bes)([^\'^is^es])"; smainrepl="$1tmpfisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(b)([^\'^is^es])"; smainrepl="$1tmpr$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(c\')([^\'^is^es])"; smainrepl="$1tmpb\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(cis\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(des\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(d\')([^\'^is^es])"; smainrepl="$1tmpeisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(dis\')([^\'^is^es])"; smainrepl="$1tmpcisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ees\')([^\'^is^es])"; smainrepl="$1tmpcisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(e\')([^\'^is^es])"; smainrepl="$1tmpe\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(f\')([^\'^is^es])"; smainrepl="$1tmpd\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(fis\')([^\'^is^es])"; smainrepl="$1tmpgisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ges\')([^\'^is^es])"; smainrepl="$1tmpgisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(g\')([^\'^is^es])"; smainrepl="$1tmpg\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(gis\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(as\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(a\')([^\'^is^es])"; smainrepl="$1tmpf\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ais\')([^\'^is^es])"; smainrepl="$1tmpfisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(bes\')([^\'^is^es])"; smainrepl="$1tmpfisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(b\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(c\'\')([^\'^is^es])"; smainrepl="$1tmpa\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(cis\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(des\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(d\'\')([^\'^is^es])"; smainrepl="$1tmpeisis\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(dis\'\')([^\'^is^es])"; smainrepl="$1tmpbisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ees\'\')([^\'^is^es])"; smainrepl="$1tmpbisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(e\'\')([^\'^is^es])"; smainrepl="$1tmpd\'\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(f\'\')([^\'^is^es])"; smainrepl="$1tmpc\'\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(fis\'\')([^\'^is^es])"; smainrepl="$1tmpgisis\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ges\'\')([^\'^is^es])"; smainrepl="$1tmpgisis\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(g\'\')([^\'^is^es])"; smainrepl="$1tmpf\'\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(gis\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(aes\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(a\'\')([^\'^is^es])"; smainrepl="$1tmpe\'\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ais\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(bes\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(b\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );

% LSR: smainfind="(\\s|^|<|\\{)(tmp)()"; smainrepl="$1$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: */
% LSR:
% LSR: /*
% LSR: // Pull-part tmp
% LSR: smainfind="(\\s|^|<|\\{)(c,)([^\'^is^es])"; smainrepl="$1tmpa-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(cis,)([^\'^is^es])"; smainrepl="$1tmpdisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(des,)([^\'^is^es])"; smainrepl="$1tmpdisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(d,)([^\'^is^es])"; smainrepl="$1tmpd\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(dis,)([^\'^is^es])"; smainrepl="$1tmpbisis-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ees,)([^\'^is^es])"; smainrepl="$1tmpbisis-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(e,)([^\'^is^es])"; smainrepl="$1tmpc\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(f,)([^\'^is^es])"; smainrepl="$1tmpf\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(fis,)([^\'^is^es])"; smainrepl="$1tmpfisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ges,)([^\'^is^es])"; smainrepl="$1tmpfisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(g,)([^\'^is^es])"; smainrepl="$1tmpg$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(gis,)([^\'^is^es])"; smainrepl="$1tmpe$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(aes,)([^\'^is^es])"; smainrepl="$1tmpe$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(a,)([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ais,)([^\'^is^es])"; smainrepl="$1tmpf$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(bes,)([^\'^is^es])"; smainrepl="$1tmpf$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(b,)([^\'^is^es])"; smainrepl="$1tmpb$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(c)([^\'^is^es])"; smainrepl="$1tmpa$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(cis)([^\'^is^es])"; smainrepl="$1tmpdisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(des)([^\'^is^es])"; smainrepl="$1tmpdisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(d)([^\'^is^es])"; smainrepl="$1tmpd\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(dis)([^\'^is^es])"; smainrepl="$1tmpbisis$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ees)([^\'^is^es])"; smainrepl="$1tmpbisis$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(e)([^\'^is^es])"; smainrepl="$1tmpc\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(f)([^\'^is^es])"; smainrepl="$1tmpf\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(fis)([^\'^is^es])"; smainrepl="$1tmpfisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ges)([^\'^is^es])"; smainrepl="$1tmpfisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(g)([^\'^is^es])"; smainrepl="$1tmpe\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(gis)([^\'^is^es])"; smainrepl="$1tmpaisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(aes)([^\'^is^es])"; smainrepl="$1tmpaisis\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(a)([^\'^is^es])"; smainrepl="$1tmpa\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ais)([^\'^is^es])"; smainrepl="$1tmpg\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(bes)([^\'^is^es])"; smainrepl="$1tmpg\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(b)([^\'^is^es])"; smainrepl="$1tmpc\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(c\')([^\'^is^es])"; smainrepl="$1tmpb\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(cis\')([^\'^is^es])"; smainrepl="$1tmpcisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(des\')([^\'^is^es])"; smainrepl="$1tmpcisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(d\')([^\'^is^es])"; smainrepl="$1tmpe\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(dis\')([^\'^is^es])"; smainrepl="$1tmpeisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ees\')([^\'^is^es])"; smainrepl="$1tmpeisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(e\')([^\'^is^es])"; smainrepl="$1tmpd\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(f\')([^\'^is^es])"; smainrepl="$1tmpg\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(fis\')([^\'^is^es])"; smainrepl="$1tmpfisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ges\')([^\'^is^es])"; smainrepl="$1tmpfisis\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(g\')([^\'^is^es])"; smainrepl="$1tmpf\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(gis\')([^\'^is^es])"; smainrepl="$1tmpgisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(aes\')([^\'^is^es])"; smainrepl="$1tmpgisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(a\')([^\'^is^es])"; smainrepl="$1tmpb\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ais\')([^\'^is^es])"; smainrepl="$1tmpa\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(bes\')([^\'^is^es])"; smainrepl="$1tmpa\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(b\')([^\'^is^es])"; smainrepl="$1tmpd\'\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(c\'\')([^\'^is^es])"; smainrepl="$1tmpf\'\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(cis\'\')([^\'^is^es])"; smainrepl="$1tmpbisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(des\'\')([^\'^is^es])"; smainrepl="$1tmpbisis\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(d\'\')([^\'^is^es])"; smainrepl="$1tmpc\'\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(dis\'\')([^\'^is^es])"; smainrepl="$1tmpeisis\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ees\'\')([^\'^is^es])"; smainrepl="$1tmpeisis\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(e\'\')([^\'^is^es])"; smainrepl="$1tmpe\'\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(f\'\')([^\'^is^es])"; smainrepl="$1tmpg\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(fis\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ges\'\')([^\'^is^es])"; smainrepl="$1tmpr-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(g\'\')([^\'^is^es])"; smainrepl="$1tmpf\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(gis\'\')([^\'^is^es])"; smainrepl="$1tmpgisis\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(aes\'\')([^\'^is^es])"; smainrepl="$1tmpgisis\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(a\'\')([^\'^is^es])"; smainrepl="$1tmpb\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(ais\'\')([^\'^is^es])"; smainrepl="$1tmpa\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(bes\'\')([^\'^is^es])"; smainrepl="$1tmpa\'\'$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(b\'\')([^\'^is^es])"; smainrepl="$1tmpd\'\'\'-.$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: smainfind="(\\s|^|<|\\{)(tmp)()"; smainrepl="$1$3"; ReplaceTextInSelection( % LSR: smainfind, smainrepl );
% LSR: */
%}



