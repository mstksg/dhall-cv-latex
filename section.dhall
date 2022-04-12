let types = (./prelude.dhall).types

let text =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v22.0.0/Prelude/Text/package.dhall
        sha256:79b671a70ac459b799a53bbb8a383cc8b81b40421745c54bf0fb1143168cbd6f

let mkBody = text.concatMapSep "\n" types.CVCol ./col.dhall

in  λ(section : types.CVSection) →
      ''
      \section{${text.default section.title}}"
      ${mkBody section.contents}
      ''
