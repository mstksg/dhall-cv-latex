let types = (../prelude.dhall).cv.types ∧ ../types.dhall

let text = (../prelude.dhall).text

let optional = (../prelude.dhall).optional

let escapePlaintext = types.escapePlaintext

let dDouble = (./helpers.dhall).dDouble

let tOptionWith = (./helpers.dhall).tOptionWith

let tOption = (./helpers.dhall).tOption

let escapePlaintext = types.escapePlaintext

in  λ(lwc : types.CVLetterWithConfig types.LaTeX) →
      let letter = lwc.letter

      let config = lwc.config

      let info = letter.info

      let header = letter.header

      in  { rawLaTeX =
              ''
              %% start of file `template.tex'.
              %% Copyright 2006-2013 Xavier Danaux (xdanaux@gmail.com).
              %
              % This work may be distributed and/or modified under the
              % conditions of the LaTeX Project Public License version 1.3c,
              % available at http://www.latex-project.org/lppl/.

              \documentclass[11pt,a4paper,sans]{moderncv}        % possible options include font size ('10pt', '11pt' and '12pt'), paper size ('a4paper', 'letterpaper', 'a5paper', 'legalpaper', 'executivepaper' and 'landscape') and font family ('sans' and 'roman')
              \moderncvtheme${tOptionWith
                                types.CVTheme
                                "["
                                "]"
                                types.showTheme
                                config.theme}{classic}
              \usepackage[utf8]{inputenc}                       % if you are not using xelatex ou lualatex, replace by the encoding you are using
              %\usepackage{CJKutf8}                              % if you need to use CJK to typeset your resume in Chinese, Japanese or Korean

              % adjust the page margins
              \usepackage[scale=0.75]{geometry}
              %\setlength{\hintscolumnwidth}{3cm}                % if you want to change the width of the column with the dates
              %\setlength{\makecvtitlenamewidth}{10cm}           % for the 'classic' style, if you want to force the width allocated to your name and avoid line breaks. be careful though, the length is normally calculated to avoid any overlap with your personal info; use this at your own typographical risks...

              % personal data
              \firstname{${escapePlaintext info.firstName}}
              \familyname{${escapePlaintext info.lastName}${tOption
                                                              ", "
                                                              ""
                                                              info.title}}
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

              % to show numerical labels in the bibliography (default is to show no labels); only useful if you make citations in your resume
              %\makeatletter
              %\renewcommand*{\bibliographyitemlabel}{\@biblabel{\arabic{enumiv}}}
              %\makeatother
              %\renewcommand*{\bibliographyitemlabel}{[\arabic{enumiv}]}% CONSIDER REPLACING THE ABOVE BY THIS

              % bibliography with mutiple entries
              %\usepackage{multibib}
              %\newcites{book,misc}{{Books},{Others}}
              %----------------------------------------------------------------------------------
              %            content
              %----------------------------------------------------------------------------------
              \begin{document}

              %%-----       letter       ---------------------------------------------------------
              %% recipient data
              \recipient{${escapePlaintext
                             header.recipient.name}}{${escapePlaintext
                                                         header.recipient.address}}
              \date{${escapePlaintext header.date}}
              \opening{${types.getRawLaTeX header.opening}}
              \closing{${types.getRawLaTeX header.closing}}
              \enclosure${tOption
                            "["
                            "]"
                            header.enclosure.type}{${escapePlaintext
                                                       header.enclosure.description}}
              \makelettertitle

              ${tOptionWith
                  Double
                  "\\vspace{"
                  "em}"
                  Double/show
                  config.headerSpacing}

              ${types.getRawLaTeX letter.body}

              \makeletterclosing

              \end{document}


              %% end of file `template.tex'.
              ''
          }
