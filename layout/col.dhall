let types = (../prelude.dhall).cv.types

let text = (../prelude.dhall).text

in  λ(c : types.CVCol) →
      merge
        { Simple = λ(body : Text) → "\\cvline{${text.default c.desc}} {${body}}"
        , Entry =
            λ(e : types.CVEntry) →
              ''
              \cventry{${text.default c.desc}}
                      {${e.title}}
                      {${text.default e.institution}}
                      {${text.default e.location}}
                      {${text.default e.grade}}
                      {${text.default e.body}}
              ''
        }
        c.body
