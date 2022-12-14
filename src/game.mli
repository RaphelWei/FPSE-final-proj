type game = {
  board : Game_logic.boardt;
  turn : Game_logic.color (* turn=N only when the game has ended *)
} [@@deriving yojson];;

type move_result = 
  | Moved of (game, string) result
  | BlackWin of game
  | RedWin of game
;;


val init_game : unit -> game;;

(* 
  Give a game object, a source coordinate and destination coordinate
  Return 
    1. If the move is valid and the game has not ended, return Moved ( Ok (updated game) )
    2. If the move is valid and black/red wins, return BlackWin(updated game) / RedWin(updated game)
    3. If the move is invalid, return Moved (Error msg)
 *)
val update : game -> (int * int) -> (int * int) -> move_result;;


(*
  Given a game object, 
  return a list 
  [
    (int * int) : source piece
    (int * int) : destination piece
    g : updated game
  ]
  of all possible games after taking a step.board
  
  if the game is in terminal state, then return an empty list
 *)
val valid_next_steps : game -> ((int * int) * (int * int) * game) list;;
val valid_next_steps_aux : game -> (int * int) -> ((int * int) * (int * int ) * game) list;;
