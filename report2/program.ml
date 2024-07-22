let f1 lst =
  match (List.rev lst) with
  | [] -> min_int
  | h::_ -> h

let f2 lst =
  let rec helper lst acc =
    match lst with
    | [] | [_] -> acc
    | h::t ->
      helper t (max acc (h + List.hd t))
  in
  match lst with
  | [] | [_] -> min_int
  | _ -> helper lst min_int

let f3 x y =
  List.sort_uniq compare (x @ y)

let rec f4 x y =
  match x, y with
  | [], l -> l
  | l, [] -> l
  | hx::tx, hy::ty ->
    if hx < hy then
      hx :: f4 tx y
    else
      hy :: f4 x ty

let rec f5 lst =
  match lst with
  | [] -> lst
  | t::h -> (f4 [t] (f5 h))

let f6 lst =
  let sorted = f5 lst in
  let length = List.length sorted in
  if length = 0 then
    min_int
  else if length mod 2 = 0 then
    ((List.nth sorted (length / 2 - 1)) + (List.nth sorted (length / 2))) / 2
  else
    List.nth sorted (length / 2)

let () =
  (* cf. https://stackoverflow.com/questions/9134929/print-a-list-in-ocaml *)
  let print_list lst =
    let rec helper lst =
      match lst with
      | [] -> ()
      | e::l -> print_int e ; print_string "; " ; helper l
    in
    print_string "[";
    helper lst;
    print_string "]";
  in

  print_string "Testing f1\n";
  print_int (f1 []);
  print_newline ();
  print_int (f1 [3]);
  print_newline ();
  print_int (f1 [3; 1]);
  print_newline ();
  print_int (f1 [3; 1; 4]);
  print_newline ();
  print_int (f1 [3; 1; 4; 1]);
  print_newline ();

  print_string "Testing f2\n";
  print_int (f2 []);
  print_newline ();
  print_int (f2 [3]);
  print_newline ();
  print_int (f2 [3; 1]);
  print_newline ();
  print_int (f2 [3; 1; 4]);
  print_newline ();
  print_int (f2 [3; (-1); (-4); 5; 9; (-2); 6]);
  print_newline ();

  print_string "Testing f3\n";
  print_list (f3 [] []);
  print_newline ();
  print_list (f3 [3; 1; 4] [1; 5; 9]);
  print_newline ();
  print_list (f3 [3; 1; 4] [1; 4; 5]);
  print_newline ();
  print_list (f3 [3] [3]);
  print_newline ();
  print_list (f3 [3; 1; 4] []);
  print_newline ();

  print_string "Testing f4\n";
  print_list (f4 [] []);
  print_newline ();
  print_list (f4 [1; 2; 3] [4; 5; 6]);
  print_newline ();
  print_list (f4 [6; 7; 8] [2; 3; 7]);
  print_newline ();
  print_list (f4 [1; 2; 3; 4; 5; 6] [3; 4; 5; 6; 7; 8]);
  print_newline ();
  print_list (f4 [2; 5; 7; 8] [2; 5; 7; 8; 9]);
  print_newline ();

  print_string "Testing f5\n";
  print_list (f5 [3; 1; 4]);
  print_newline ();
  print_list (f5 [3; 1; 4; 1; 5; 9]);
  print_newline ();
  print_list (f5 [4; 3; 5; 6; 8; 1; 3]);
  print_newline ();
  print_list (f5 [3]);
  print_newline ();
  print_list (f5 []);
  print_newline ();

  print_string "Testing f6\n";
  print_int (f6 [3; 1; 4]);
  print_newline ();
  print_int (f6 [3; 1; 4; 1; 5; 9]);
  print_newline ();
  print_int (f6 [1; 1; 2000; 2000; 100; 200]);
  print_newline ();
  print_int (f6 [3]);
  print_newline ();
  print_int (f6 []);
  print_newline ();
