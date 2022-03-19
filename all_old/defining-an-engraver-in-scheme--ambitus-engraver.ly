%% http://lsr.dsi.unimi.it/LSR/Item?id=805
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/contexts-and-engravers#contexts-and-engravers-defining-an-engraver-in-scheme_003a-ambitus-engraver

#(use-modules (oop goops))

%%%
%%% Grob utilities
%%%
%%% These are literal rewrites of some C++ methods used by the ambitus engraver.

#(define (ly:separation-item::add-conditional-item grob grob-item)
   "Add @var{grob-item} to the array of conditional elements of @var{grob}.
Rewrite of @code{Separation_item::add_conditional_item} from @file{lily/separation-item.cc}."
   (ly:pointer-group-interface::add-grob grob 'conditional-elements grob-item))

#(define (ly:accidental-placement::accidental-pitch accidental-grob)
   "Get the pitch from the grob cause of @var{accidental-grob}.
Rewrite of @code{accidental_pitch} from @file{lily/accidental-placement.cc}."
   (ly:event-property (ly:grob-property (ly:grob-parent accidental-grob Y) 'cause)
                      'pitch))

#(define (ly:accidental-placement::add-accidental grob accidental-grob)
   "Add @var{accidental-grob}, an @code{Accidental} grob, to the
list of the accidental grobs of @var{grob}, an @code{AccidentalPlacement}
grob.
Rewrite of @code{Accidental_placement::add_accidental} from @file{lily/accidental-placement.cc}."
   (let ((pitch (ly:accidental-placement::accidental-pitch accidental-grob)))
     (set! (ly:grob-parent accidental-grob X) grob)
     (set! (ly:grob-property accidental-grob 'X-offset)
           ly:grob::x-parent-positioning)
     (let* ((accidentals (ly:grob-object grob 'accidental-grobs))
            (handle (assq (ly:pitch-notename pitch) accidentals))
            (entry (if handle (cdr handle) '())))
       (set! (ly:grob-object grob 'accidental-grobs)
             (assq-set! accidentals
                        (ly:pitch-notename pitch)
                        (cons accidental-grob entry))))))

%%%
%%% Ambitus data structure
%%%

%%% The <ambitus> class holds the various grobs that are created
%%% to print an ambitus:
%%% - ambitus-group: the grob that groups all the components of an ambitus
%%% (Ambitus grob);
%%% - ambitus-line: the vertical line between the upper and lower ambitus
%%% notes (AmbitusLine grob);
%%% - ambitus-up-note and ambitus-down-note: the note head and accidental
%%% for the lower and upper note of the ambitus (see <ambitus-note> class
%%% below).
%%% The other slots define the key and clef context of the engraver:
%%% - start-c0: position of middle c at the beginning of the piece.  It
%%% is used to place the ambitus notes according to their pitch;
%%% - start-key-sig: the key signature at the beginning of the piece.  It
%%% is used to determine if accidentals shall be printed next to ambitus
%%% notes.

#(define-class <ambitus> ()
   (ambitus-group #:accessor ambitus-group)
   (ambitus-line #:accessor ambitus-line)
   (ambitus-up-note #:getter ambitus-up-note
                    #:init-form (make <ambitus-note>))
   (ambitus-down-note #:getter ambitus-down-note
                      #:init-form (make <ambitus-note>))
   (start-c0 #:accessor ambitus-start-c0
             #:init-value #f)
   (start-key-sig #:accessor ambitus-start-key-sig
                  #:init-value '()))

%%% Accessor for the lower and upper note data of an ambitus
#(define-method (ambitus-note (ambitus <ambitus>) direction)
   "If @var{direction} is @code{UP}, then return the upper ambitus note
of @var{ambitus}, otherwise return the lower ambitus note."
   (if (= direction UP)
       (ambitus-up-note ambitus)
       (ambitus-down-note ambitus)))

%%% The <ambitus-note> class holds the grobs that are specific to ambitus
%%% (lower and upper) notes:
%%% - head: an AmbitusNoteHead grob;
%%% - accidental: an AmbitusAccidental grob, to be possibly printed next
%%% to the ambitus note head.
%%% Moreover:
%%% - pitch is the absolute pitch of the note
%%% - cause is the note event that causes this ambitus note, i.e. the lower
%%% or upper note of the considered music sequence.

#(define-class <ambitus-note> ()
   (head #:accessor ambitus-note-head
         #:init-value #f)
   (accidental #:accessor ambitus-note-accidental
               #:init-value #f)
   (cause #:accessor ambitus-note-cause
          #:init-value #f)
   (pitch #:accessor ambitus-note-pitch
          #:init-value #f))

%%%
%%% Ambitus engraving logics
%%%
%%% Rewrite of the code from @file{lily/ambitus-engraver.cc}.

#(define (make-ambitus translator)
   "Build an ambitus object: initialize all the grobs and their relations.

The Ambitus grob contain all other grobs:
 Ambitus
  |- AmbitusLine
  |- AmbitusNoteHead   for upper note
  |- AmbitusAccidental for upper note
  |- AmbitusNoteHead   for lower note
  |- AmbitusAccidental for lower note

The parent of an accidental is the corresponding note head,
and the accidental is set as the 'accidental-grob of the note head
so that is printed by the function that prints notes."
   ;; make the ambitus object
   (let ((ambitus (make <ambitus>)))
     ;; build the Ambitus grob, which will contain all other grobs
     (set! (ambitus-group ambitus) (ly:engraver-make-grob translator 'Ambitus '()))
     ;; build the AmbitusLine grob (line between lower and upper note)
     (set! (ambitus-line ambitus) (ly:engraver-make-grob translator 'AmbitusLine '()))
     ;; build the upper and lower AmbitusNoteHead and AmbitusAccidental
     (for-each (lambda (direction)
                 (let ((head (ly:engraver-make-grob translator 'AmbitusNoteHead '()))
                       (accidental (ly:engraver-make-grob translator 'AmbitusAccidental '()))
                       (group (ambitus-group ambitus)))
                   ;; The parent of the AmbitusAccidental grob is the
                   ;; AmbitusNoteHead grob
                   (set! (ly:grob-parent accidental Y) head)
                   ;; The AmbitusAccidental grob is set as the accidental-grob
                   ;; object of the AmbitusNoteHead.  This is later used by the
                   ;; function that prints notes.
                   (set! (ly:grob-object head 'accidental-grob) accidental)
                   ;; both the note head and the accidental grobs are added
                   ;; to the main ambitus grob.
                   (ly:axis-group-interface::add-element group head)
                   (ly:axis-group-interface::add-element group accidental)
                   ;; the note head and the accidental grobs are added to the
                   ;; ambitus object
                   (set! (ambitus-note-head (ambitus-note ambitus direction))
                         head)
                   (set! (ambitus-note-accidental (ambitus-note ambitus direction))
                         accidental)))
               (list DOWN UP))
     ;; The parent of the ambitus line is the lower ambitus note head
     (set! (ly:grob-parent (ambitus-line ambitus) X)
           (ambitus-note-head (ambitus-note ambitus DOWN)))
     ;; the ambitus line is added to the ambitus main grob
     (ly:axis-group-interface::add-element (ambitus-group ambitus) (ambitus-line ambitus))
     ambitus))

#(define-method (initialize-ambitus-state (ambitus <ambitus>) translator)
   "Initialize the state of @var{ambitus}, by getting the starting
position of middle C and key signature from @var{translator}'s context."
   (if (not (ambitus-start-c0 ambitus))
       (begin
         (set! (ambitus-start-c0 ambitus)
               (ly:context-property (ly:translator-context translator)
                                    'middleCPosition
                                    0))
         (set! (ambitus-start-key-sig ambitus)
               (ly:context-property (ly:translator-context translator)
                                    'keySignature)))))

#(define-method (update-ambitus-notes (ambitus <ambitus>) note-grob)
   "Update the upper and lower ambitus pithes of @var{ambitus}, using
@var{note-grob}."
   ;; Get the event that caused the note-grob creation
   ;; and check that it is a note-event.
   (let ((note-event (ly:grob-property note-grob 'cause)))
     (if (ly:in-event-class? note-event 'note-event)
         ;; get the pitch from the note event
         (let ((pitch (ly:event-property note-event 'pitch)))
           ;; if this pitch is lower than the current ambitus lower
           ;; note pitch (or it has not been initialized yet),
           ;; then this pitch is the new ambitus lower pitch,
           ;; and conversely for upper pitch.
           (for-each (lambda (direction pitch-compare)
                       (if (or (not (ambitus-note-pitch (ambitus-note ambitus direction)))
                               (pitch-compare pitch
                                              (ambitus-note-pitch (ambitus-note ambitus direction))))
                           (begin
                             (set! (ambitus-note-pitch (ambitus-note ambitus direction))
                                   pitch)
                             (set! (ambitus-note-cause (ambitus-note ambitus direction))
                                   note-event))))
                     (list DOWN UP)
                     (list ly:pitch<? (lambda (p1 p2)
                                        (ly:pitch<? p2 p1))))))))

#(define-method (typeset-ambitus (ambitus <ambitus>) translator)
   "Typeset the ambitus:
- place the lower and upper ambitus notes according to their pitch and
  the position of the middle C;
- typeset or delete the note accidentals, according to the key signature.
  An accidental, if it is to be printed, is added to an AccidentalPlacement
  grob (a grob dedicated to the placement of accidentals near a chord);
- both note heads are added to the ambitus line grob, so that a line should
  be printed between them."
   ;; check if there are lower and upper pitches
   (if (and (ambitus-note-pitch (ambitus-note ambitus UP))
            (ambitus-note-pitch (ambitus-note ambitus DOWN)))
       ;; make an AccidentalPlacement grob, for placement of note accidentals
       (let ((accidental-placement (ly:engraver-make-grob
                                    translator
                                    'AccidentalPlacement
                                    (ambitus-note-accidental (ambitus-note ambitus DOWN)))))
         ;; For lower and upper ambitus notes:
         (for-each (lambda (direction)
                     (let ((pitch (ambitus-note-pitch (ambitus-note ambitus direction))))
                       ;; set the cause and the staff position of the ambitus note
                       ;; according to the associated pitch
                       (set! (ly:grob-property (ambitus-note-head (ambitus-note ambitus direction))
                                               'cause)
                             (ambitus-note-cause (ambitus-note ambitus direction)))
                       (set! (ly:grob-property (ambitus-note-head (ambitus-note ambitus direction))
                                               'staff-position)
                             (+ (ambitus-start-c0 ambitus)
                                (ly:pitch-steps pitch)))
                       ;; determine if an accidental shall be printed for this note,
                       ;; according to the key signature
                       (let* ((handle (or (assoc (cons (ly:pitch-octave pitch)
                                                       (ly:pitch-notename pitch))
                                                 (ambitus-start-key-sig ambitus))
                                          (assoc (ly:pitch-notename pitch)
                                                 (ambitus-start-key-sig ambitus))))
                              (sig-alter (if handle (cdr handle) 0)))
                         (cond ((= (ly:pitch-alteration pitch) sig-alter)
                                ;; the note alteration is in the key signature
                                ;; => it does not have to be printed
                                (ly:grob-suicide!
                                 (ambitus-note-accidental (ambitus-note ambitus direction)))
                                (set! (ly:grob-object (ambitus-note-head (ambitus-note ambitus direction))
                                                      'accidental-grob)
                                      '()))
                               (else
                                ;; otherwise, the accidental shall be printed
                                (set! (ly:grob-property (ambitus-note-accidental
                                                         (ambitus-note ambitus direction))
                                                        'alteration)
                                      (ly:pitch-alteration pitch)))))
                       ;; add the AccidentalPlacement grob to the
                       ;; conditional items of the AmbitusNoteHead
                       (ly:separation-item::add-conditional-item
                        (ambitus-note-head (ambitus-note ambitus direction))
                        accidental-placement)
                       ;; add the AmbitusAccidental to the list of the
                       ;; AccidentalPlacement grob accidentals
                       (ly:accidental-placement::add-accidental
                        accidental-placement
                        (ambitus-note-accidental (ambitus-note ambitus direction)))
                       ;; add the AmbitusNoteHead grob to the AmbitusLine grob
                       (ly:pointer-group-interface::add-grob
                        (ambitus-line ambitus)
                        'note-heads
                        (ambitus-note-head (ambitus-note ambitus direction)))))
                   (list DOWN UP))
         ;; add the AccidentalPlacement grob to the main Ambitus grob
         (ly:axis-group-interface::add-element (ambitus-group ambitus) accidental-placement))
       ;; no notes ==> suicide the grobs
       (begin
         (for-each (lambda (direction)
                     (ly:grob-suicide! (ambitus-note-accidental (ambitus-note ambitus direction)))
                     (ly:grob-suicide! (ambitus-note-head (ambitus-note ambitus direction))))
                   (list DOWN UP))
         (ly:grob-suicide! ambitus-line))))

%%%
%%% Ambitus engraver definition
%%%
#(define ambitus-engraver
   (lambda (context)
     (let ((ambitus #f))
       ;; when music is processed: make the ambitus object, if not already built
       (make-engraver
	((process-music translator)
	 (if (not ambitus)
	     (set! ambitus (make-ambitus translator))))
	;; set the ambitus clef and key signature state
	((stop-translation-timestep translator)
	 (if ambitus
	     (initialize-ambitus-state ambitus translator)))
	;; when a note-head grob is built, update the ambitus notes
	(acknowledgers
          ((note-head-interface engraver grob source-engraver)
	   (if ambitus
	       (update-ambitus-notes ambitus grob))))
	;; finally, typeset the ambitus according to its upper and lower notes
	;; (if any).
	((finalize translator)
	 (if ambitus
	     (typeset-ambitus ambitus translator)))))))

%%%
%%% Example
%%%

\score {
  \new StaffGroup <<
    \new Staff { c'4 des' e' fis' gis' }
    \new Staff { \clef "bass" c4 des ~ des ees b, }
  >>
  \layout { \context { \Staff \consists #ambitus-engraver } }
}