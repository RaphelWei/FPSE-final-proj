type color =  
  | Red
  | Black 
  | N
  [@@deriving compare, yojson]
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
  [@@deriving yojson]
;;

type piece = {
  id : rank;
  color : color;
} [@@deriving yojson];;


type boardt = piece list list [@@deriving yojson];;

val get_piece_str : piece -> string;;

val opponent_color : color -> color;;

val init_board : unit -> boardt;;

(* return 
    1. Whether the move is valid
    2. The original piece at the destination
 *)
val move_pattern_valid_aux : boardt -> (bool * piece option);;
val move_range_valid_aux : boardt -> (int * int) -> (int * int) -> bool;;


(* return
    1. the src piece
    2. the destination piece
    3. whether the move is valid
  Assuming the source coordinate is valid
   *)
val move_valid : boardt -> (int * int) -> (int * int) -> (piece * piece option * bool);;


(*  attempt to move the piece at (i,j) index to (k,l) index,
    if the movement is valid, return Ok(moved board, source piece, destination piece)
    if the movement is not valid, return Error "Invalid move"
 *)
val move : boardt -> (int * int) -> (int * int) -> (piece list list * piece * piece, string) result;;



(*
  Return a list of all valid destinations given a board and a source piece
 *)
val valid_move_list : boardt -> (int * int) -> (int * int) list;;

