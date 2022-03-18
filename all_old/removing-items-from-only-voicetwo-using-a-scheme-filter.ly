%% http://lsr.dsi.unimi.it/LSR/Item?id=372

\header {
  title = "Removing markup, dynamics etc. from voiceTwo"
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Description of the problem and its solution: (compiles only in Lilypond >= 2.11.x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
#(define-markup-list-command (paragraph layout props args) (markup-list?)
   (let ((indent (chain-assoc-get 'par-indent props 2)))
     (interpret-markup-list layout props
       (make-justified-lines-markup-list (cons (make-hspace-markup indent)
                                               args)))))

\markuplist {
  \paragraph{ 
    Sometimes you have two voices combined on one staff, but you 
    also want to generate a version for each voice separately. Thus, each voice
    has all dynamics, articulations, ornaments and markup text assigned. However,
    when combining them as two voices on the same staff, each voice will print 
    its dynamics, articulations, etc. resulting in them printed twice.
  }
  \paragraph {
    To remove these markups from the second voice, you have two choices:
  }
  \paragraph {
    1) Remove the corresponding engravers, which created the dynamics, markups, etc.
  }
  \paragraph {
    2) Filter out the Events from the music that describe these dynamics, markups, etc.
  }
 \paragraph {
    While the first approach is well-documented in lilypond's manual, it is unable
    to remove the fermata from "R1-\fermataMarkup," because the same engraver creates
    both the rest itself and all markup attached to it. Using the second approach, 
    one can also filter out that fermata (which is of type MultiMeasureTextEvent).
  }
  \paragraph {
    The second approach can be easily implemented in Scheme by defining a filter
    function, that returns false for all events to be removed (e.g. for 
    MultiMeasureTextEvent). This filter function is simply applied to the music of
    the second voice by the scheme function (music-filter filterfunction music).
  }
}
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The code describing the problem and the solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% definition of the voices:
mI = \relative c'' { R1-\fermataMarkup | c4\p d\accent c^"Text 1" d\fermata }
mII = \relative c'' { R1-\fermataMarkup | g4\p a\accent b_"Text 2" d_\fermata }

%% Define a music-filter function, which is applied to each event. If it 
%  returns false, the corresponding event is removed from the music. In our 
%  case we want to remove all dynamics, text markups, articulations and all
%  markups assigned to MultiMeasures (which are MultiMeasureTextEvents, NOT
%  TextScriptEvent, see the section "Full measure rests" in the Notation 
%  Reference)
#(define (filterOneEvent event)
( let ( (eventname (ly:music-property  event 'name)) )
 (not
  (or     ;; add here event name you do NOT want
   (eq? eventname 'MultiMeasureTextEvent)
   (eq? eventname 'AbsoluteDynamicEvent)
   (eq? eventname 'TextScriptEvent)
   (eq? eventname 'ArticulationEvent)
  )
 )
))

filtermusic = #(define-music-function (parser location music) (ly:music?)
   (music-filter filterOneEvent music)
)

% The score, where we combine the voices on one staff, so we only want 
% dynamics, articulations, etc. printed once
\score {
\context StaffGroup <<
  \context Staff = "both" << 
    \context Voice = "v1" << {\voiceOne \mI} >>
    \context Voice = "v2" \with { 
          % Dynamics, text markup, articulations, ornaments etc. can be removed
          % from one voice by simply removing the corresponding engraver:
          \remove "Dynamic_engraver"
          \remove "Dynamic_align_engraver" 
          \remove "Text_engraver" 
          \remove "Script_engraver"
          \remove "Mark_engraver"
          % However, the fermata in R1-\fermataMarkup is generated by the 
          % Multi_measure_rest_engraver, which also creates the rest, so
          % removing it is not possible without also removing the rest
          % itselft => No way to remove the fermata using this approach!
    } 
    << {\voiceTwo \mII} >>
    \set Staff.instrumentName = \markup \column { \line {"Combined,"}\line {"removing"} \line {"engravers"}}
  >>
  \context Staff = "bothFiltered" << 
    \context Voice = "v1Filtered" << {\voiceOne \mI} >>
    % However, we can filter the music and remove all *Events that we don't
    % want to be printed in this voice. 
    \context Voice = "v2Filtered" << {\voiceTwo \filtermusic \mII} >>
    \set Staff.instrumentName = \markup \column { \line {"Combined,"}\line {"using"} \line {"filters"}}
  >>
>>
\header { piece = "When combined on one staff, we want dynamics and markups only once" }
}

% The score, where each voice is on its own staff => it needs all markups, 
% articulations, dynamics, etc.
\score {
\context StaffGroup <<
  \context Staff = "first" << 
    \context Voice = "vstaff1" << {\mI} >>
    \set Staff.instrumentName = "Voice 1"
  >>
  \context Staff = "second" << 
    \context Voice = "vstaff2" << {\mII} >>
    \set Staff.instrumentName = "Voice 2"
  >>
>>
\header { piece = "Each voice has full dynamics and markups" }
}






