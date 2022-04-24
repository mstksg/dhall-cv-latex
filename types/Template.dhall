-- | Template for building up latex file
{ info : (../prelude.dhall).cv.types.CVInfo
, config : ./CVDocumentConfig.dhall
, subtitle : Optional Text
, body :
    { header : ./LaTeX.dhall, main : ./LaTeX.dhall, footer : ./LaTeX.dhall }
, documentClassOpts : List ./DocumentClassOpt.dhall
}
