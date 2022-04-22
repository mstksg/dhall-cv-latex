\(a : Type) ->
  { config : ./CVDocumentConfig.dhall
  , letter : (../prelude.dhall).cv.types.CVLetter a
  }
