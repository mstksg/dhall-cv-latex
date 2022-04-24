let types = (../prelude.dhall).cv.types ∧ ../types.dhall

let text = (../prelude.dhall).text

let optional = (../prelude.dhall).optional

let escapePlaintext = types.escapePlaintext

let dDouble =
      λ(d : Double) →
      λ(x : Optional Double) →
        optional.fold Double x Text Double/show (Double/show d)

let tOptionWith =
      λ(a : Type) →
      λ(pre : Text) →
      λ(post : Text) →
      λ(process : a → Text) →
      λ(x : Optional a) →
        escapePlaintext
          (optional.fold a x Text (λ(o : a) → pre ++ process o ++ post) "")

let tOption =
      λ(pre : Text) →
      λ(post : Text) →
        tOptionWith Text pre post (λ(x : Text) → x)

in  { dDouble, tOptionWith, tOption }
