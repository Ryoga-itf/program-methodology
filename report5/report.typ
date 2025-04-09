#import "../template.typ": *
#import "@preview/codelst:2.0.2": sourcecode, sourcefile
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第5回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2024 年 8 月 19 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 演習問題 (6a-1)

本課題は与えられた仕様を満たす末尾再帰関数を作成せよというものである。
今回は課題として与えられた `f1`, `f2`, `f3` 関数を実装した。

以下にコードを示す。
なお、実行例のためのコードも含んでおり、授業資料で示されたサンプルを走らせている。
結果を確認するために、`List` を出力するコードを https://stackoverflow.com/questions/9134929/print-a-list-in-ocaml より引用して用いた。

また、コードを作成するにあたり、https://stackoverflow.com/questions/37530682/compare-two-integer-lists-in-ocaml を参考にした。(関数 `f2` の `match` 内)

#sourcefile(read("program.ml"), file:"program.ml")

== 演習問題 (6a-2)

/ `fun x -> x`:

第 2 引数は順に以下の通り

- `fun x -> x`
- `fun x -> 3 * x`
- `fun x -> 3 * (2 * x)`
- `fun x -> 3 * (2 * (1 * x))`

型はいずれも `int -> int`

/ `fun x -> string_of_int x`:

第 2 引数は順に以下の通り

- `fun x -> string_of_int x`
- `fun x -> string_of_int (3 * x)`
- `fun x -> string_of_int (3 * (2 * x))`
- `fun x -> string_of_int (3 * (2 * (1 * x)))`

型はいずれも `int -> string`

=== 発展課題

フィボナッチ数列の第 $n$ 項目を返す関数 `fib` を継続渡し方式に変換し、`fib_cps` 関数として実装した。
以下にコードを示す。

#sourcecode[
```ml
let rec fib_cps n k =
  if n <= 1 then k 1
  else fib_cps (n - 1) (fun x -> fib_cps (n - 2) (fun y -> k (x + y))) ;;
```
]

例えば `print_int (fib_cps 10 (fun x -> x))` を実行すると `89` という結果が得られた。

#pagebreak(weak: true)

== 演習問題 (6b)

/ `covariance`:

共変 (covariant) とは、広い型（親クラス、superクラス）から狭い型（子クラス、subクラス）へ変換することをいう。
ある型が他の型のサブタイプである場合、ジェネリック型のサブタイプ関係もそれに従うことを意味する。

用途として、型の読み取り専用操作に使用することがある。`? extends T` によりサブクラス型を許容し、安全にデータを読み取ることができる。

/ `contravariance`:

反変 (contravariant) とは、狭い型（子クラス、subクラス）から広い型（親クラス、superクラス）へ変換することをいう。
ある型が他の型のサブタイプである場合、ジェネリック型では逆のサブタイプ関係を持つことを意味する。

用途として、データの書き込み操作に使用することがある。`? super T` によりスーパークラス型を許容し、サブクラスのデータを安全に書き込むことができる。

/ `invariance`:

不変性 (invariance) とは、関連する 2 つの型 A と B があり、A が B のサブタイプである場合でも、パラメーター化された型Container `<A>` とが Container `<B>` サブタイプ関係にあるとは見なされないことを意味する。

ジェネリック型の不変性は型の安全性に重要な意味を持つ。ある型が別の型のサブタイプであっても、それらの型のジェネリック型は本質的に同じ関係を維持しないことを意味する。

用途として、型が完全に一致している必要がある場面で使用することがある。ジェネリクスが型パラメータに対して厳密な制約を持つためである。

===== 参考文献

- Covariance and Contravariance In Java, https://dzone.com/articles/covariance-and-contravariance (2024 年 8 月 18 日アクセス)
- Understanding Invariance in Java Generics, https://medium.com/@barbieri.santiago/understanding-invariance-in-java-generics-048cb891569e (2024 年 8 月 18 日アクセス)
