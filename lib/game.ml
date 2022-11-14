type game = {
  board : Game_logic.piece list list;
  turn : Game_logic.color
};;

type move_result = 
  | Moved of (game, string) result
  | BlackWin of game
  | RedWin of game
;;

let init_game () = 
  {
    board = Game_logic.init_board ();
    turn = Game_logic.Black
  }
;;


let update (g:game) src dest = 
  let open Game_logic in 
  match g, Game_logic.move g.board src dest with 
  | _, Error s -> Moved (Error s)
  | {board=_; turn=N}, _ -> failwith "Impossible"

  | {board=_; turn=Black}, Ok (_, {id=_; color=Red}, _) -> Moved (Error "You can only move your pieces")
  | {board=_; turn=Black}, Ok(b, _, {id=General;color=Red}) -> BlackWin ({board=b;turn=N})
  | {board=_; turn=Black}, Ok (b, _, _) -> Moved (Ok {board=b; turn=Red})

  | {board=_; turn=Red}, Ok (_, {id=_; color=Black}, _) -> Moved (Error "You can only move your pieces")
  | {board=_; turn=Red}, Ok(b, _, {id=General;color=Black}) -> RedWin ({board=b;turn=N})
  | {board=_; turn=Red}, Ok (b, _, _) -> Moved (Ok {board=b; turn=Black})
;;

