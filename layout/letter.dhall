let types = (../prelude.dhall).cv.types ∧ ../types.dhall

let text = (../prelude.dhall).text

let optional = (../prelude.dhall).optional

let escapePlaintext = types.escapePlaintext

let dDouble = (./helpers.dhall).dDouble

let tOptionWith = (./helpers.dhall).tOptionWith

let tOption = (./helpers.dhall).tOption

let escapePlaintext = types.escapePlaintext

in  λ(lwc : types.CVLetterWithConfig types.LaTeX) →
      let letter = lwc.letter

      let header = letter.header

      in  ./template.dhall
            { config = lwc.config
            , info = lwc.letter.info
            , documentClassOpts =
              [ types.DocumentClassOpt.FontSize 11
              , types.DocumentClassOpt.PaperSize types.PaperSize.A4Paper
              , types.DocumentClassOpt.FontFamily types.FontFamily.Sans
              ]
            , subtitle = None Text
            , body =
              { header.rawLaTeX
                =
                  ''
                  %%-----       letter       ---------------------------------------------------------
                  %% recipient data
                  \recipient{${escapePlaintext
                                 header.recipient.name}}{${escapePlaintext
                                                             header.recipient.address}}
                  \date{${escapePlaintext header.date}}
                  \opening{${types.getRawLaTeX header.opening}}
                  \closing{${types.getRawLaTeX header.closing}}
                  \enclosure${tOption
                                "["
                                "]"
                                header.enclosure.type}{${escapePlaintext
                                                           header.enclosure.description}}
                  \makelettertitle
                  ''
              , main = letter.body
              , footer.rawLaTeX = "\\makeletterclosing"
              }
            }
