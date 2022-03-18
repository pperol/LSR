%% http://lsr.dsi.unimi.it/LSR/Item?id=197
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v-2-18-quot-File-Information-quot-strange-warnings-tc159399.html

% originally made for
% \version "2.22.0"
% Modified by David Kastrup for V:2.18 on Feb. 2014

%{ Display ly file information on the score, including file name, file size,
 LilyPond version, date processed, time processed, time last modified, and
 the LilyPond command line. %}

#(define comml    (object->string (command-line)))
#(define loc      (+ (string-rindex comml #\space ) 2)) 
#(define commllen (- (string-length comml) 2))
#(define filen    (substring comml loc commllen))
#(define siz      (object->string (stat:size (stat filen))))
#(define ver      (object->string (lilypond-version)))
#(define dat      (strftime "%m/%d/%Y" (localtime (current-time))))
#(define tim      (strftime "%H:%M:%S" (localtime (current-time))))
#(define modt     (stat:mtime (stat filen)))
#(define modts    (strftime "%m/%d/%Y %H:%M:%S" (localtime modt)))
		\header { dedication = \markup \column {
{ "- - - - - - Using Scheme \"define\"-  - - - - -" } % "
\line { "File Name = "        \filen }
\line { "File Size = "        \siz   }
\line { "LilyPond Version = " \ver   }
\line { "Date Processed = "   \dat   }
\line { "Time Processed = "   \tim   }
\line { "Last Modified = "    \modts }
\line { "Command Line = "     \comml }
{ "" }
{ "- - - - - - Using \"ly:export\" - - - - - -" } % "
{ $(string-append    "File Name = "
              (substring (object->string (command-line))
           (+ (string-rindex (object->string (command-line)) #\sp ) 1)
           (- (string-length (object->string (command-line))) 1))) }
{ $(string-append    "File Size = "
              (object->string (stat:size (stat filen)))) } 
{ $(string-append    "LilyPond Version = "
              (lilypond-version)) } 
{ $(string-append    "Date Processed = "
              (strftime "%m/%d/%Y" (localtime (current-time)))) }
{ $(string-append    "Time Processed = "
              (strftime "%H:%M:%S" (localtime (current-time)))) }
{ $(string-append    "Last Modified = "
              (strftime "%m/%d/%Y %H:%M:%S"
              (localtime (stat:mtime (stat filen))))) }
{ $(string-append    "Command Line = "
              (object->string (command-line))) } 
	}	}
{ c''1_\markup { \column {
{ "- - - - - - In \"markup\" - - - - - -" } % "
\line { "File Name = "        \filen }
\line { "File Size = "        \siz   }
\line { "LilyPond Version = " \ver   }
\line { "Date Processed = "   \dat   }
\line { "Time Processed = "   \tim   }
\line { "Last Modified = "    \modts }
\line { "Command Line = "     \comml }
}}}
