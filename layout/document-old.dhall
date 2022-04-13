let types = (../prelude.dhall).types

let latextypes = ../types.dhall

let text =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v22.0.0/Prelude/Text/package.dhall
        sha256:79b671a70ac459b799a53bbb8a383cc8b81b40421745c54bf0fb1143168cbd6f

let optional =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v22.0.0/Prelude/Optional/package.dhall
        sha256:37b84d6fe94c591d603d7b06527a2d3439ba83361e9326bc7b72517c7dc54d4e

let dDouble =
      λ(d : Double) →
      λ(x : Optional Double) →
        optional.fold Double x Text Double/show (Double/show d)

let tOption =
      λ(pre : Text) →
      λ(post : Text) →
      λ(x : Optional Text) →
        optional.fold Text x Text (λ(o : Text) → pre ++ o ++ post) ""

let assembleSections = text.concatMapSep "\n\n" types.CVSection ./section.dhall

in  λ(cfg : latextypes.CVDocumentConfig) →
    λ(cv : types.CVDocument) →
      ''
      \documentclass[10pt]{moderncv}

      % moderncv themes
      \moderncvtheme[red]{classic}                  % optional argument are 'blue' (default), 'orange', 'green', 'red', 'purple', 'grey' and 'roman' (for roman fonts, instead of sans serif fonts)
      %\moderncvtheme[green]{classic}                % idem

      % character encoding
      \usepackage[utf8]{inputenc}                   % replace by the encoding you are using

      % adjust the page margins
      \usepackage[scale=${dDouble 0.8 cfg.margin}]{geometry}
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
      \address{${cv.info.street}}{${cv.info.address}}    % optional, remove the line if not wanted
      \phone{${cv.info.phone}}                      % optional, remove the line if not wanted
      \email{\href{mailto:${cv.info.email}}{${cv.info.email}}}                      % optional, remove the line if not wanted
      \homepage{${cv.info.website}} %{LinkedIn Profile}}                % optional, remove the line if not wanted
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

      ${optional.fold
          Double
          cfg.headerSpacing
          Text
          (λ(p : Double) → "\\vspace{${Double/show p}em}")
          ""}

      ${assembleSections cv.sections}

      \end{document}
      ''