open Game_logic
(* open Game *)


val minval : int;;
val maxval : int;;

type minmax = 
  | Min 
  | Max
;;

val piece_weight : piece -> int;;


(*
  Given a board, evaluate the weight sum of red pieces and black pieces
 *)
val evaluate_board : piece list list -> (int * int);;


(*
  Given a game instance and an agent instance, 
  return a AI move which consists of a source piece and destination piece,
  the generated move is guaranteed to be valid
 *)
(* val generate_move : (piece list list) -> agent -> (int * int) -> (int * int);; *)


val naive_min_max : Game.game -> int -> (int * int) * (int * int);;

val min_max_alpha_beta_aux : Game.game -> int -> minmax -> int -> int -> color -> (int * (int * int) * (int * int));;

val min_max_alpha_beta : Game.game -> int -> (int * int) * (int * int);;
