let CVLetterWithConfig = ../CVLetterWithConfig.dhall

let cv = (../../prelude.dhall).cv

let Functor = (../../prelude.dhall).Functor

let CVLetter = cv.types.CVLetter

let CVLetterFunctor = cv.functor.CVLetter

in    { map =
          \(a : Type) ->
          \(b : Type) ->
          \(f : a -> b) ->
          \(lwc : CVLetterWithConfig a) ->
            { config = lwc.config
            , letter = CVLetterFunctor.map a b f lwc.letter
            }
      }
    : Functor CVLetterWithConfig
