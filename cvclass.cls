\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cvclass}[2023/10/01 CV Class]

% Définir la taille de papier par défaut
\LoadClass[8pt]{extarticle}

% -------------------- Packages
\RequirePackage[
  ignoreheadfoot,
  top=1.5cm,
  bottom=1.5cm,
  left=1.5cm,
  right=1.5cm,
  footskip=1.0cm,
]{geometry}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[
  pdftitle={Mélissa Colin's CV},
  pdfauthor={Mélissa Colin},
  pdfcreator={Mélissa Colin},
  colorlinks=true,
  urlcolor=primaryColor
]{hyperref}
\RequirePackage{iftex}
\RequirePackage{graphicx}
\RequirePackage{environ}
\RequirePackage{tikz}
\RequirePackage{transparent}
\RequirePackage{charter}
\RequirePackage[pages=all]{background}
\RequirePackage{ragged2e}
\RequirePackage{titlesec}
\RequirePackage{etoolbox}
\RequirePackage{pdfcomment}
\RequirePackage{fontawesome5}
\usetikzlibrary{shapes.geometric} % Load the library for geometric shapes

% Assurez-vous que les tailles de police sont définies avant enumitem
\RequirePackage{fontspec}
\RequirePackage{enumitem}

\usetikzlibrary{calc}

\graphicspath{{img/}}
\pagenumbering{gobble}

% -------------------- For CV parser
% Ensure that generated pdf is machine readable/ATS parsable:
\hypersetup{
  pdfauthor={Mélissa Colin},
  pdftitle={Mélissa Colin's CV},
  pdfsubject={Curriculum Vitae},
  pdfkeywords={CV, Mélissa Colin, ENSEIRB-MATMECA, Informatique, Intelligence Artificielle, Ingénieur, Ingénieure, Computer Vision, Machine Learning, Data Science},
  pdfcreator={pdflatex},
  pdfproducer={LaTeX with hyperref}
}

% -------------------- Font
\ifxetex
  \newfontfamily{\Lekton}[
  Path=./fonts/,
  Extension = .ttf,
  Ligatures = TeX,
  UprightFont = Lekton-Regular,
  BoldFont = Lekton-Bold,
  ItalicFont = Lekton-Italic,
  ]{Lekton}
  \newfontfamily{\Poppins}[
    Path=./fonts/,
    Extension = .ttf,
    Ligatures = TeX,
    UprightFont = Poppins-Light,
    BoldFont = Poppins-Bold,
    ItalicFont = Poppins-Italic,
    BoldItalicFont = Poppins-BoldItalic,
    FontFace={xl}{n}{Poppins-ExtraLight},
    FontFace={xl}{it}{Poppins-ExtraLightItalic},
    FontFace={l}{n}{Poppins-Light},
    FontFace={l}{it}{Poppins-LightItalic},
    FontFace={mb}{n}{Poppins-Medium},
    FontFace={mb}{it}{Poppins-MediumItalic},
  ]{Poppins}
  \newfontfamily{\RobotoMono}[
  NFSSFamily=RobotoMono,
  Path=./fonts/,
  Extension = .ttf,
  Ligatures = TeX,
  UprightFont = RobotoMono-Regular,
  BoldFont = RobotoMono-Bold,
  ItalicFont = RobotoMono-Italic,
  BoldItalicFont = RobotoMono-BoldItalic,
  FontFace={xl}{n}{RobotoMono-ExtraLight},
  FontFace={xl}{it}{RobotoMono-ExtraLightItalic},
  FontFace={l}{n}{RobotoMono-Light},
  FontFace={l}{it}{RobotoMono-LightItalic},
  FontFace={mb}{n}{RobotoMono-Medium},
  FontFace={mb}{it}{RobotoMono-MediumItalic},
  ]{RobotoMono}
  \renewcommand{\familydefault}{RobotoMono}

  \newfontface\lekton{Lekton-Regular.ttf}[Path=./fonts/]
  \newfontface\lektonI{Lekton-Italic.ttf}[Path=./fonts/]
  \newfontface\lektonB{Lekton-Bold.ttf}[Path=./fonts/]
  \newfontface\robotoMonoL{RobotoMono-Light.ttf}[Path=./fonts/]
  \newfontface\robotoMono{RobotoMono-Regular.ttf}[Path=./fonts/]
  \newfontface\poppinsL{Poppins-Light.ttf}[Path=./fonts/]
\fi

\newcommand\textulf[1]{{\NHLight\bfseries#1}}



% Configuration de l'environnement itemize pour utiliser des tirets et réduire les espaces
\setlist[itemize,1]{label=-, left=0.1cm, itemsep=0pt, topsep=0pt, parsep=0pt, partopsep=0pt}

% -------------------- Background
\backgroundsetup{
  scale=1,
  angle=0,
  opacity=1,
  contents={\includegraphics[width=\paperwidth,height=\paperheight]{\background}}
}
% -------------------- Section title
\newcommand{\fancysectiontitle}[1]{%
  
  \vspace{\margin/2}%
  \begin{tikzpicture}[baseline=(title.base)]
    \node[
      fill=black,
      rounded corners=4pt,
      inner xsep=6pt,  % réduit horizontalement
      inner ysep=3pt,  % réduit verticalement
      text=TitleRed,
      font=\Lekton\bfseries\fontsize{12.6pt}{15pt}\selectfont
    ] (title) {\strut#1};
  \end{tikzpicture}%
}


\titleformat{\section}
{\normalfont} 
{}          
{0pt}       
{\fancysectiontitle} %

\titleformat{\subsection}
{\normalfont\bfseries\fontsize{9pt}{11pt}\selectfont}  % style
{}        % pas de numéro
{0pt}     % espacement entre label et texte (inutile ici)
{}  % espace avant le contenu de la sous-section

\titlespacing*{\subsection}
  {0pt}     % indentation à gauche
  {\spaceSections}   % espace AVANT la sous-section
  {0cm}   % espace APRÈS la sous-section

\newcommand{\job}[2]{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} p{0.65\textwidth}r@{}}
    \textcolor{jobs}{\fontsize{9}{10}\selectfont #1} & \textcolor{jobs}{\fontsize{8.5}{10}\selectfont #2}\\
  \end{tabular*}%
  \vspace{\spaceSections}%
}

% -------------------- Header shape
\newcommand{\header}{
  \begin{tikzpicture}[remember picture,overlay]


  % Rectangle rouge
  \fill[headerRed, opacity=0.9]
  ([xshift=\margin, yshift=-\margin]current page.north west)
  rectangle
  ([xshift=(-\margin*2-\squareSize+0.1mm), yshift=-\margin-\headerHeight]current page.north east);
  
  \fill[headerRed, opacity=0.9]
  ([xshift=(\paperwidth-\margin*2-\squareSize), yshift=-\margin]current page.north west)
  rectangle
  ([xshift=0.1mm-\margin*2, yshift=-\margin*2]current page.north east);

  \fill[headerRed, opacity=0.9]
  ([xshift=(\paperwidth-\margin*2-\squareSize), yshift=-(\margin*2+\squareSize)]current page.north west)
  rectangle
  ([xshift=-\margin, yshift=0.1mm-\margin-\headerHeight]current page.north east);

  \fill[headerRed, opacity=0.9]
  ([xshift=(\paperwidth-\margin*2), yshift=-\margin]current page.north west)
  rectangle
  ([xshift=-\margin-0.1mm, yshift=-0.1mm-\headerHeight]current page.north east);

  % Triangles dans chaque coin du carré vide
  % Coin bas droite
   \fill[headerRed, opacity=0.9] 
    ([xshift=0.1mm+(-\margin*2), yshift=-0.1mm-(\margin*2+\squareSize)]current page.north east)
    -- ([xshift=0.1mm+(-\margin*2-\triangleSize), yshift=-0.1mm-(\margin*2+\squareSize)]current page.north east)
    -- ([xshift=0.1mm+(-\margin*2), yshift=-0.1mm-(\margin*2+\squareSize)+\triangleSize]current page.north east)
    -- cycle;

  % Coin haut-droit
  \fill[headerRed, opacity=0.9] 
    ([xshift=0.1mm+(\paperwidth-\margin*2), yshift=0.1mm-\margin*2]current page.north west)
    -- ([xshift=0.1mm+(\paperwidth-\margin*2-\triangleSize), yshift=0.1mm-\margin*2]current page.north west)
    -- ([xshift=0.1mm+(\paperwidth-\margin*2), yshift=0.1mm-\margin*2-\triangleSize]current page.north west)
    -- cycle;

  % Coin bas-gauche
  \fill[headerRed, opacity=0.9] 
    ([xshift=(\paperwidth-\margin*2-\squareSize), yshift=-0.1mm-(\margin+\squareSize+\triangleSize)]current page.north west)
    -- ([xshift=(\paperwidth-\margin*2-\squareSize)+\triangleSize, yshift=-0.1mm-(\margin+\squareSize+\triangleSize)]current page.north west)
    -- ([xshift=(\paperwidth-\margin*2-\squareSize), yshift=-0.1mm-(\margin+\squareSize)]current page.north west)
    -- cycle;

  % Coin haut gauche
  \fill[headerRed, opacity=0.9] 
    ([xshift=(\paperwidth-\margin*2-\squareSize), yshift=0.1mm-(\margin*2)]current page.north west)
    -- ([xshift=(\paperwidth-\margin*2+\triangleSize-\squareSize), yshift=0.1mm-(\margin*2)]current page.north west)
    -- ([xshift=(\paperwidth-\margin*2-\squareSize), yshift=0.1mm-(\margin*2+\triangleSize)]current page.north west)
    -- cycle;


    % Image portrait
    \begin{scope}
      \clip[rounded corners=5pt]
        ([xshift=-\margin*2, yshift=-\margin*2]current page.north east) 
        rectangle ++(-\squareSize, -\squareSize);
      \node[anchor=north east, xshift=-\margin*2, yshift=-\margin*2] at (current page.north east) {
        \includegraphics[width=\squareSize]{\profilepicture}
      };
    \end{scope}
    

    % Nom
    \node[
      anchor=north west,
      xshift=\margin + 0.5cm,
      yshift=-\margin - 0.5cm,
      text=white,
      font=\fontsize{27}{48}\selectfont
    ] at (current page.north west) {\fontspec{Lekton}\textbf{\cvname}};

    % Description
    \node[
      anchor=north west,
      xshift=\margin + 0.5cm,
      yshift=-\margin - 1.5cm,
      text=white,
      font=\fontsize{13}{16}\selectfont,
      align=left
    ] at (current page.north west) {\parbox{(\paperwidth-\squareSize-\margin*5)}{\robotoMonoL{\cvdesc}}};

    % Ligne 1 rangé 1
    \node[anchor=north west, xshift=\margin*2, yshift=-\margin - 2.9cm, text=white] at (current page.north west) {
    \begin{tabular}{@{}lll@{}}
        \includegraphics[height=0.5cm]{github.png} & 
        \hspace{-0.3cm}\raisebox{0.1cm}{\href{\github}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\github }}}}
    \end{tabular}
    };
    % Texte invisible superposé au logo pour les ATS
    \node[anchor=north west, xshift=\margin*2, yshift=-\margin - 2.9cm -\margin/2.5, text opacity=0] at (current page.north west) {
      \poppinsL{\fontsize{9}{12}\selectfont \space GitHub:}
    };

    % Ligne 1 rangé 2
    \node[anchor=north west, xshift=\margin*2 + \linkSize, yshift=-\margin - 2.9cm, text=white] at (current page.north west) {
    \begin{tabular}{@{}lll@{}}
        \includegraphics[height=0.5cm]{medium.png} & 
        \hspace{-0.3cm}\raisebox{0.1cm}{\href{\medium}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\medium }}}}
    \end{tabular}
    };
    % Texte invisible superposé au logo pour les ATS
    \node[anchor=north west, xshift=\margin*2 + \linkSize, yshift=-\margin - 2.9cm -\margin/2.5, text opacity=0] at (current page.north west) {
      \poppinsL{\fontsize{9}{12}\selectfont \space Medium:}
    };

    % Ligne 1 rangé 3
    \node[anchor=north west, xshift=\margin*2 + \linkSize*2, yshift=-\margin - 2.9cm, text=white] at (current page.north west) {
    \begin{tabular}{@{}lll@{}}
        \includegraphics[height=0.5cm, height=0.5cm, trim=0 0.8 0 0, clip]{email.png} & 
        \hspace{-0.3cm}\raisebox{0.1cm}{\href{mailto:\email}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\email }}}}
    \end{tabular}
    };
    % Texte invisible superposé au logo pour les ATS
    \node[anchor=north west, xshift=\margin*2 + \linkSize*2, yshift=-\margin - 2.9cm -\margin/2.5, text opacity=0] at (current page.north west) {
      \poppinsL{\fontsize{9}{12}\selectfont \space Email:}
    };


    % Ligne 2 rangé 1
    \node[anchor=north west, xshift=\margin*2, yshift=-\margin - 3.8cm, text=white] at (current page.north west) {
        \begin{tabular}{@{}lll@{}}
            \includegraphics[height=0.5cm]{location.png} & 
            \hspace{-0.3cm}\raisebox{0.1cm}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\location }}}
        \end{tabular}
    };
    % Texte invisible superposé au logo pour les ATS
    \node[anchor=north west, xshift=\margin*2, yshift=-\margin - 3.8cm -\margin/2.5, text opacity=0] at (current page.north west) {
      \poppinsL{\fontsize{9}{12}\selectfont \space Lieu:}
    };

    % Ligne 2 rangé 2
    \node[anchor=north west, xshift=\margin*2 + \linkSize, yshift=-\margin - 3.8cm, text=white] at (current page.north west) {
    \begin{tabular}{@{}lll@{}}
        \includegraphics[height=0.5cm]{linkedin.png} & 
        \hspace{-0.3cm}\raisebox{0.1cm}{\href{\linkedin}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\linkedin }}}}
    \end{tabular}
    };
    % Texte invisible superposé au logo pour les ATS
    \node[anchor=north west, xshift=\margin*2 + \linkSize, yshift=-\margin - 3.8cm -\margin/2.5, text opacity=0] at (current page.north west) {
      \poppinsL{\fontsize{9}{12}\selectfont \space LinkedIn:}
    };

    % Ligne 2 rangé 3
    \node[anchor=north west, xshift=\margin*2 + \linkSize*2, yshift=-\margin - 3.8cm, text=white] at (current page.north west) {
    \begin{tabular}{@{}lll@{}}
        \includegraphics[height=0.5cm, trim=0 4 0 0, clip]{phone.png} & 
        \hspace{-0.3cm}\raisebox{0.1cm}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\phone }}}
    \end{tabular}
    };
    % Texte invisible superposé au logo pour les ATS
    \node[anchor=north west, xshift=\margin*2 + \linkSize*2, yshift=-\margin - 3.8cm -\margin/2.5, text opacity=0] at (current page.north west) {
      \poppinsL{\fontsize{9}{12}\selectfont \space Téléphone:}
    };

  \end{tikzpicture}
}

% -------------------- Search bar
\newcommand{\searchbar}{
  \begin{tikzpicture}[remember picture,overlay]
    % Rectangle gris arrondi avec bordure
    \draw[gray, line width=2.5pt, rounded corners=10pt]
      ([xshift=\margin*2, yshift=-\headerHeight-(\margin/2)]current page.north west)
      rectangle
      ([xshift=-\squareSize-\margin*2, yshift=-\headerHeight-\margin*2.5]current page.north east);
    \fill[white, rounded corners=10pt]
      ([xshift=\margin*2, yshift=-\headerHeight-(\margin/2)]current page.north west)
      rectangle
      ([xshift=-\squareSize-\margin*2, yshift=-\headerHeight-\margin*2.5]current page.north east);
      % Loupe à gauche
      \node[anchor=west, xshift=\margin+0.6cm, yshift=-\headerHeight-(\margin)-1.9mm, opacity=0.5] at (current page.north west) {
        \includegraphics[height=0.5cm]{glass.png}
      };
      \node[anchor=west, xshift=\margin+1.2cm, yshift=-\headerHeight-(\margin)-2.1mm, text=black, font=\fontsize{9}{9}\selectfont] at (current page.north west) {
        \parbox{14.4cm}{\robotoMonoL{\search}}
      };
    \end{tikzpicture}
}

% -------------------- Content shape
\newcommand{\content}{
\begin{tikzpicture}[remember picture,overlay]

% White rectangle
\fill[white, opacity=0.9]
    ([xshift=\margin, yshift=-\topContent]current page.north west)
    rectangle
    ([xshift=-\margin, yshift=-\topContent-\contentHeight]current page.north east);

\end{tikzpicture}
}

% Environnement area-left
\NewEnviron{area-left}{%
  \begin{tikzpicture}[remember picture, overlay]
    \fill[white, opacity=0]
        ([xshift=(\margin*2), yshift=-\textTop]current page.north west)
        rectangle
        ([xshift=-(\margin*2), yshift=-\textHeight]current page.north east);
    \node[anchor=north west, xshift=(\margin*2), yshift=-\textTop, text=black, font=\normalsize] at (current page.north west) {%
      \begin{minipage}{\blockWidth}%
        \BODY
      \end{minipage}%
    };
  \end{tikzpicture}
}

% Environnement area-right
\NewEnviron{area-right}{%
  \begin{tikzpicture}[remember picture, overlay]
    \fill[white, opacity=0]
        ([xshift=(\margin*2), yshift=-\textTop]current page.north west)
        rectangle
        ([xshift=-(\margin*2), yshift=-\textHeight]current page.north east);
    \node[anchor=north west, xshift=\dimexpr (\margin*4) + \blockWidth\relax, yshift=-\textTop, text=black, font=\normalsize] at (current page.north west) {%
      \begin{minipage}{\blockWidth}%
        \BODY
      \end{minipage}%
    };
  \end{tikzpicture}
}

% -------------------- Flèche vers le haut
\newcommand{\arrowup}[1]{%
  \begin{tikzpicture}[overlay, remember picture]
    \draw[->, ultra thick, color=gray] (0,0) -- (0, #1); % Flèche pointant directement vers le haut avec une épaisseur plus grande
    % \filldraw[fill=gray, draw=gray] (0, #2) circle (0.12cm); % Rond positionné à y=#2
  \end{tikzpicture}
}

\newcommand{\wtffsdyfjfgd}[1]{
  \begin{tikzpicture}[overlay, remember picture]
  \draw[-, ultra thick, color=gray] (0,0) -- (0, #1); 
\end{tikzpicture}
}

\NewEnviron{leftarrowbox}{
  \begin{tikzpicture}[overlay, remember picture]
    \node[anchor=north west, xshift=0, yshift=-1.55cm] at (0, 0) {\arrowup{3.5}};
  \end{tikzpicture}
  \hspace*{0.05cm}
  \begin{minipage}{(\blockWidth-0.05cm)}%
   \BODY
  \end{minipage}%
}

\NewEnviron{dendleftarrowbox}{
  \begin{tikzpicture}[overlay, remember picture]
    \node[anchor=north west, xshift=0, yshift=-0.35cm] at (0, 0) {\wtffsdyfjfgd{1.15}};
  \end{tikzpicture}
  \hspace*{0.05cm}
  \begin{minipage}{(\blockWidth-0.05cm)}%
   \BODY
  \end{minipage}%
}

% -------------------- ATS parser
\makeatletter
\def\@pdfcomment{%
\ifx\pdfcomment\@undefined
  \PackageWarning{pdfcomment}{%
    The pdfcomment package is not loaded.%
  }%
\else
\pdfcomment[open=true]{Nom: \cvname, Email: \email, Téléphone: \phone, Lieu: \location, LinkedIn: \linkedin, GitHub: \github, Medium: \medium}
\fi
}
