open Libgame;;


let update_game (g : Libgame.Game.game) move_str = 
  match Core.String.split move_str ~on:'_' |> Core.List.map ~f:(int_of_string) with 
  | m1::m2::m3::m4::[] -> 
    begin
      match Game.update g (m1-1,m2-1) (m3-1,m4-1) with 
      | Game.(Moved (Ok g')) -> 
        begin
          let new_board = Html.build_board_html_from_board g'.board in 
          g', new_board
          (* g', (string_of_int m1) ^ "_" ^ (string_of_int m2) ^ "_" ^ (string_of_int m3) ^ "_" ^ (string_of_int m4) *)
        end
      | _ -> failwith "unimplemented"
    end
  | _ -> failwith "some"




let game = ref (Game.init_game ());;

let handle_client socket =
  let game = ref (Game.init_game ()) in 
  let rec loop () =
    match%lwt Dream.receive socket with
    | Some msg ->
      let g', new_board_msg = update_game !game msg in 
              game := g';
      let%lwt () = Dream.send socket new_board_msg in 
      loop ()
    | None ->
      
      Dream.close_websocket socket
  in
  loop ()

(* let () = 
  let html = Html.build_html_from_board !game.board in 

    Dream.run
    @@ Dream.logger
    @@ Dream.router [
      Dream.get "/" (fun _ -> Dream.html html );
      Dream.get "/websocket"
      (fun _ ->
        Dream.websocket (fun websocket ->
          match%lwt Dream.receive websocket with
          | Some msg ->
            let g', new_board_msg = update_game !game msg in 
              game := g';
              Dream.send websocket new_board_msg;
          | _ ->
            Dream.close_websocket websocket));
    ]

;; *)


let () = 
  let html = Html.build_html_from_board !game.board in 

    Dream.run
    @@ Dream.logger
    @@ Dream.router [
      Dream.get "/" (fun _ -> Dream.html html );
      Dream.get "/websocket" (fun _ -> Dream.websocket handle_client);
    ]

;;

