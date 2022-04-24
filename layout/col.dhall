let types = (../prelude.dhall).cv.types ∧ ../types.dhall

let text = (../prelude.dhall).text

let optional = (../prelude.dhall).optional

let escapePlaintext = types.escapePlaintext

in  λ(c : types.CVCol types.LaTeX) →
      { rawLaTeX =
          merge
            { Simple =
                λ(body : types.LaTeX) →
                  "\\cvline{${text.default c.desc}} {${body.rawLaTeX}}"
            , Entry =
                λ(e : types.CVEntry types.LaTeX) →
                  ''
                  \cventry{${escapePlaintext (text.default c.desc)}}
                          {${escapePlaintext e.title}}
                          {${escapePlaintext (text.default e.institution)}}
                          {${escapePlaintext (text.default e.location)}}
                          {${escapePlaintext (text.default e.grade)}}
                          {${text.default
                               ( optional.map
                                   types.LaTeX
                                   Text
                                   types.getRawLaTeX
                                   e.body
                               )}}
                  ''
            }
            c.body
      }
