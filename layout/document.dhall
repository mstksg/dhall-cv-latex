let types = (../prelude.dhall).cv.types ∧ ../types.dhall

let text = (../prelude.dhall).text

let mkSections =
      λ(s : List (types.CVSection types.LaTeX)) →
        { rawLaTeX =
            text.concatMapSep
              "\n\n"
              (types.CVSection types.LaTeX)
              ( λ(c : types.CVSection types.LaTeX) →
                  types.getRawLaTeX (./section.dhall c)
              )
              s
        }

in  λ(cv : types.CVDocumentWithConfig types.LaTeX) →
      let document = cv.document

      let config = cv.config

      let info = document.info

      in  ./template.dhall
            { config = cv.config
            , info = cv.document.info
            , documentClassOpts = [ types.DocumentClassOpt.FontSize 10 ]
            , subtitle = cv.document.subtitle
            , body =
              { header.rawLaTeX = "\\maketitle"
              , main = mkSections document.sections
              , footer.rawLaTeX = ""
              }
            }
