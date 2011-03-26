%
% This document class style is used with the Ubuntu Manual.
% https://wiki.ubuntu.com/ubuntu-manual/
% https://launchpad.net/ubuntu-manual
%

%
% Idenfification
%

\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{ubuntu-manual}[2010/01/12 v0.0.9 Ubuntu manual document class]

\RequirePackage{xkeyval}
\RequirePackage{xifthen}
\RequirePackage{ifpdf}
\IfFileExists{ifxetex.sty}{\RequirePackage{ifxetex}}{\ClassError{ubuntu-manual}{The ifxetex package is missing.\MessageBreak Run the install-pkgs.sh script again}{The ifxetex package is required but is not installed.\MessageBreak Run the install-pkgs.sh script to install it.}}
\RequireXeTeX% XeTeX is required now
%\RequirePackage[utf8]{inputenc}

%
% Declaration of options
%

\newboolean{@ubuntu@debug}
\DeclareOptionX<ubuntu-manual>{debug}{\setboolean{@ubuntu@debug}{true}}

% Current languages
\providecommand*{\@ubuntu@script}{Latin}
\providecommand*{\@ubuntu@language}{english}
\providecommand*{\@ubuntu@language@options}{}
\providecommand*{\@ubuntu@language@code}{en}
\providecommand*{\@ubuntu@xindy@language}{}
\define@key{ubuntu-manual}{lang}[default]{%
  \ClassInfo{ubuntu-manual}{Specified language is: #1}%
  \renewcommand*{\@ubuntu@language@code}{\detokenize{#1}}%
  \ifthenelse{\equal{#1}{en}}   {\ExecuteOptionsX<ubuntu-manual>{letterpaper}\ExecuteOptionsX<ubuntu-manual>{USenglish}\renewcommand*{\@ubuntu@language}{USenglish}}{}% English (US)
  \ifthenelse{\equal{#1}{en_US}}{\ExecuteOptionsX<ubuntu-manual>{letterpaper}\ExecuteOptionsX<ubuntu-manual>{USenglish}\renewcommand*{\@ubuntu@language}{USenglish}}{}% English (US)
  \ifthenelse{\equal{#1}{af}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{afrikaans}\RequireXeTeX\renewcommand*{\@ubuntu@language}{afrikaans}}{}% Afrikaans
  \ifthenelse{\equal{#1}{am}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{amharic}\RequireXeTeX\renewcommand*{\@ubuntu@language}{amharic}}{}% Amharic
  \ifthenelse{\equal{#1}{ar}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{arabic}\RequireXeTeX\renewcommand*{\@ubuntu@language}{arabic}\PassOptionsToPackage{RTLdocument}{bidi}\PassOptionsToClass{bidi}{tufte-book}}{}% Arabic
  \ifthenelse{\equal{#1}{ast}}  {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{asturian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{asturian}}{}% Asturian
  \ifthenelse{\equal{#1}{bg}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{bulgarian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{bulgarian}}{}% Bulgarian
  \ifthenelse{\equal{#1}{bn}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{bengali}\RequireXeTeX\renewcommand*{\@ubuntu@language}{bengali}}{}% Bengali
  \ifthenelse{\equal{#1}{br}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{breton}\RequireXeTeX\renewcommand*{\@ubuntu@language}{breton}}{}% Breton
  \ifthenelse{\equal{#1}{cop}}  {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{coptic}\RequireXeTeX\renewcommand*{\@ubuntu@language}{coptic}}{}% Coptic
  \ifthenelse{\equal{#1}{ca}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{catalan}\RequireXeTeX\renewcommand*{\@ubuntu@language}{catalan}}{}% Catalan
  \ifthenelse{\equal{#1}{cs}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{czech}\RequireXeTeX\renewcommand*{\@ubuntu@language}{czech}}{}% Czech
  \ifthenelse{\equal{#1}{cy}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{welsh}\RequireXeTeX\renewcommand*{\@ubuntu@language}{welsh}}{}% Welsh
  \ifthenelse{\equal{#1}{da}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{danish}\RequireXeTeX\renewcommand*{\@ubuntu@language}{danish}}{}% Danish
  \ifthenelse{\equal{#1}{de}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{german}\RequireXeTeX\renewcommand*{\@ubuntu@language}{german}\renewcommand*{\@ubuntu@xindy@language}{german-din}}{}% German
  \ifthenelse{\equal{#1}{dsb}}  {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{lsorbian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{lsorbian}}{}% Lower Sorbian
  \ifthenelse{\equal{#1}{dv}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{divehi}\RequireXeTeX\renewcommand*{\@ubuntu@language}{divehi}}{}% Divehi
  \ifthenelse{\equal{#1}{el}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{greek}\RequireXeTeX\renewcommand*{\@ubuntu@language}{greek}}{}% Greek
  \ifthenelse{\equal{#1}{en_AU}}{\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{australian}\renewcommand*{\@ubuntu@language}{australian}}{}% English (Australian)
  \ifthenelse{\equal{#1}{en_GB}}{\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{UKenglish}\renewcommand*{\@ubuntu@language}{UKenglish}}{}% English (United Kingdom)
  \ifthenelse{\equal{#1}{eo}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{esperanto}\RequireXeTeX\renewcommand*{\@ubuntu@language}{esperanto}}{}% Esperanto
  \ifthenelse{\equal{#1}{es}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{spanish}\RequireXeTeX\renewcommand*{\@ubuntu@language}{spanish}}{}% Spanish
  \ifthenelse{\equal{#1}{et}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{estonian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{estonian}}{}% Estonian
  \ifthenelse{\equal{#1}{eu}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{basque}\RequireXeTeX\renewcommand*{\@ubuntu@language}{basque}}{}% Basque
  \ifthenelse{\equal{#1}{fi}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{finnish}\RequireXeTeX\renewcommand*{\@ubuntu@language}{finnish}}{}% Finnish
  \ifthenelse{\equal{#1}{fa}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{farsi}\RequireXeTeX\renewcommand*{\@ubuntu@language}{farsi}}{}% Persian
  \ifthenelse{\equal{#1}{fr}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{french}\RequireXeTeX\renewcommand*{\@ubuntu@language}{french}}{}% French
  \ifthenelse{\equal{#1}{ga}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{irish}\RequireXeTeX\renewcommand*{\@ubuntu@language}{irish}}{}% Irish
  \ifthenelse{\equal{#1}{gd}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{scottish}\RequireXeTeX\renewcommand*{\@ubuntu@language}{scottish}}{}% Scottish
  \ifthenelse{\equal{#1}{gl}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{galician}\RequireXeTeX\renewcommand*{\@ubuntu@language}{galician}}{}% Galician
  %\ifthenelse{\equal{#1}{grc}}  {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{greek}\RequireXeTeX\renewcommand{\@ubuntu@language@options}{variant=ancient}\renewcommand*{\@ubuntu@language}{greek}}{}% Ancient Greek (to 1453)
  \ifthenelse{\equal{#1}{grc}}  {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{greek}\RequireXeTeX\renewcommand*{\@ubuntu@language}{ancientgreek}}{}% Ancient Greek (to 1453)
  \ifthenelse{\equal{#1}{he}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{hebrew}\RequireXeTeX\renewcommand*{\@ubuntu@language}{hebrew}}{}% Hebrew
  \ifthenelse{\equal{#1}{hi}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{hindi}\RequireXeTeX\renewcommand*{\@ubuntu@language}{hindi}}{}% Hindi
  \ifthenelse{\equal{#1}{hr}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{croatian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{croatian}}{}% Croatian
  \ifthenelse{\equal{#1}{hsb}}  {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{usorbian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{usorbian}}{}% Upper Sorbian
  \ifthenelse{\equal{#1}{hu}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{magyar}\RequireXeTeX\renewcommand*{\@ubuntu@language}{magyar}}{}% Hungarian
  \ifthenelse{\equal{#1}{ia}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{interlingua}\RequireXeTeX\renewcommand*{\@ubuntu@language}{interlingua}}{}% Interlingua
  \ifthenelse{\equal{#1}{id}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{bahasai}\RequireXeTeX\renewcommand*{\@ubuntu@language}{bahasai}}{}% Indonesian
  \ifthenelse{\equal{#1}{is}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{icelandic}\RequireXeTeX\renewcommand*{\@ubuntu@language}{icelandic}}{}% Icelandic
  \ifthenelse{\equal{#1}{it}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{italian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{italian}}{}% Italian
  \ifthenelse{\equal{#1}{ja}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{japanese}\RequireXeTeX\renewcommand*{\@ubuntu@language}{japanese}}{}% Japanese
  \ifthenelse{\equal{#1}{ko}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{korean}\RequireXeTeX\renewcommand*{\@ubuntu@language}{korean}}{}% Korean
  \ifthenelse{\equal{#1}{la}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{latin}\RequireXeTeX\renewcommand*{\@ubuntu@language}{latin}}{}% Latin
  \ifthenelse{\equal{#1}{lv}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{latvian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{latvian}}{}% Latvian
  \ifthenelse{\equal{#1}{lt}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{lithuanian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{lithuanian}}{}% Lithuanian
  \ifthenelse{\equal{#1}{ml}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{malayalam}\RequireXeTeX\renewcommand*{\@ubuntu@language}{malayalam}}{}% Malayalam
  \ifthenelse{\equal{#1}{mr}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{marathi}\RequireXeTeX\renewcommand*{\@ubuntu@language}{marathi}}{}% Marathi
  \ifthenelse{\equal{#1}{ms}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{bahasam}\RequireXeTeX\renewcommand*{\@ubuntu@language}{bahasam}}{}% Malaysian
  \ifthenelse{\equal{#1}{nb}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{norsk}\RequireXeTeX\renewcommand*{\@ubuntu@language}{norsk}}{}% Norwegian
  \ifthenelse{\equal{#1}{nn}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{nynorsk}\RequireXeTeX\renewcommand*{\@ubuntu@language}{nynorsk}}{}% Nynorsk
  \ifthenelse{\equal{#1}{nl}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{dutch}\RequireXeTeX\renewcommand*{\@ubuntu@language}{dutch}}{}% Dutch
  \ifthenelse{\equal{#1}{oc}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{occitan}\RequireXeTeX\renewcommand*{\@ubuntu@language}{occitan}}{}% Occitan (post 1500)
  \ifthenelse{\equal{#1}{pl}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{polish}\RequireXeTeX\renewcommand*{\@ubuntu@language}{polish}}{}% Polish
  \ifthenelse{\equal{#1}{pt_BR}}{\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{brazil}\RequireXeTeX\renewcommand*{\@ubuntu@language}{brazil}}{}% Brazilian Porteguese
  \ifthenelse{\equal{#1}{pt}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{portuges}\RequireXeTeX\renewcommand*{\@ubuntu@language}{portuges}}{}% Porteguese
  \ifthenelse{\equal{#1}{ro}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{romanian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{romanian}}{}% Romanian
  \ifthenelse{\equal{#1}{ru}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{russian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{russian}}{}% Russian
  \ifthenelse{\equal{#1}{sa}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{sanskrit}\RequireXeTeX\renewcommand*{\@ubuntu@language}{sanskrit}}{}% Sanskrit
  \ifthenelse{\equal{#1}{se}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{samin}\RequireXeTeX\renewcommand*{\@ubuntu@language}{samin}}{}% Northern Sami
  \ifthenelse{\equal{#1}{sk}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{slovak}\RequireXeTeX\renewcommand*{\@ubuntu@language}{slovak}}{}% Slovak
  \ifthenelse{\equal{#1}{sl}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{slovenian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{slovenian}}{}% Slovenian
  \ifthenelse{\equal{#1}{sq}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{albanian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{albanian}}{}% Albanian
  \ifthenelse{\equal{#1}{sr}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{serbian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{serbian}}{}% Serbian
  \ifthenelse{\equal{#1}{sv}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{swedish}\RequireXeTeX\renewcommand*{\@ubuntu@language}{swedish}}{}% Swedish
  \ifthenelse{\equal{#1}{syc}}  {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{syriac}\RequireXeTeX\renewcommand*{\@ubuntu@language}{syriac}}{}% Syriac
  \ifthenelse{\equal{#1}{ta}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{tamil}\RequireXeTeX\renewcommand*{\@ubuntu@language}{tamil}}{}% Tamil
  \ifthenelse{\equal{#1}{te}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{telugu}\RequireXeTeX\renewcommand*{\@ubuntu@language}{telugu}}{}% Telugu
  \ifthenelse{\equal{#1}{th}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{thai}\RequireXeTeX\renewcommand*{\@ubuntu@language}{thai}}{}% Thai
  \ifthenelse{\equal{#1}{tr}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{turkish}\RequireXeTeX\renewcommand*{\@ubuntu@language}{turkish}}{}% Turkish
  \ifthenelse{\equal{#1}{uk}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{ukrainian}\RequireXeTeX\renewcommand*{\@ubuntu@language}{ukrainian}}{}% Ukrainian
  \ifthenelse{\equal{#1}{vi}}   {\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{vietnamese}\RequireXeTeX\renewcommand*{\@ubuntu@language}{vietnamese}}{}% Vietnamese
  \ifthenelse{\equal{#1}{zh_CH}}{\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{chinese}\RequireXeTeX\renewcommand*{\@ubuntu@language}{chinese}}{}% Chinese
  \ifthenelse{\equal{#1}{zh_CN}}{\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{chinese}\RequireXeTeX\renewcommand*{\@ubuntu@language}{chinese}\renewcommand*{\@ubuntu@language@options}{variant=simplified}}{}% Chinese (simplified)
  \ifthenelse{\equal{#1}{zh_TW}}{\ExecuteOptionsX<ubuntu-manual>{a4paper}\ExecuteOptionsX<ubuntu-manual>{chinese}\RequireXeTeX\renewcommand*{\@ubuntu@language}{chinese}\renewcommand*{\@ubuntu@language@options}{variant=traditional}}{}% Chinese (traditional)

  \ifthenelse{\equal{#1}{default}}{%
    \ClassWarningNoLine{ubuntu-manual}{Invalid option `#1' for lang key.\MessageBreak The language #1 is not supported yet.\MessageBreak Defaulting to US English.\MessageBreak Email the Ubuntu Manual team for help.}%
    \ExecuteOptionsX<ubuntu-manual>{letterpaper}%
    \ExecuteOptionsX<ubuntu-manual>{USenglish}%
    \renewcommand*{\@ubuntu@language}{USenglish}%
    \renewcommand*{\@ubuntu@language@code}{en}%
  }

  \ifthenelse{\equal{\@ubuntu@xindy@language}{}}{%
    \let\@ubuntu@xindy@language\@ubuntu@language%
  }{}
}

% Provide ``print'' and ``screen'' options
\newboolean{@ubuntu@print}\setboolean{@ubuntu@print}{false}
\DeclareOptionX<ubuntu-manual>{print}{\setboolean{@ubuntu@print}{true}}
\DeclareOptionX<ubuntu-manual>{screen}{\setboolean{@ubuntu@print}{false}}

% The ubuntu-manual document class has no options of its own, yet.  We just
% pass along any options to the underlying Tufte-LaTeX book class.
\DeclareOptionX*{%
  \PassOptionsToClass{\CurrentOption}{tufte-book}%
}

% Don't use letterspacing from tufte-book class as there's a bug there.
\PassOptionsToClass{nols}{tufte-book}

% Use sans serif margin notes
\PassOptionsToClass{sfsidenotes}{tufte-book}

% Fully-ustified text
%\PassOptionsToClass{justified}{tufte-book}

%
% Execute options
%

\ProcessOptionsX*<ubuntu-manual>\relax

%
% Load the underlying Tufte-LaTeX book class
%

\LoadClass{tufte-book}

%
% Load packages
%

\RequirePackage{wrapfig}% load before bidi package

\RequirePackage{calc}
\RequirePackage{setspace}

%\RequirePackage{listings}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}% to modify the running heads/feet and page styles
\RequirePackage{makeidx}% to create the index
\RequirePackage{eso-pic}% to insert the cover page
\RequirePackage{paralist}% for fancier enumeration environments
\RequirePackage{comment}% provides comment environment
\RequirePackage{multicol}% for putting text into multiple columns (load before bidi)
\RequirePackage{pifont}% for arrows and other dingbats
\RequirePackage{textcase}% forces text to be upper- or lowercase
\RequirePackage{substr}% provides some substr-like functions
\RequirePackage{ccicons}% Creative Commons icons
\RequirePackage[unicode]{hyperref}% sets up hyperlinking colors (load before bidi)
\graphicspath{{.}{graphics}{../graphics}}
\RequirePackage[load=abbr,mode=text,alsoload=binary]{siunitx}% proper spacing and names for units
\RequirePackage[colorinlistoftodos,disable]{todonotes}% for putting notes in the PDF to be disabled in production PDF
\RequirePackage[nonumberlist,translate=true,toc,xindy={glsnumbers=false,language=\@ubuntu@xindy@language,codepage=utf8}]{glossaries}% to create a glossary -- must be loaded AFTER hyperref
\renewcommand{\glspostdescription}{}% suppresses full stop after the description in the glossary

\RequirePackage{polyglossia}% for translations and other languages/scripts
\setdefaultlanguage[\@ubuntu@language@options]{\@ubuntu@language}%
\setotherlanguage[variant=american]{english}%
\RequirePackage[babel]{csquotes}% for language-specific quotation marks
\RequirePackage{LTPlius}
%\setmainfont[Mapping=tex-text,Numbers=OldStyle,SmallCapsFont={* C}]{Linux Libertine O}
\setmainfont[Mapping=tex-text,Numbers=OldStyle]{Linux Libertine O}
\setsansfont[Mapping=tex-text,Numbers=OldStyle]{Linux Biolinum O}
\setmonofont[Mapping=text-text,Scale=MatchLowercase]{DejaVu Sans Mono}
%\newfontinstance\scshape[Letters=SmallCaps,Numbers=Uppercase]{Linux Libertine O}
% Set the xindy language for glossaries
%\GlsSetXdyLanguage{\@ubuntu@language}

% A command that prints an interrupting dash.  Varies per language.  (For example, US is ``---'' without spacing, UK is `` -- '' with space.)
\newcommand{\dash}{-- }

\ifthenelse{\boolean{@ubuntu@debug}}{\XeTeXtracingfonts=1}{\XeTeXtracingfonts=0}% log font switching

%\RequirePackage{xmpincl}% XMP for CC licensing% FIXME fails with XeTeX

% Make sure URLs are printed in English
\urlstyle{same} % gets rid of that rubbishy monospaced URL font - humphreybc
\def\UrlBigBreaks{\do@url@hyp}% removed colon
\def\UrlNoBreaks{\do\(\do\[\do\{\do\<\do\:}% added colon
\let\@ubuntu@orig@url\url
\renewcommand{\url}[1]{\textenglish{\@ubuntu@orig@url{#1}}}

%
% Format the document style
%

% Ubuntu color palette
\definecolor{UbuntuOrange}              {HTML}{FF6309}% Ubuntu orange
\definecolor{UbuntuYellow}              {HTML}{FFB515}% Ubuntu yellow
\definecolor{UbuntuRed}                 {HTML}{C90016}% Ubuntu red
\definecolor{OrangeHilight}             {HTML}{EEC73E}% oranges
\definecolor{Orange}                    {HTML}{F0A513}
\definecolor{OrangeBase}                {HTML}{FB8B00}
\definecolor{OrangeShadow}              {HTML}{F44800}
\definecolor{AccentYellowHilight}       {HTML}{FDFF99}% yellows
\definecolor{Yellow}                    {HTML}{FFFF00}
\definecolor{AccentYellowBase}          {HTML}{FDCA01}
\definecolor{AccentYellowShadow}        {HTML}{986601}
\definecolor{AccentOrange}              {HTML}{F44800}% reds
\definecolor{AccentRed}                 {HTML}{FD3301}
\definecolor{AccentRedBase}             {HTML}{D40000}
\definecolor{AccentDeepRed}             {HTML}{980101}
\definecolor{HumanHighlight}            {HTML}{FDD99B}% skin tones
\definecolor{Human}                     {HTML}{D9BB7A}
\definecolor{HumanBase}                 {HTML}{816647}
\definecolor{EnvironmentalShadow}       {HTML}{565248}
\definecolor{EnvironmentalBlueHighlight}{HTML}{AACCEE}% environmental blues
\definecolor{EnvironmentalBlueMedium}   {HTML}{6699CC}
\definecolor{EnvironmentalBlueBase}     {HTML}{336699}
\definecolor{EnvironmentalBlueShadow}   {HTML}{003366}
\definecolor{AccentBlueHighlight}       {HTML}{B3DEFD}% accent blues
\definecolor{AccentBlue}                {HTML}{0197FD}
\definecolor{AccentBlueBase}            {HTML}{0169C9}
\definecolor{AccentBlueShadow}          {HTML}{013397}
\definecolor{AccentGreenHiglight}       {HTML}{CCFF99}% greens
\definecolor{AccentGreen}               {HTML}{98FC66}
\definecolor{AccentGreenBase}           {HTML}{339900}
\definecolor{AccentGreenShadow}         {HTML}{015A01}
\definecolor{UbuntuToner}               {HTML}{002B3D}% toner
\definecolor{AccentMagentHighlight}     {HTML}{FF9BFF}% magentas
\definecolor{AccentMagenta}             {HTML}{FF00FF}
\definecolor{AccentDarkViolet}          {HTML}{6600CC}

\definecolor{important}{HTML}{980101}% same as accent deep red
%\definecolor{UbuntuAubergine}{HTML}{772953}% aubergine (from design.canonical.com heading)
%\definecolor{UbuntuAubergine}{HTML}{1A0512}% aubergine (from https://wiki.ubuntu.com/Brand?action=AttachFile&do=get&target=boot.png)
%\definecolor{UbuntuAubergine}{HTML}{6e154c}% aubergine
%\definecolor{UbuntuAubergine}{HTML}{4c0d34}% aubergine
%\definecolor{UbuntuAubergine}{HTML}{991a68}% aubergine

% If we're generating the print version, use slightly larger pages to allow for bleed.
%\ifthenelse{\boolean{@ubuntu@print}}{%
  %\ifthenelse{\boolean{@tufte@afourpaper}}{%
    %\geometry{layoutwidth=210mm,layoutheight=297mm,paperwidth=213.175mm,paperheight=300.175mm,left=24.8mm,top=27.4mm,headsep=2\baselineskip,textwidth=107mm,marginparsep=8.2mm,marginparwidth=49.4mm,textheight=49\baselineskip,headheight=\baselineskip}%
  %}{%
    %\geometry{layoutwidth=8.5in,layoutheight=11in,paperwidth=8.75in,paperheight=11.25in,left=1in,top=1in,headsep=2\baselineskip,textwidth=26pc,marginparsep=2pc,marginparwidth=12pc,textheight=44\baselineskip,headheight=\baselineskip}%
  %}%
%}


\hypersetup{%
  pdfborder = {0 0 0},
  bookmarksdepth = section,
  citecolor = AccentDeepRed, %DarkGreen,
  linkcolor = AccentDeepRed, %DarkBlue,
  urlcolor = AccentDeepRed, %DarkGreen,
  %colorlinks = true,
}%

% If it's for on-screen viewing, use color links; otherwise use black links.
\ifthenelse{\boolean{@ubuntu@print}}{%
  \hypersetup{colorlinks=false}%
}{%
  \hypersetup{colorlinks=true}%
}

% Set the paragraph spacing and indentation
%\setlength{\parskip}{0pt}
%\setlength{\parindent}{0pt}
%\setlength{\parskip}{\baselineskip}


% For acronyms
\DeclareRobustCommand{\smallcaps}[1]{{\scshape\MakeTextLowercase{#1}}}
\newcommand{\acronym}[1]{\smallcaps{#1}}

% Format code listings
%\lstset{
  %basicstyle=\normalsize,
  %language=bash,
  %aboveskip=.6em,
  %belowskip=.6em,
  %breaklines=true,
  %identifierstyle=\ttfamily,
  %keywordstyle=\color[rgb]{0,0,1},
  %commentstyle=\color[rgb]{0.133,0.545,0.133},
  %stringstyle=\color[rgb]{0.627,0.126,0.941}
%}

% Enable indexing
\makeindex

% Enable glossaries
\makeglossaries

% Set the running head style to \smallcaps by default
\let\runningheadstyle\smallcaps

% Print the full running heads in the front matter
\renewcommand\frontmatter{%
  \cleardoublepage%
  \@mainmatterfalse%
  \pagenumbering{arabic}%
  %\pagestyle{plain}%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}%
    {% two-side
      \renewcommand{\chaptermark}[1]{\markboth{##1}{}}%
      \fancyhead[LE]{\thepage\quad\runningheadstyle{\newlinetospace{\plaintitle}}}% book title
      \fancyhead[RO]{\runningheadstyle{\newlinetospace{\leftmark}}\quad\thepage}% chapter title
    }%
    {% one-side
      \fancyhead[RE,RO]{\runningheadstyle{\newlinetospace{\plaintitle}}\quad\thepage}% book title
    }%
}

% Use the \runningheadstyle for running heads in the front and main matter
\renewcommand\mainmatter{%
  \cleardoublepage%
  \@mainmattertrue%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}%
    {% two-side
      \renewcommand{\chaptermark}[1]{\markboth{##1}{}}%
      \fancyhead[LE]{\thepage\quad\runningheadstyle{\newlinetospace{\plaintitle}}}% book title
      \fancyhead[RO]{\runningheadstyle{\newlinetospace{\leftmark}}\quad\thepage}% chapter title
    }%
    {% one-side
      \fancyhead[RE,RO]{\runningheadstyle{\newlinetospace{\plaintitle}}\quad\thepage}% book title
    }%
}


% Format the chapter and section marks (primarily to remove the \uppercase stuff)
\renewcommand*{\chaptermark}[1]{\markboth{#1}{#1}}%
\renewcommand*{\sectionmark}[1]{}

% Remove \MakeUppercase from TOC marks
\renewcommand\tableofcontents{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\contentsname}\markboth{\contentsname}{}%
  \pdfbookmark[0]{\contentsname}{pdfbookmark:contents}%
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
}


% Formatting for main TOC (printed in front matter)
% {section} [left] {above} {before w/label} {before w/o label} {filler + page} [after]
\newlength{\contentsindent}
\setlength{\contentsindent}{1em}
\titlecontents{part}% FIXME
  [0em] % distance from left margin
  {\vspace{\baselineskip}} % above (global formatting of entry)
  {\contentslabel{\contentsindent}} % before w/label (label = ``II'')
  {} % before w/o label
  {\quad\thecontentspage} % filler + page (leaders and page num)
  [] % after
\titlecontents{chapter}%
  [0em] % distance from left margin
  {\vspace{1\baselineskip}} % above (global formatting of entry)
  {\hspace*{2\contentsindent}\contentslabel{2\contentsindent}} % before w/label (label = ``2'')
  {\hspace*{2\contentsindent}} % before w/o label
  {\quad\thecontentspage} % filler + page (leaders and page num)
  [] % after
\titlecontents{section}% FIXME
  [0em] % distance from left margin
  {\vspace{0\baselineskip}} % above (global formatting of entry)
  {\hspace*{3\contentsindent}\contentslabel{3\contentsindent}} % before w/label (label = ``2.6'')
  {\hspace*{3\contentsindent}} % before w/o label
  {\quad\thecontentspage} % filler + page (leaders and page num)
  [] % after
\titlecontents{subsection}% FIXME
  [0em] % distance from left margin
  {\vspace{0\baselineskip}} % above (global formatting of entry)
  {\hspace*{4\contentsindent}\contentslabel{4\contentsindent}} % before w/label (label = ``2.6.1'')
  {\hspace*{4\contentsindent}} % before w/o label
  {\quad\thecontentspage} % filler + page (leaders and page num)
  [] % after




% Format the chapter headings
\titleformat{\chapter}[block]% command and paragraph shape
  {\bfseries\Huge\sffamily}% format
  {\bfseries\Huge\sffamily\thechapter\quad}% label
  {0mm}% separation
  {}% before
  []% after

\titlespacing*{\chapter}%
  {0pt}% left
  {0pt}% vertical space before title
  {\baselineskip}% separation between title and text
  [0pt]% right

% Format the section headings
\titleformat*{\section}{\sffamily\bfseries\Large}%

% Format the subsection headings
\titleformat*{\subsection}{\sffamily\bfseries\large}%

% Define the \subsubsection command since tufte-book doesn't
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\sffamily\bfseries}}

% Format the subsubsection headings
\titleformat*{\subsubsection}{\sffamily\bfseries\normalsize}%


% The table of contents entries should only go down to \section
\setcounter{tocdepth}{1}

% Only number chapters
\setcounter{secnumdepth}{0}

% Single-space the entire document
\singlespacing

% Inserts the front cover image
\newcommand{\frontcover}{%
  \thispagestyle{empty}%
  %\AddToShipoutPicture*{\put(0,0){\includegraphics[width=\paperwidth,height=\paperheight]{coverpage.pdf}}}%
  %\AddToShipoutPicture*{\put(0,0){\includegraphics[width=\paperwidth,height=\paperheight]{titlepage/Alpha-Title-letter.png}}}%
  \IfFileExists{titlepage/titlepage-\polang.pdf}{%
    \AddToShipoutPicture*{\put(0,0){\includegraphics[width=\paperwidth,height=\paperheight]{titlepage/titlepage-\polang.pdf}}}%
  }{%
    \ifthenelse{\boolean{@tufte@afourpaper}}{%
      \ClassWarningNoLine{ubuntu-manual}{No cover page for \@ubuntu@language\space found.\MessageBreak Defaulting to English A4 cover page.}%
      \AddToShipoutPicture*{\put(0,0){\includegraphics[width=\paperwidth,height=\paperheight]{titlepage/title_page_a4_en.pdf}}}%
    }{%
      \ClassWarningNoLine{ubuntu-manual}{No cover page for \@ubuntu@language\space found.\MessageBreak Defaulting to English letter cover page.}%
      \AddToShipoutPicture*{\put(0,0){\includegraphics[width=\paperwidth,height=\paperheight]{titlepage/title_page_letter_en.pdf}}}%
    }%
  }%
  \null\clearpage%
}

% When cleardoublepage is called, produce a blank (empty) page -- i.e.,
% without headers and footers
\def\cleardoublepage{%
  \clearpage
  \if@twoside%
    \ifodd\c@page\else
      \hbox{}%
      %\vspace*{\fill}
      %\begin{center}
      %  This page intentionally contains only this sentence.
      %\end{center}
      %\vspace{\fill}
      \thispagestyle{empty}%
      \newpage%
      \if@twocolumn\hbox{}\newpage\fi%
    \fi%
  \fi%
}

% Set up the bulleted lists to use gray square bullets
\definecolor{halfgray}{gray}{0.55}% light gray
\newcommand{\bull}{\vrule height 1ex width .8ex depth -.2ex}% square bullet
\newcommand{\graybullet}{\textcolor{halfgray}{\bull}}% gray square bullet
%\setdefaultitem{\graybullet}{}{}{}% set up the four levels of bullets (leave empty to keep default)
%\newcommand{\ubuntubullet}{\smash{\raisebox{0.0ex}{\includegraphics[width=0.666em]{graphics/UbuntuCoF-grey.pdf}}}}
%\newsavebox{\ubuntubulletbox}% using a box for the bullet means the graphic file gets loaded only once -- faster compile times!
%\sbox{\ubuntubulletbox}{\smash{\raisebox{0.0ex}{\includegraphics[width=0.666em]{graphics/UbuntuCoF-grey.pdf}}}}
%\setdefaultitem{\usebox{\ubuntubulletbox}}{}{}{}% set up the four levels of bullets (leave empty to keep default)
\let\smallarrow\relax
\setdefaultitem{\smallarrow}{}{}{}% set up the four levels of bullets (leave empty to keep default)
\setdefaultleftmargin{\parindent}{\parindent}{\parindent}{}{}{}% left margins of lists (leave empty to keep default)


% Set spacing of lists
\RequirePackage{enumitem}
\setlist{noitemsep}% removes vertical spacing between list items


% Adjust the float parameters so things are a bit more compact
\setcounter{topnumber}{1}
\setcounter{bottomnumber}{1}
\setcounter{totalnumber}{4}
\renewcommand{\topfraction}{0.900}
\renewcommand{\bottomfraction}{0.900}
\renewcommand{\textfraction}{0.050}
\renewcommand{\floatpagefraction}{0.900}

% Disallow orphans and widows
\AtBeginDocument{%
  \widowpenalty=10000%
  \clubpenalty=10000%
  \raggedbottom%
}%

%
% Define useful macros
%

\newcommand{\notecallout}[2][Pastaba]{%
  \marginnote{\textbf{#1:} #2}
}


% An environment for displaying terminal output
\newenvironment{terminal}{%
  \begin{list}{}{%
    \setlength{\itemindent}{0pt}%
    \setlength{\labelwidth}{0pt}%
    \setlength{\labelsep}{0pt}%
    \setlength{\leftmargin}{12pt}%
    \setlength{\rightmargin}{12pt}%
    \setlength{\listparindent}{0pt}%
    \setlength{\topsep}{0.5\baselineskip}%
    \setlength{\partopsep}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\itemsep}{0pt}%
  }%
    \small\ttfamily\obeylines%
    \item\relax
}{%
  \end{list}%
}

% An environment to set the list of credits (names) in three columns.
\newenvironment{credits}[1][]{%
  \begin{multicols}{3}[#1]%
    \parskip0pt%
    \parindent0pt%
    \let\item\par%
    \small%
}{%
  \end{multicols}%
}

% Macros to distinguish prompts and user input from program output in terminal displays
\newcommand{\prompt}{\texttt{\$}~}
\newcommand{\rootprompt}{\texttt{\#}~}
%\newcommand{\userinput}[1]{{\ttfamily\textcolor{AccentDeepRed}{#1}}}% FIXME we'll adjust this formatting later -- red for easy editing at the moment
\newcommand{\userinput}[1]{{\ttfamily\bfseries{#1}}}% FIXME we'll adjust this formatting later -- red for easy editing at the moment
\newcommand{\code}[1]{{\ttfamily#1}}

% Icons for advanced and warning notices
\newsavebox{\advancedicon}\savebox{\advancedicon}[0.25in][c]{\includegraphics[width=0.25in]{graphics/advanced.pdf}}
\newsavebox{\warningicon}\savebox{\warningicon}[0.25in][c]{\includegraphics[width=0.25in]{graphics/warning.pdf}}

% Macro for advanced usage notes
\newcommand{\advanced}[1]{%
  \smallskip%
  \begin{center}
  \noindent%
  \hspace{\parindent}%
  \begin{minipage}[t]{0.25in}%
    \centering\usebox\advancedicon%
  \end{minipage}%
  \hfill%
  \begin{minipage}[t]{\linewidth-0.30in}%
    \vspace{-\baselineskip}\small\em#1%
  \end{minipage}%
  \hspace{\parindent}%
  \end{center}
  \smallskip\par%
}

% Macro for warning notes
\newcommand{\warning}[1]{%
  \smallskip%
  \begin{center}
  \noindent%
  \hspace{\parindent}%
  \begin{minipage}[t]{0.25in}%
    \centering\usebox\warningicon%
  \end{minipage}%
  \hfill%
  \begin{minipage}[t]{\linewidth-0.30in}%
    \vspace{-\baselineskip}\small\em#1%
  \end{minipage}%
  \hspace{\parindent}%
  \end{center}
  \smallskip\par%
}


% Macro for typesetting menu selection sequences.
% \nav{Menu \then Submenu \then Subsubmenu} would generate text looking like
% ``Menu --> Submenu --> Subsubmenu''.
%\newcommand{\smallarrow}{\raisebox{0.333ex}{\scalebox{0.5}{\ding{228}}}}
\newcommand{\smallarrow}{{\normalfontlatin ‣}}%
%\newcommand{\smallarrow}{\raisebox{0.250ex}{\scalebox{0.5}{\ding{228}}}}

\def\then{\unskip\,\smallarrow\,\allowbreak\ignorespaces}%

\newcommand{\menu}[1]{%
  \begingroup%
    %\def\then{\unskip\ensuremath{\,\rightarrow\,}\ignorespaces}%
    %\def\then{\unskip\,\smallarrow\,\allowbreak\ignorespaces}%
    \textbf{#1}%
  \endgroup%
}

% Macro to format application names and index them
\newcommand{\applicationsheadword}{applications}
\newcommand{\application}[2][]{%
  #2%
  \ifthenelse{\isempty{#1}}{%
    \protect\index{#2}%\protect\index{\applicationsheadword!#2}%
  }{%
    \protect\index{#1}%\protect\index{\applicationsheadword!#1}%
  }%
}

% Macro to format command line programs and index them
\newcommand{\commandlineappheadword}{command line}
\newcommand{\commandlineapp}[2][]{%
  {\ttfamily #2}%
  \ifthenelse{\isempty{#1}}{%
    \protect\index{#2@\texttt{#2}}%\protect\index{\commandlineappheadword!#2}%
  }{%
    \protect\index{#1@\texttt{#1}}%\protect\index{\commandlineappheadword!#1}%
  }%
}

% Add an entry to the index and the main text
\newcommand{\Index}[2][]{%
  #2%
  \ifthenelse{\isempty{#1}}{%
    \protect\index{#2}%
  }{%
    \protect\index{#1}%
  }%
}

% Macro to simplify linking to chapters
\newcommand{\chaplink}[1]{%
  % not using \autoref here because I don't want to fix the case of \chapterautorefname for individual languages --godbyk
  \IfBeforeSubStringEmpty{ch:}{#1}{\hyperref[#1]{\@chapapp~}\ref{#1}\hyperref[#1]{: }\nameref{#1}}{\hyperref[ch:#1]{\@chapapp~}\ref{ch:#1}\hyperref[ch:#1]{: }\nameref{ch:#1}}%
}

% Macro to simplify linking to sections
\newcommand{\seclink}[1]{%
  %\IfBeforeSubStringEmpty{sec:}{#1}{\autoref{#1}\hyperref[#1]{: }\nameref{#1}}{\autoref{sec:#1}\hyperref[sec:#1]{: }\nameref{sec:#1}}%
  \IfBeforeSubStringEmpty{sec:}{#1}{\nameref{#1}}{\nameref{sec:#1}}%
}

% Macros to format UI elements
\newcommand{\button}[1]{\textbf{#1}}
\newcommand{\tab}[1]{\textbf{#1}}
\newcommand{\dropdown}[1]{\textbf{#1}}
\newcommand{\checkbox}[1]{\textbf{#1}}
\newcommand{\window}[1]{{„#1“}}
\newcommand{\keystroke}[1]{\texttt{#1}}
\newcommand{\radiobutton}[1]{\textbf{#1}}
\newcommand{\textfield}[1]{\textbf{#1}}

% Aliases to keep things working smoothly
%\let\nav\menu
%\let\menuitem\menu
\newcommand{\nav}[1]{\ClassError{ubuntu-manual}{The \string\nav\space command is obsolete.\MessageBreak Use the \string\menu\space command instead.}{Just replace \string\nav\space with \string\menu\space and you'll be set!}}
\newcommand{\menuitem}[1]{\ClassError{ubuntu-manual}{The \string\menuitem\space command is obsolete.\MessageBreak Use the \string\menu\space command instead.}{Just replace \string\menuitem\space with \string\menu\space and you'll be set!}}

% Screenshot placeholder
\setlength{\fboxsep}{0pt}
\newcommand*{\screenshotslog}{screenshots.log}
\newwrite\screenshots
\newcommand{\screenshotTODO}[1]{%
  \immediate\write\screenshots{Chapter \thechapter, page \thepage: #1}%
  \par\noindent%
  \begin{figure}
    \fbox{\parbox[c][0.75\linewidth][c]{\linewidth}{\begin{center}\sffamily\bfseries\color{important} M~I~S~S~I~N~G~~~S~C~R~E~E~N~S~H~O~T\par\medskip\footnotesize\normalcolor#1\end{center}}}
    \caption{#1}
  \end{figure}%
  \par%
}
\AtBeginDocument{\immediate\openout\screenshots=\screenshotslog}% open the screenshots.log file
\AtEndDocument{\immediate\closeout\screenshots}% close the screenshots.log file

\ifthenelse{\boolean{@ubuntu@debug}}{\listfiles}{}

% Command for handling translated licenses
\newcommand{\LoadLicenseFile}{%
  \IfFileExists{backmatter/license-\@ubuntu@language@code.tex}{\input{backmatter/license-\@ubuntu@language@code.tex}\ClassInfo{ubuntu-manual}{Found backmatter/license-\@ubuntu@language@code.tex}}{\input{backmatter/license-en.tex}\ClassInfo{ubuntu-manual}{Didn't find backmatter/license-\@ubuntu@language@code.tex, using backmatter/license-en.tex instead.}}%
}

% The screenshot scale
\newlength{\screenshotscale}
\setlength{\screenshotscale}{1.0pt}

% Measures the width of a graphic and scales it to the max figure* width.
\newlength{\maxscreenshotwidth}%
\newcommand{\setmaxscreenshot}[1]{%
  \TufteRecalculate% to make sure \@tufte@fullwidth has been calculated
  \settowidth{\maxscreenshotwidth}{\includegraphics{#1}}%
  \gsetlength{\screenshotscale}{1.0pt * \ratio{\@tufte@fullwidth}{\maxscreenshotwidth}}%
}

% Define the screenshot command
%   #1 optional float position specifier
%   #2 screenshot filename (example: xyzzy.png)
%   #3 label (example: xyzzy)
%   #4 caption
\newsavebox{\screenshotgraphic}
\newcommand{\screenshot}[4][htbp!]{%
  \ifvmode\else\unskip\fi%
  \IfFileExists{screenshots/\@ubuntu@language@code/#2}{%
    \savebox{\screenshotgraphic}{\includegraphics[scale=\strip@pt\screenshotscale]{screenshots/\@ubuntu@language@code/#2}}%
    \ifthenelse{\wd\screenshotgraphic>\textwidth}{%
      \begin{figure*}[#1]%
        \begin{center}%
          \usebox{\screenshotgraphic}%
        \end{center}%
        \caption{#4}%
        \label{#3}%
      \end{figure*}%
    }{%
      \begin{figure}[#1]%
        \begin{center}%
          \usebox{\screenshotgraphic}%
        \end{center}%
        \caption{#4}%
        \label{#3}%
      \end{figure}%
    }%
  }{%
    \begin{figure}[#1]%
      \fbox{\parbox[c][0.75\linewidth][c]{\linewidth}{\begin{center}\sffamily\bfseries\color{important} M~I~S~S~I~N~G~~~S~C~R~E~E~N~S~H~O~T\par\medskip\footnotesize\normalcolor#3\par\medskip The file \texttt{screenshots/\@ubuntu@language@code/#2} does not exist!\end{center}}}%
      \caption{#4}%
      \label{#3}%
    \end{figure}%
  }%
  \@esphack%
  \ignorespaces%
}

\newcommand{\gltodo}[1]{%
  \todo[color=LightSkyBlue]{Add #1 to the glossary.}%
}

\newcommand{\hairsp}{\hspace{1pt}}% hair space
\newcommand{\hquad}{\hskip0.5em\relax}% half quad space
\newcommand{\ie}{\textit{i.\kern0.5pt e.}\xspace}
\newcommand{\eg}{\textit{e.\kern0.5pt g.}\xspace}

% Formats placeholder argument as <placeholder> (in italics)
\DeclareRobustCommand\variable[1]{%
     \ensuremath\langle
     \ifmmode \expandafter \nfss@text \fi
     {%
      \itshape
      \edef\meta@hyphen@restore
        {\hyphenchar\the\font\the\hyphenchar\font}%
      \hyphenchar\font\m@ne
      \language\l@nohyphenation
      #1\/%
      \meta@hyphen@restore
     }\ensuremath\rangle
}

% Revision information that's displayed on the copyright page
\newcommand{\revisionnumbercaption}{Revision number}
\newcommand{\revisiondatecaption}{Revision date}
\newcommand{\revinfo}[2]{% #1 is the revision number, #2 is the revision date
  \revisionnumbercaption: #1%
  \qquad%
  \revisiondatecaption: #2%
}

% PDF bookmark names
\newcommand{\colophoncaption}{Kolofonas}
\newcommand{\titlepagecaption}{Antraštinis puslapis}

% URL for printed book (appears on copyright page)
\newcommand{\printurl}{http://ubuntu-manual.org/buy/gswu1004e2/\polang}


%
% Language-specific overrides
%

% Load language-specific settings
\IfFileExists{um-\@ubuntu@language.clo}{\input{um-\@ubuntu@language.clo}}{}%



%
% Metadata for po4a
%

% po4a: environment lstlisting
% po4a: environment comment
% po4a: command *todo {}
% po4a: environment terminal
% po4a: environment credits

% Document headings
% po4a: command title {_}
% po4a: command author {_}
% po4a: command part {_}

% From Tufte-LaTeX
% po4a: environment fullwidth

%
% All done!
%

\endinput

