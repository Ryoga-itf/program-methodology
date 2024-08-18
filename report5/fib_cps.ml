let rec fib n =
  if n <= 1 then 1
  else (fib (n - 2)) + (fib (n - 1)) ;;

let rec fib2 n res1 res2 = 
  if n = 0 then res1
  else if n = 1 then res2
  else fib2 (n - 1) res2 (res1 + res2) ;;

let rec fib_cps n k =
  if n <= 1 then k 1
  else fib_cps (n - 1) (fun x -> fib_cps (n - 2) (fun y -> k (x + y))) ;;

print_int (fib 10);
print_int (fib2 10 1 1);
print_int (fib_cps 10 (fun x -> x))
