{ CVDocumentConfig = ./types/CVDocumentConfig.dhall
, CVTheme = ./types/CVTheme.dhall
, CVDocumentWithConfig =
    ./types/CVDocumentConfig.dhall //\\ (./prelude.dhall).cv.types.CVDocument
, CVLetterWithConfig =
    ./types/CVDocumentConfig.dhall //\\ (./prelude.dhall).cv.types.CVLetter
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
