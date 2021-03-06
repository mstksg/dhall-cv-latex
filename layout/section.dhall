let types = (../prelude.dhall).cv.types ∧ ../types.dhall

let functor = (../prelude.dhall).cv.functor

let text = (../prelude.dhall).text

let escapePlaintext = types.escapePlaintext

let mkBodyRawLaTeX =
      text.concatMapSep
        "\n"
        (types.CVCol types.LaTeX)
        (λ(c : types.CVCol types.LaTeX) → types.getRawLaTeX (./col.dhall c))

in  λ(section : types.CVSection types.LaTeX) →
      { rawLaTeX =
          ''
          \section{${escapePlaintext (text.default section.title)}}"
          ${mkBodyRawLaTeX section.contents}
          ''
      }
