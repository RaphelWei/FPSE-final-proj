open Core;;
open Game_logic;;
(* open Game;; *)

type agent = {
  search_depth : int;
  color : color
}

let piece_weight (p : piece) = 
  match p.id with 
  | General -> 1000000
  | Advisor -> 110
  | Elephant -> 110 
  | Horse -> 300
  | Chariot -> 600
  | Cannon -> 300
  | Soldier -> 70
  | Empty -> 0
;;


let evaluate_row (l : piece list) = 
(* Return a pair (rvalue, bvalue) indicating the whole power of red and blue player *)
  List.fold_left
            l
            ~init:(0,0)
            ~f:(
              fun (rval, bval) item ->
                let v = piece_weight item in 
                match item.color with
                | Red -> (rval + v, bval)
                | Black -> (rval, bval + v)
                | N -> (rval, bval)
            )
;;
  

let evaluate_board board = 
(* Return a pair (rvalue, bvalue) indicating the whole power of red and blue player *)
  List.fold_left
            board
            ~init:(0,0)
            ~f:(
              fun (rval, bval) row ->
                let r, b = evaluate_row row in 
                (rval + r, bval + b)
            )
;;

type minmax = 
  | Min 
  | Max
;;

let switch_min_max = function | Min -> Max | Max -> Min;;


let board_score (c : color) ((rval,bval) : int * int) = 
  match c with 
  | Red -> rval - bval
  | Black -> bval - rval
  | N -> failwith "board_score : invalid color"
;;





