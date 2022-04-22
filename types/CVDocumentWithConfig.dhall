\(a : Type) ->
  { config : ./CVDocumentConfig.dhall
  , document : (../prelude.dhall).cv.types.CVDocument a
  }
