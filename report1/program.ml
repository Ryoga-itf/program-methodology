let f1 n k =
  (n lsr k) land 1

let f2 n m =
  let rec helper k power =
    if n mod power = 0 then
      helper (k + 1) (power * m)
    else
      k - 1
  in
  helper 0 1

let f3 n m p =
  let rec gcd a b =
    if b = 0 then a else gcd b (a mod b)
  in
  gcd (gcd n m) p

let f4 n =
  let rec count_divs d count =
    if d * d > n then
      count
    else if d * d = n then
      count + 1
    else if n mod d = 0 then
      count_divs (d + 1) (count + 2)
    else
      count_divs (d + 1) count
  in
  count_divs 1 0

let () =
  print_string "Testing f1\n";
  print_int (f1 11 2);
  print_newline ();
  print_int (f1 11 3);
  print_newline ();
  print_int (f1 256 8);
  print_newline ();
  print_int (f1 256 9);
  print_newline ();
  print_int (f1 123 2);
  print_newline ();

  print_string "Testing f2\n";
  print_int (f2 36 3);
  print_newline ();
  print_int (f2 36 4);
  print_newline ();
  print_int (f2 36 5);
  print_newline ();
  print_int (f2 36 12);
  print_newline ();
  print_int (f2 144 12);
  print_newline ();

  print_string "Testing f3\n";
  print_int (f3 24 45 81);
  print_newline ();
  print_int (f3 1 2 3);
  print_newline ();
  print_int (f3 24 48 96);
  print_newline ();
  print_int (f3 1024 256 32);
  print_newline ();
  print_int (f3 1314 3535 6433);
  print_newline ();

  print_string "Testing f4\n";
  print_int (f4 11);
  print_newline ();
  print_int (f4 32);
  print_newline ();
  print_int (f4 128);
  print_newline ();
  print_int (f4 1024);
  print_newline ();
  print_int (f4 36);
  print_newline ()
