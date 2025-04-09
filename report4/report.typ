#import "../template.typ": *
#import "../proof.typ": *
#import "@preview/codelst:2.0.2": sourcecode, sourcefile
#import "@preview/tenv:0.1.2": parse_dotenv

#let env = parse_dotenv(read("../.env"))

#show: project.with(
  week: "第4回",
  authors: (
    (name: env.STUDENT_NAME, email: "学籍番号：" + env.STUDENT_ID, affiliation: "所属：情報科学類"),
  ),
  date: "2024 年 8 月 5 日",
)

#show math.equation: set text(font: ("New Computer Modern Math", "Noto Serif", "Noto Serif CJK JP"))

== 演習問題 (1)

本課題は与えられた仕様を満たす多相関数を作成せよというものである。
今回は課題として与えられた `f1`, `f2`, `f3`, `f4` 関数を実装した。

以下にコードを示す。
なお、実行例のためのコードも含んでいる。
結果を確認するために、`List` を出力するコードを https://gist.github.com/flux77/ab4c20ee28fc3742df29c4f790e6e65f より引用して用いた。

#sourcefile(read("program.ml"), file:"program.ml")

実行例については 5 個以上の異なる引数に対して走らせている。

実行結果として以下を得た。

#sourcefile(read("output"), file:"output", lang: "plain")

== 演習問題 (2)

=== (2-1)

$II = "int" -> "int"$ とする。

#{
  set text(size: 0.8em)
  set align(center)
  let goal = [$tack (f space f) space 7 : "int"$]
  proof(
    margin: 2,
    (goal,
      ($tack lambda x. space ((S space K) space K) space x : alpha -> alpha$,
        ($tack (S space K) space K : alpha -> alpha$,
          ($tack S space K : (alpha -> beta) -> alpha -> alpha$,
            ($tack S : (alpha -> beta -> gamma) -> (alpha -> beta) -> alpha -> gamma$, $$),
            $$,
            $$,
            ($tack K : delta -> epsilon -> delta space$, $$)
          )
        )
      ),
      $$,
      ($Gamma_1 tack (f space f) space 7 : "int"$,
        ($Gamma_1 tack f space f : II$,
          ($Gamma_1 tack f : II$, $$),
          ($Gamma_1 tack f : II -> II$, $$),
        ),
        ($Gamma_1 tack 7 : " int"$, $$),
      )
    )
  )
}

=== (2-2)

Zig はシンプルで効率的なシステムプログラミング言語であり、コンパイル時の型推論とジェネリクスをサポートしている。
Zig のジェネリクスは「コンプタイム（コンパイル時）パラメータ」と呼ばれ、関数や構造体の定義で使用される。

また、Zig では、C++ と同様にコンパイル時にジェネリクスが解決されるため、実行時のオーバーヘッドがない。
一方で、C++ と同じような解決の仕方をするため、授業内で指摘している「真のパラメータ多相を持っていない」という見方ができる。

Zig では、ジェネリックは特定の機能というよりは、言語の機能を表現するものになっており、具体的には、ジェネリックは Zig のコンパイル時という概念を明示的に扱う、強力なコンパイル時メタプログラミングを活用する形で表現する。
型をコンパイル時の変数のように用いてジェネリクスを表現するか、`anytype` を用いた型推論を用いる。

==== appendix: Zig でのジェネリクスの例

#sourcecode[
```zig
// 42 を足した数を返す
fn addFortyTwo(x: anytype) @TypeOf(x) {
    return x + 42;
}

// 最大値を得る
fn largest(comptime T: type, list: []const T) T {
    var res = list[0];
    for (list) |item| {
        if (std.math.compare(item, .gt, res)) {
            res = item;
        }
    }
    return res;
}

// 最大値を得る
fn largest2(comptime T: type) fn ([]const T) T {
    return struct {
        fn e(list: []const T) T {
            var res = list[0];
            for (list) |item| {
                if (std.math.compare(item, .gt, res)) {
                    res = item;
                }
            }
            return res;
        }
    }.e;
}

// 型を返す
fn Pair(comptime T: type) type {
    return struct {
        first: T,
        second: T,
    };
}
```
]
