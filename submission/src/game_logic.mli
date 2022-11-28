type color =  
  | Red
  | Black 
  | N
  [@@deriving compare]
;;

type rank = 
  | General        (* 帥/將 *)
  | Advisor        (* 仕/士 *)     
  | Elephant       (* 相/象 *)
  | Horse          (* 傌/馬 *)
  | Chariot        (* 俥/車 *)
  | Cannon         (* 炮/砲 *)
  | Soldier        (* 兵/卒 *)
  | Empty
;;

type piece = {
  id : rank;
  color : color;
};;

val get_piece_str : piece -> string;;

val opponent_color : color -> color;;

val init_board : unit -> piece list list;;

(* return 
    1. Whether the move is valid
    2. The original piece at the destination
 *)
val move_pattern_valid_aux : piece list list -> (bool * piece option);;
val move_range_valid_aux : piece list list -> (int * int) -> (int * int) -> bool;;


(* return
    1. the src piece
    2. the destination piece
    3. whether the move is valid
  Assuming the source coordinate is valid
   *)
val move_valid : piece list list -> (int * int) -> (int * int) -> (piece * piece option * bool);;


(*  attempt to move the piece at (i,j) index to (k,l) index,
    if the movement is valid, return Ok(moved board, source piece, destination piece)
    if the movement is not valid, return Error "Invalid move"
 *)
val move : piece list list -> (int * int) -> (int * int) -> (piece list list * piece * piece, string) result;;



(*
  Return a list of all valid destinations given a board and a source piece
 *)
val valid_move_list : piece list list -> (int * int) -> (int * int) list;;

