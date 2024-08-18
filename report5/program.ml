let f1 lst =
  let rec helper lst res =
    match lst with
    | [] -> res
    | h::t -> helper t (res + h)
  in
  helper lst 0


let f2 a b =
  let rec helper lst1 lst2 res =
    match lst1, lst2 with
    | [], [] -> res
    | h::l, [] -> helper l [] (h::res)
    | [], h::l -> helper [] l (h::res)
    | h1::t1, h2::t2 -> helper t1 t2 (h1 + h2::res)
  in
  helper a b []

let rec f3 f lst =
  let rec revappend lst a =
    match lst with
    | [] -> a
    | h::t -> revappend t (h::a)
  in
  let rec helper f lst res =
    match lst with
    | [] -> revappend res []
    | h::t -> helper f t ((f h)::res)
  in
  helper f lst []

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
  print_int (f1 [7; -3; 5; 6]);
  print_newline ();
  print_newline ();

  print_string "Testing f2\n";
  print_list (f2 [10; 20; 30] [4; 5; 6; 7]);
  print_newline ();
  print_newline ();

  print_string "Testing f3\n";
  print_list (f3 (fun x -> x * 2) [1; 2; 3]);
  print_newline ();
  print_newline ();
