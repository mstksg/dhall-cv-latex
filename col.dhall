let types = (./prelude.dhall).types

let text =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v22.0.0/Prelude/Text/package.dhall
        sha256:79b671a70ac459b799a53bbb8a383cc8b81b40421745c54bf0fb1143168cbd6f

in  λ(c : types.CVCol) →
      merge
        { Simple = λ(b : Text) → "\\cvline{${text.default c.desc}} {${b}}"
        , Entry =
            λ(e : types.CVEntry) →
              ''
              \cventry{${text.default c.desc}}
                      {${e.title}}
                      {${text.default e.location}}
                      {${text.default e.grade}}
                      {}
                      {${text.default e.body}}
              ''
        }
        c.body
