type game = {
  board : Game_logic.piece list list;
  turn : Game_logic.color (* turn=N only when the game has ended *)
};;

type move_result = 
  | Moved of (game, string) result
  | BlackWin of game
  | RedWin of game
;;


val init_game : unit -> game;;

val update : game -> (int * int) -> (int * int) -> move_result;;