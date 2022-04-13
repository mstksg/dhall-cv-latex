let types = (../prelude.dhall).cv.types

let text = (../prelude.dhall).text

let mkBody = text.concatMapSep "\n" types.CVCol ./col.dhall

in  λ(section : types.CVSection) →
      ''
      \section{${text.default section.title}}"
      ${mkBody section.contents}
      ''
