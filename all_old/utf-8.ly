%% http://lsr.di.unimi.it/LSR/Item?id=600
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/special-characters.fr.html

% end verbatim - this comment is a hack to prevent texinfo.tex
% from choking on non-European UTF-8 subsets

%% Edit this file using a Unicode aware editor, such as GVIM, GEDIT, Emacs

%{

You may have to install additional fonts.

Red Hat Fedora

    taipeifonts fonts-xorg-truetype ttfonts-ja fonts-arabic \
   ttfonts-zh_CN fonts-ja fonts-hebrew 

Debian GNU/Linux

   apt-get install emacs-intl-fonts xfonts-intl-.* \
  ttf-kochi-gothic ttf-kochi-mincho \
  xfonts-bolkhov-75dpi xfonts-cronyx-100dpi xfonts-cronyx-75dpi 
%}

% Cyrillic font
bulgarian = \lyricmode {
  Жълтата дюля беше щастлива, че пухът, който цъфна, замръзна като гьон.
}

hebrew = \lyricmode {
  זה כיף סתם לשמוע איך תנצח קרפד עץ טוב בגן.
}

japanese = \lyricmode {
  いろはにほへど ちりぬるを
  わがよたれぞ  つねならむ
  うゐのおくや  まけふこえて
  あさきゆめみじ ゑひもせず
}

% "a legal song to you"
portuguese = \lyricmode {
  à vo -- cê uma can -- ção legal
}

\relative c' {
  c2 d
  e2 f
  g2 f
  e1
}
\addlyrics { \bulgarian }
\addlyrics { \hebrew }
\addlyrics { \japanese }
\addlyrics { \portuguese }


