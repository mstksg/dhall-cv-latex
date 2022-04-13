let types = (../prelude.dhall).cv.types

let latextypes = ../types.dhall

let text = (../prelude.dhall).text

let optional = (../prelude.dhall).optional

let dDouble =
      λ(d : Double) →
      λ(x : Optional Double) →
        optional.fold Double x Text Double/show (Double/show d)

let tOptionWith =
      λ(a : Type) →
      λ(pre : Text) →
      λ(post : Text) →
      λ(process : a → Text) →
      λ(x : Optional a) →
        optional.fold a x Text (λ(o : a) → pre ++ process o ++ post) ""

let tOption =
      λ(pre : Text) →
      λ(post : Text) →
        tOptionWith Text pre post (λ(x : Text) → x)

let assembleSections = text.concatMapSep "\n\n" types.CVSection ./section.dhall

in  λ(cv : latextypes.CVDocumentWithConfig) →
      ''
      \documentclass[10pt]{moderncv}

      % moderncv themes
      \moderncvtheme${tOptionWith
                        latextypes.CVTheme
                        "["
                        "]"
                        latextypes.showTheme
                        cv.theme}{classic}

      % character encoding
      \usepackage[utf8]{inputenc}                   % replace by the encoding you are using

      % adjust the page margins
      \usepackage[scale=${dDouble 0.8 cv.margin}]{geometry}
      %\setlength{\hintscolumnwidth}{3cm}						% if you want to change the width of the column with the dates
      %\AtBeginDocument{\setlength{\maketitlenamewidth}{6cm}}  % only for the classic theme, if you want to change the width of your name placeholder (to leave more space for your address details
      %\AtBeginDocument{\recomputelengths}                     % required when changes are made to page layout lengths

      % Hyperlinks
      %\usepackage{hyperref}								% to use hyperlinks
      %\definecolor{linkcolour}{rgb}{0,0.2,0.6}			% hyperlinks setup
      %\hypersetup{colorlinks,breaklinks,urlcolor=linkcolour, linkcolor=linkcolour}

      % personal data
      \firstname{${cv.info.firstName}}
      \familyname{${cv.info.lastName}${tOption ", " "" cv.info.title}}
      ${tOption "\\title{" "}" cv.subtitle}
      \address{${cv.info.street}}{${cv.info.address}} ${tOption
                                                          "{"
                                                          "}"
                                                          cv.info.country}      % optional, remove the line if not wanted
      %\mobile{+30 698 4385057}                    % optional, remove the line if not wanted
      \phone{${cv.info.phone}}                      % optional, remove the line if not wanted
      %\fax{fax (optional)}                          % optional, remove the line if not wanted
      \email{${cv.info.email}}                      % optional, remove the line if not wanted
      %\email{\href{mailto:s.dakourou@gmail.com}{s.dakourou@gmail.com}}                      % optional, remove the line if not wanted
      \homepage{${cv.info.website}}%{LinkedIn Profile}}                % optional, remove the line if not wanted
      %\extrainfo{additional information (optional)} % optional, remove the line if not wanted
      %\photo[64pt][0.4pt]{picture}                         % '64pt' is the height the picture must be resized to, 0.4pt is the thickness of the frame around it (put it to 0pt for no frame) and 'picture' is the name of the picture file; optional, remove the line if not wanted
      %\quote{Some quote (optional)}                 % optional, remove the line if not wanted

      % to show numerical labels in the bibliography; only useful if you make citations in your resume
      %\makeatletter
      %\renewcommand*{\bibliographyitemlabel}{\@biblabel{\arabic{enumiv}}}
      %\makeatother

      % bibliography with mutiple entries
      %\usepackage{multibib}
      %\newcites{book,misc}{{Books},{Others}}

      \nopagenumbers{}                             % uncomment to suppress automatic page numbering for CVs longer than one page
      %----------------------------------------------------------------------------------
      %            content
      %----------------------------------------------------------------------------------
      \begin{document}
      \maketitle

      ${tOptionWith Double "\\vspace{" "em}" Double/show cv.headerSpacing}

      ${assembleSections cv.sections}

      \end{document}
      ''
