{ CVDocumentConfig = ./types/CVDocumentConfig.dhall
, CVTheme = ./types/CVTheme.dhall
, CVDocumentWithConfig = ./types/CVDocumentWithConfig.dhall
, CVLetterWithConfig = ./types/CVLetterWithConfig.dhall
, LaTeX = ./types/LaTeX.dhall
, rawLaTeX = \(rawLaTeX : ./types/LaTeX.dhall) -> { rawLaTeX }
, getRawLaTeX = \(x : ./types/LaTeX.dhall) -> x.rawLaTeX
, showTheme =
    \(t : ./types/CVTheme.dhall) ->
      merge
        { Blue = "blue"
        , Orange = "orange"
        , Green = "green"
        , Red = "red"
        , Purple = "purple"
        , Grey = "grey"
        , Roman = "roman"
        }
        t
}
