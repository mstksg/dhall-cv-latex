let types = (../prelude.dhall).cv.types ∧ ../types.dhall

let text = (../prelude.dhall).text

let optional = (../prelude.dhall).optional

let escapePlaintext = types.escapePlaintext

let dDouble = (./helpers.dhall).dDouble

let tOptionWith = (./helpers.dhall).tOptionWith

let tOption = (./helpers.dhall).tOption

let mkSectionsRawLaTeX =
      text.concatMapSep
        "\n\n"
        (types.CVSection types.LaTeX)
        ( λ(c : types.CVSection types.LaTeX) →
            types.getRawLaTeX (./section.dhall c)
        )

in  λ(cv : types.CVDocumentWithConfig types.LaTeX) →
      let document = cv.document

      let config = cv.config

      let info = document.info

      in  { rawLaTeX =
              ''
              \documentclass[10pt]{moderncv}

              % moderncv themes
              \moderncvtheme${tOptionWith
                                types.CVTheme
                                "["
                                "]"
                                types.showTheme
                                config.theme}{classic}

              % character encoding
              \usepackage[utf8]{inputenc}                   % replace by the encoding you are using

              % adjust the page margins
              \usepackage[scale=${dDouble 0.8 config.margin}]{geometry}
              %\setlength{\hintscolumnwidth}{3cm}						% if you want to change the width of the column with the dates
              %\AtBeginDocument{\setlength{\maketitlenamewidth}{6cm}}  % only for the classic theme, if you want to change the width of your name placeholder (to leave more space for your address details
              %\AtBeginDocument{\recomputelengths}                     % required when changes are made to page layout lengths

              % Hyperlinks
              %\usepackage{hyperref}								% to use hyperlinks
              %\definecolor{linkcolour}{rgb}{0,0.2,0.6}			% hyperlinks setup
              %\hypersetup{colorlinks,breaklinks,urlcolor=linkcolour, linkcolor=linkcolour}

              % personal data
              \firstname{${escapePlaintext info.firstName}}
              \familyname{${escapePlaintext info.lastName}${tOption
                                                              ", "
                                                              ""
                                                              info.title}}
              ${tOption "\\title{" "}" document.subtitle}
              \address{${escapePlaintext
                           info.street}}{${escapePlaintext
                                             info.address}} ${tOption
                                                                "{"
                                                                "}"
                                                                info.country}      % optional, remove the line if not wanted
              %\mobile{+30 698 4385057}                    % optional, remove the line if not wanted
              \phone{${escapePlaintext
                         info.phone}}                      % optional, remove the line if not wanted
              %\fax{fax (optional)}                          % optional, remove the line if not wanted
              \email{${escapePlaintext
                         info.email}}                      % optional, remove the line if not wanted
              %\email{\href{mailto:s.dakourou@gmail.com}{s.dakourou@gmail.com}}                      % optional, remove the line if not wanted
              \homepage{${escapePlaintext
                            info.website}}%{LinkedIn Profile}}                % optional, remove the line if not wanted
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

              ${tOptionWith
                  Double
                  "\\vspace{"
                  "em}"
                  Double/show
                  config.headerSpacing}

              ${mkSectionsRawLaTeX document.sections}

              \end{document}
              ''
          }
