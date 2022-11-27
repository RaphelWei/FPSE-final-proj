open Core;;
open Game_logic;;
open Game;;



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


let minval = -10000001;;
let maxval = 10000001;; 

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




let rec naive_min_max_aux (g : Game.game) (depth : int) (mm : minmax) turn =   
  if depth = 0
  then (None, evaluate_board g.board |> board_score g.turn)
  else 
    begin
      let next_level = 
        g 
        |> Game.valid_next_steps
        |> List.map ~f:(fun (src, dest ,g') -> (src, dest, naive_min_max_aux g' (depth-1) (switch_min_max mm) turn |> snd))
      in 
      let mm_func = mm |> function | Min -> List.min_elt | Max -> List.max_elt in 
        mm_func
          next_level
          ~compare:(fun (_, _, score1) (_, _, score2) -> Int.compare score1 score2)
        |> function 
          | None -> (None, evaluate_board g.board |> board_score turn) 
          | Some (src, dest, score) -> (Some( (src ,dest)), score)
    end
;;

let naive_min_max (g : Game.game) (depth : int) = 
  let (move, _) = naive_min_max_aux g depth Max g.turn in 
  match move with
  | None -> failwith "naive_min_max"
  | Some (src, dest) -> (src, dest)
;;



let fst_3_tuple x = match x with (a,_,_) -> a;;

let rec min_max_alpha_beta_aux (g : Game.game) (depth : int) (mm : minmax) (alpha : int) (beta : int) (root_player : color) = 
  if (compare_color g.turn N = 0) || (depth = 0)
  then g.board |> evaluate_board |> board_score root_player, (-1,-1), (-1,-1)
  else 
    let children = Game.valid_next_steps g in 
    match mm with 
    | Min -> 
      List.fold_until
            children
            ~init:(beta, (-1,-1), (-1,-1))
            ~f:(
              fun (bestbeta, bestsrc, bestdest) (src, dest, g') ->
                let value = min_max_alpha_beta_aux g' (depth-1) Max alpha bestbeta root_player |> fst_3_tuple in 
                if value <= alpha
                then Stop (value, src, dest)
                else 
                  begin
                    if value < bestbeta
                    then Continue (value, src, dest)
                    else Continue (bestbeta, bestsrc, bestdest)
                  end 
            )
            ~finish:Fn.id
    | Max ->
      List.fold_until
            children
            ~init:(alpha, (-1,-1), (-1,-1))
            ~f:(
              fun (bestalpha, bestsrc, bestdest) (src, dest, g') ->
                let value = min_max_alpha_beta_aux g' (depth-1) Min bestalpha beta root_player |> fst_3_tuple in 
                if value > beta
                then Stop (value, src, dest)
                else 
                  begin
                    if value > bestalpha
                    then Continue (value, src, dest)
                    else Continue (bestalpha, bestsrc, bestdest)

                  end
            )
            ~finish:Fn.id
;;


let min_max_alpha_beta g depth = 
  match min_max_alpha_beta_aux g depth Max minval maxval g.turn with 
  | (_, src, dest) -> src, dest
;;