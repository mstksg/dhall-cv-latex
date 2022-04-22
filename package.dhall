let types = (./prelude.dhall).cv.types ∧ ./types.dhall

let functor = ./types/functor.dhall

in  { layout = ./layout.dhall
    , types = ./types.dhall
    , functor
    , fullRender =
        λ(markdownToLaTeX : Text → Text) →
        λ(d : types.CVDocumentWithConfig types.Markdown) →
          ./layout/document.dhall
            ( functor.CVDocumentWithConfig.map
                types.Markdown
                types.LaTeX
                ( λ(md : types.Markdown) →
                    { rawLaTeX = markdownToLaTeX md.rawMarkdown }
                )
                d
            )
    }
