let CVDocumentWithConfig = ../CVDocumentWithConfig.dhall

let cv = (../../prelude.dhall).cv

let Functor = (../../prelude.dhall).Functor

let CVDocument = cv.types.CVDocument

let CVDocumentFunctor = cv.functor.CVDocument

in    { map =
          \(a : Type) ->
          \(b : Type) ->
          \(f : a -> b) ->
          \(dwc : CVDocumentWithConfig a) ->
            { config = dwc.config
            , document = CVDocumentFunctor.map a b f dwc.document
            }
      }
    : Functor CVDocumentWithConfig
