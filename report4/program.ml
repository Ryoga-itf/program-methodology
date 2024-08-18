let rec f1 (lst: 'a list list) : 'a list =
  match lst with
  | [] -> []
  | h::t -> List.append h (f1 t)

let f2 (fs: ('a -> 'a) list) : 'a -> 'a =
  List.fold_right (fun f acc -> fun x -> f (acc x)) fs (fun x -> x)

let rec f3 (f: 'a -> 'a) (n: int) (x: 'a) : 'a =
  if n <= 0 then x else f3 f (n - 1) (f x)

let f4 (cmp: 'a -> 'a -> bool) (lst: 'a list) : 'a list =
  let rec helper x sorted =
    match sorted with
    | [] -> [x]
    | h::t -> if cmp x h then x :: sorted else h :: (helper x t)
  in
  List.fold_right helper lst []

(* https://gist.github.com/flux77/ab4c20ee28fc3742df29c4f790e6e65f より引用 *)
(* Helper function. *)
let print_list to_string l =
    let rec loop rem acc =
        match rem with
        | [] -> acc
        | [s] -> acc ^ (to_string s)
        | (s::ss) ->
            loop ss (acc ^ (to_string s) ^ "; ") in
    print_string "[";
    print_string (loop l "");
    print_endline "]"

let print_str_list = print_list (fun s -> "\"" ^ s ^ "\"")
let print_char_list = print_list (fun c -> "'" ^ String.make 1 c ^ "'")
let print_int_list = print_list string_of_int
let print_float_list = print_list string_of_float
let print_bool_list = print_list string_of_bool

let () =
  print_string "Testing f1\n";
  print_int_list (f1 [[10; 20]; [30; 40; 50]]);
  print_str_list (f1 [["a"; "bcd"]; ["ef"]]);
  print_char_list (f1 [['o'; 'c']; ['a'; 'm']; ['l']]);
  print_float_list (f1 [[0.1; 0.2]; [0.3; 0.4]; [0.5]]);
  print_bool_list (f1 [[true; false]; [true; true; false]; [true; false]]);
  print_newline ();

  print_string "Testing f2\n";
  print_endline (string_of_int ((f2 [(fun x -> x * 2); (fun x -> x + 1)]) 10));
  print_endline (string_of_float((f2 [(fun x -> x +. 2.0); (fun x -> x *. 3.0)]) 5.0));
  print_endline (string_of_bool ((f2 [(fun x -> not x); (fun x -> x)]) true));
  print_endline ((f2 [(fun x -> x ^ " !!"); (fun x -> "Hello " ^ x)]) "world");
  print_int_list ((f2 [(fun x -> List.append x x); (fun x -> List.rev x)]) [3; 1; 4]);
  print_newline ();

  print_string "Testing f3\n";
  print_endline (string_of_int (f3 (fun x -> x * 2) 5 3));
  print_endline (string_of_float (f3 (fun x -> x +. 2.0) 5 3.0));
  print_endline (string_of_bool (f3 (fun x -> not x) 5 true));
  print_endline (f3 (fun x -> x ^ "!") 10 "Hello");
  print_str_list (f3 (f2 [(fun x -> List.append x ["!"]); (fun x -> List.rev x)]) 6 ["Hello"]);
  print_newline ();

  print_string "Testing f4\n";
  print_int_list (f4 (fun x y -> x > y) [3; 7; 6; 1]);
  print_float_list (f4 (fun x y -> x < y) [3.0; 7.0; 6.0; 1.0]);
  print_char_list (f4 (fun x y -> x < y) ['t'; 's'; 'u'; 'k'; 'u'; 'b'; 'a']);
  print_int_list (f4 (fun x y -> x mod 2 == 0) [3; 7; 6; 1; 5; 2]);
  print_str_list (f4 (fun x y -> String.length x < String.length y) ["Hello"; "this"; "program"; "is"; "written"; "in"; "Ocaml"]);
  print_newline ();
