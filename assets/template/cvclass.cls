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
\usetikzlibrary{decorations.pathmorphing} % Pour soulignement "chalk" sur les titres de section
\usetikzlibrary{fadings} % Pour effet "focus / depth-of-field" derrière la photo
\usetikzlibrary{shadows.blur} % Pour glow/blur réel autour du cadre photo
% Fade radial doux : opaque au centre, transparent sur les bords
\tikzfading[name=ball fade, inner color=transparent!0, outer color=transparent!100]

% Assurez-vous que les tailles de police sont définies avant enumitem
\RequirePackage{fontspec}
\RequirePackage{enumitem}

\usetikzlibrary{calc}

\graphicspath{{assets/img/}}
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
  % Le nom de base doit désigner un FICHIER réel du dossier, pas la famille.
  % Avec « Lekton », toute fonte non déclarée explicitement (le gras italique,
  % par exemple) fait chercher « Lekton.ttf », qui n'existe pas. Sur une
  % machine où Lekton est installée, fontconfig rattrape par le nom de famille
  % et on ne voit rien ; dans un conteneur vierge, la compilation s'arrête.
  % Pointer sur Lekton-Regular rend le dépôt compilable sans rien installer.
  \newfontfamily{\Lekton}[
  Path=assets/fonts/,
  Extension = .ttf,
  Ligatures = TeX,
  UprightFont = Lekton-Regular,
  BoldFont = Lekton-Bold,
  ItalicFont = Lekton-Italic,
  BoldItalicFont = Lekton-Italic,
  ]{Lekton-Regular}
  \newfontfamily{\Poppins}[
    Path=assets/fonts/,
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
  ]{Poppins-Light}
  \newfontfamily{\RobotoMono}[
  NFSSFamily=RobotoMono,
  Path=assets/fonts/,
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
  ]{RobotoMono-Regular}
  \renewcommand{\familydefault}{RobotoMono}

  \newfontface\lekton{Lekton-Regular.ttf}[Path=assets/fonts/]
  \newfontface\lektonI{Lekton-Italic.ttf}[Path=assets/fonts/]
  \newfontface\lektonB{Lekton-Bold.ttf}[Path=assets/fonts/]
  \newfontface\robotoMonoL{RobotoMono-Light.ttf}[Path=assets/fonts/]
  \newfontface\robotoMono{RobotoMono-Regular.ttf}[Path=assets/fonts/]
  \newfontface\poppinsL{Poppins-Light.ttf}[Path=assets/fonts/]
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
% -------------------- Section title (style "chalkboard" : titre + soulignement craie irrégulier)
\newcommand{\fancysectiontitle}[1]{%
  \begin{tikzpicture}[baseline=(title.base)]
    \node[
      inner xsep=0pt,
      inner ysep=2pt,
      text=TitleRed,
      font=\Lekton\bfseries\fontsize{13pt}{15pt}\selectfont
    ] (title) {\strut#1};
    % Soulignement irrégulier façon craie
    \draw[TitleRed, line width=1.4pt, decorate,
          decoration={random steps, segment length=3pt, amplitude=0.5pt}]
      ([yshift=-1pt]title.south west) -- ([yshift=-1pt]title.south east);
  \end{tikzpicture}%
}


\titleformat{\section}
{\normalfont}
{}
{0pt}
{\fancysectiontitle} %

% Spacing autour des titres de section : grand espace AVANT (respiration / séparation
% de la section précédente), petit espace APRÈS (titre proche de son propre contenu)
\titlespacing*{\section}
  {0pt}        % indentation à gauche
  {1.3cm}      % espace AVANT le titre
  {0.05cm}     % espace APRÈS le titre

\titleformat{\subsection}
{\normalfont\bfseries\fontsize{9pt}{11pt}\selectfont\color{headerRed!75!black}}  % style + accent rouge atténué
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

  % --- Glow flou doux (vrai blur via tikz shadows.blur) en TOUT PREMIER,
  %     avant tous les fills headerRed. Comme ça les rectangles + triangles
  %     headerRed couvrent uniformément l'ombre dans toute la zone red,
  %     et le seul endroit où le blur reste visible est sur les bords du
  %     cadre photo (zone qui n'est pas couverte par les fills red).
  \node[
    anchor=north east,
    xshift=-\margin*1.5,
    yshift=-\margin*2,
    inner sep=0pt, outer sep=0pt,
    minimum width=\squareSize,
    minimum height=\squareSize,
    rounded corners=5pt,
    fill=none,
    draw=none,
    blur shadow={shadow blur steps=12, shadow blur radius=12pt, shadow xshift=0pt, shadow yshift=0pt, shadow opacity=55}
  ] at (current page.north east) {};

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
    % \begin{scope}
    %   \clip[rounded corners=5pt]
    %     ([xshift=-\margin*2, yshift=-\margin*2]current page.north east)
    %     rectangle ++(-\squareSize, -\squareSize);
    %   \node[anchor=north east, xshift=-\margin*2, yshift=-\margin*2] at (current page.north east) {
    %     \includegraphics[width=\squareSize]{\profilepicture}
    %   };
    % \end{scope}
     \begin{scope}
      \clip[rounded corners=5pt]
      ([xshift=-\margin*1.5, yshift=-\margin*2]current page.north east)
      rectangle ++(-\squareSize, -\squareSize);
      \node[anchor=north east, xshift=-\margin*1.5, yshift=-\margin*2] at (current page.north east) {
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
    % \fontspec{Lekton} appelait la police par NOM DE FAMILLE, sans Path :
    % ça court-circuite la déclaration ci-dessus et ne marche que si Lekton
    % est installée sur la machine. \Lekton utilise les fichiers du dépôt.
    ] at (current page.north west) {\Lekton\textbf{\cvname}};

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
            % \includegraphics[height=0.5cm]{location.png} & 
            % \hspace{-0.3cm}\raisebox{0.1cm}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\location }}}
            \includegraphics[height=0.5cm]{link.png} & 
          \hspace{-0.3cm}\raisebox{0.1cm}{\href{\website}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\website }}}}
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
        \hspace{-0.3cm}\raisebox{0.1cm}{\href{\linkedin}{\poppinsL{\fontsize{9}{12}\selectfont\textcolor{white}{\linkedinText }}}}
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
    % Rectangle gris arrondi avec bordure (hauteur d'origine, étendu vers la droite jusqu'à la marge)
    \draw[gray, line width=2.5pt, rounded corners=10pt]
      ([xshift=\margin*2, yshift=-\headerHeight-(\margin/2)]current page.north west)
      rectangle
      ([xshift=-\margin*2, yshift=-\headerHeight-\margin*2.5]current page.north east);
    \fill[white, rounded corners=10pt]
      ([xshift=\margin*2, yshift=-\headerHeight-(\margin/2)]current page.north west)
      rectangle
      ([xshift=-\margin*2, yshift=-\headerHeight-\margin*2.5]current page.north east);
      % Loupe à gauche
      \node[anchor=west, xshift=\margin+0.6cm, yshift=-\headerHeight-(\margin)-1.9mm, opacity=0.5] at (current page.north west) {
        \includegraphics[height=0.5cm]{glass.png}
      };
      \node[anchor=west, xshift=\margin+1.2cm, yshift=-\headerHeight-(\margin)-2.1mm, text=black, font=\fontsize{9}{9}\selectfont] at (current page.north west) {
        \parbox{18.5cm}{\robotoMonoL{\search}}
      };
    \end{tikzpicture}
}

% -------------------- Content shape
\newcommand{\content}{
\begin{tikzpicture}[remember picture,overlay]

% White rectangle (opacity réduite pour laisser apparaître subtilement le fond chalkboard)
\fill[white, opacity=0.9]
    ([xshift=\margin, yshift=-\topContent]current page.north west)
    rectangle
    ([xshift=-\margin, yshift=-\topContent-\contentHeight]current page.north east);

\end{tikzpicture}
}

% Environnement area-left
% Décalage vertical appliqué uniquement au contenu textuel des colonnes (pas aux
% rectangles de fond), pour laisser de la place sous la searchbar sans déplacer
% le calque blanc.
\def\columnTopOffset{0.5cm}

\NewEnviron{area-left}{%
  \begin{tikzpicture}[remember picture, overlay]
    \fill[white, opacity=0]
        ([xshift=(\margin*2), yshift=-\textTop]current page.north west)
        rectangle
        ([xshift=-(\margin*2), yshift=-\textHeight]current page.north east);
    \node[anchor=north west, xshift=(\margin*2), yshift=-\textTop-\columnTopOffset, text=black, font=\normalsize] at (current page.north west) {%
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
    \node[anchor=north west, xshift=\dimexpr (\margin*4) + \blockWidth\relax, yshift=-\textTop-\columnTopOffset, text=black, font=\normalsize] at (current page.north west) {%
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
    \node[anchor=north west, xshift=0, yshift=-1.75cm] at (0, 0) {\arrowup{4.}};
  \end{tikzpicture}
  \hspace*{0.05cm}
  \begin{minipage}{(\blockWidth-0.05cm)}%
   \BODY
  \end{minipage}%
}

\NewEnviron{dendleftarrowbox}{
  \begin{tikzpicture}[overlay, remember picture]
    \node[anchor=north west, xshift=0, yshift=-0.3cm] at (0, 0) {\wtffsdyfjfgd{1.}};
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
