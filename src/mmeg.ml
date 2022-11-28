open Core;;

type 'a binary_tree = 
  | Leaf 
  | Node of { value : 'a; 
              left : 'a binary_tree; 
              right : 'a binary_tree}





type minmax = Max | Min ;;

let rec min_max_aux node depth mm alpha beta = 
 
  match node with
  | Leaf -> failwith ""
  | Node{value; left=Leaf; right=Leaf} -> value
  | Node{value; left; right} ->
    let ret = 
      if depth = 0
      then value 
      else 
        let children = List.filter [left; right] ~f:(fun x -> match x with Leaf -> false | _ -> true ) in 
        
        begin
          match mm with 
          | Max ->
            begin 
              List.fold_until
                children
                ~init:alpha
                ~f:(
                  fun bestalpha child ->
                    let value = min_max_aux child (depth-1) Min bestalpha beta in 
                    if value >= beta
                    then Stop value
                    else Continue (max value bestalpha)
                )
                ~finish:Fn.id
              
            end
          | Min -> 
            begin
              List.fold_until
                children
                  ~init:beta
                  ~f:(
                    fun bestbeta child ->
                      let value = min_max_aux child (depth-1) Max alpha bestbeta in 
                      if value <= alpha
                      then Stop value
                      else Continue (min value bestbeta)
                  )
                ~finish:Fn.id
            end

        end
      in 
      let s = match mm with Min -> "Min" | Max -> "Max" in 
      Printf.printf "min_max_aux node=%d depth=%d mm=%s alpha=%d beta=%d return=%d \n" value depth s alpha beta ret;
      ret
;;

(*
       1
      / \
     7   9
    / \
   2   6
      / \
     5   11
*)


let n5  = Node{value = 5; left=Leaf; right=Leaf} 
let n11 = Node{value = 11; left=Leaf; right=Leaf} 
let n2 = Node{value = 2; left=Leaf; right=Leaf} 
let n9 = Node{value = 9; left=Leaf; right=Leaf}
let n6 = Node{value=6; left=n5; right=n11}
let n7 = Node{value=7; left=n2; right=n6}
let n1 = Node{value=1; left=n7; right=n9}

let _ = min_max_aux n6 1 Max (-100) 100 