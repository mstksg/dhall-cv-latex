let types = (../prelude.dhall).cv.types ∧ ../types.dhall

let text = (../prelude.dhall).text

let optional = (../prelude.dhall).optional

in  λ(c : types.CVCol types.LaTeX) →
      { rawLaTeX =
          merge
            { Simple =
                λ(body : types.LaTeX) →
                  "\\cvline{${text.default c.desc}} {${body.rawLaTeX}}"
            , Entry =
                λ(e : types.CVEntry types.LaTeX) →
                  ''
                  \cventry{${text.default c.desc}}
                          {${e.title}}
                          {${text.default e.institution}}
                          {${text.default e.location}}
                          {${text.default e.grade}}
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
