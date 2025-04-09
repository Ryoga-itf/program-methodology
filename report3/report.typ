#import "../template.typ": *
#import "../proof.typ": *
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第3回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2024 年 7 月 29 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 演習問題4a

=== ■ $M_1 = y space 7, space T_1 = "int"$

#{
  set align(center)
  let goal = [$Gamma tack y space 7 : "int"$]
  proof(
    (goal,
      ($Gamma tack y : "int" -> "int"$, $space$),
      ($Gamma tack 7 : "int"$, $space$)
    )
  )
}

=== ■ $M_2 = lambda x. (y space (y space x)), space T_2 = "int" -> "int"$

#{
  set align(center)
  let goal = [$Gamma tack lambda x. (y space (y space x)) : "int" -> "int"$]
  proof(
    (goal,
      ($Gamma, x : "int" tack y space (y space x) : "int" $,
        ($Gamma, x : "int" tack y space x : "int"$,
          ($Gamma, x :"int" tack x : "int"$, $space$),
          ($Gamma, x : "int" tack y : "int" -> "int"$, $space$)
        )
      )
    )
  )
}

=== ■ $M_3 = lambda x. lambda y. (x + y) + x, T_3 = "int" -> ("int" -> "int")$

#{
  set align(center)
  let goal = [$Gamma tack lambda x. lambda y. (x + y) + x : "int" -> ("int" -> "int")$]
  proof(
    (goal,
      ($Gamma, x: "int" tack lambda y. (x + y) + x: "int" -> "int"$,
        ($Gamma, x: "int", y: "int" tack (x + y) + x: "int"$,
          ($Gamma, x: "int", y: "int" tack x + y: "int"$,
            ($Gamma, x: "int", y: "int" tack x: "int"$, $space$),
            ($Gamma, space.hair x: "int", y: "int" tack y: "int"$, $space$),
          ),
          ($Gamma, x: "int", y: "int" tack x: "int"$)
        )
      ),
    )
  )
}

#pagebreak()

== 演習問題4b

=== ■ $K := lambda x. lambda y. space x$

型が付く。$Gamma_1 = x: tau_1, space y: tau_2$ とおくと以下の通り。

#{
  set align(center)
  let goal = [$tack K : tau_1 -> (tau_2 -> tau_1)$]
  proof(
    (goal,
      ($x: tau_1 tack lambda y. space x : tau_2 -> tau_1$,
        ($x: tau_1, y: tau_2 tack x : tau_1$,
          ($Gamma_1 tack x : tau_1$, ($space$)
          )
        )
      )
    )
  )
}

=== ■ $S := lambda f. lambda g. lambda x. space ((f space x) space (g space x))$

型が付く。$Gamma_2 = f: tau_1 -> (tau_2 -> tau_3), space g: tau_1 -> tau_2, space x: tau_1$ とおくと以下の通り。

#{
  set align(center)
  let goal = [$tack S : (tau_1 -> (tau_2 -> tau_3)) -> ((tau_1 -> tau_2) -> (tau_1 -> tau_3))$]
  proof(
    (goal,
      ($f: tau_1 -> (tau_2 -> tau_3) tack lambda g. lambda x. space ((f space x) space (g space x)) : (tau_1 -> tau_2) -> (tau_1 -> tau_3)$,
        ($f: tau_1 -> (tau_2 -> tau_3), g: tau_1 -> tau_2 tack lambda x. space ((f space x) space (g space x)) : tau_1 -> tau_3$,
          ($f: tau_1 -> (tau_2 -> tau_3), g: tau_1 -> tau_2, x: tau_1 tack ((f space x) space (g space x)) : tau_3$,
            ($Gamma_2 tack ((f space x) space (g space x)) : tau_3$,
              ($Gamma_2 tack f space x : tau_2 -> tau_3$,
                ($Gamma_2 tack f : tau_1 -> (tau_2 -> tau_3)$, $space$),
                ($Gamma_2 tack x: tau_1$, $space$)
              ),
              ($Gamma_2 tack g space x : tau_2$,
                ($Gamma_2 tack g: tau_1 -> tau_2$, $space$),
                ($Gamma_2 tack x: tau_1$, $space$)
              )
            )
          )
        )
      )
    )
  )
}

=== ■ $K := lambda f. space ((lambda x. space (f space (x space x))) space (lambda x. space (f space (x space x))))$

型が付かない。

/ 理由: $lambda x. space (f space (x space x))$ の推論の際に、$tau = tau -> T'$ の形が含まれているため。
