let showTheme =
      λ(t : ./types/CVTheme.dhall) →
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

let showPaperSize =
      λ(s : ./types/PaperSize.dhall) →
        merge
          { A4Paper = "a4paper"
          , LetterPaper = "letterpaper"
          , A5Paper = "a5paper"
          , LegalPaper = "legalpaper"
          , ExecutivePaper = "executivepaper"
          , Landscape = "landscape"
          }
          s

let showFontFamily =
      λ(f : ./types/FontFamily.dhall) →
        merge { Sans = "sans", Roman = "roman" } f

let showDocumentClassOpt =
      λ(o : ./types/DocumentClassOpt.dhall) →
        merge
          { FontSize = λ(n : Natural) → Natural/show n ++ "pt"
          , PaperSize = showPaperSize
          , FontFamily = showFontFamily
          }
          o

in  { CVDocumentConfig = ./types/CVDocumentConfig.dhall
    , CVTheme = ./types/CVTheme.dhall
    , CVDocumentWithConfig = ./types/CVDocumentWithConfig.dhall
    , CVLetterWithConfig = ./types/CVLetterWithConfig.dhall
    , LaTeX = ./types/LaTeX.dhall
    , Template = ./types/Template.dhall
    , PaperSize = ./types/PaperSize.dhall
    , FontFamily = ./types/FontFamily.dhall
    , DocumentClassOpt = ./types/DocumentClassOpt.dhall
    , rawLaTeX = λ(rawLaTeX : ./types/LaTeX.dhall) → { rawLaTeX }
    , getRawLaTeX = λ(x : ./types/LaTeX.dhall) → x.rawLaTeX
    , escapePlaintext = Text/replace "&" "\\&"
    , showTheme
    , showPaperSize
    , showFontFamily
    , showDocumentClassOpt
    }
