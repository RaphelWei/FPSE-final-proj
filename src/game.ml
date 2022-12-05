open Core;;
open Game_logic;;

type game = {
  board : Game_logic.boardt;
  turn : Game_logic.color
} [@@deriving yojson];;

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


let all_movable_pieces (g:game) = 
(* given a game object, return the coordinate of all movable pieces *)
  List.fold_left
    g.board
    ~init:(0, [])
    ~f:(
      fun (row_idx, acc) row ->
        let acc' = 
          begin
            List.fold_left
              row 
              ~init:(0, [])
              ~f:(
                fun (col_idx, coords) item ->
                  if compare_color item.color g.turn = 0 
                  then (col_idx + 1, (row_idx,col_idx)::coords)
                  else (col_idx + 1, coords)
               )
          end
          |> snd |> List.rev
        in 
        (row_idx+1, acc @ acc')
    )
  |> snd |> List.rev
;;


let valid_next_steps_aux (g : game) (src : int * int) = 
  let moves = valid_move_list g.board src in 
  List.fold_left 
    moves
    ~init:[]
    ~f:(
      fun acc dest -> 
        match update g src dest with 
        | Moved (Ok g')
        | RedWin g' 
        | BlackWin g' -> (src, dest, g') :: acc
        | _ -> failwith "valid_next_steps_aux"
    )
;;

let valid_next_steps g = 
  if compare_color g.turn N = 0 
  then []
  else 
    let movable = all_movable_pieces g in 
    List.fold_left
      movable
      ~init:[]
      ~f:(
        fun acc src -> acc @ valid_next_steps_aux g src
      )
;;
