open Libgame;;


(* let update_game (g : Libgame.Game.game) move_str = 
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
      | Game.(Moved (Error msg)) -> g, msg
      | Game.BlackWin g'-> g', "Black Win"
    end
  | _ -> failwith "some" *)

let update_game (g : Libgame.Game.game) move_str = 
  match Core.String.split move_str ~on:'_' |> Core.List.map ~f:(int_of_string) with 
  | m1::m2::m3::m4::[] -> Game.update g (m1-1,m2-1) (m3-1,m4-1)
  | _ -> failwith "impossible"




let game = ref (Game.init_game ());;

let handle_client socket =
  let game = ref (Game.init_game ()) in 
  let rec loop () =
    match%lwt Dream.receive socket with
    | Some msg ->
      begin
        (* let g', new_board_msg = update_game !game msg in 
                game := g';
        let%lwt () = Dream.send socket new_board_msg in 
        loop () *)
        match update_game (!game) msg with 
        | Game.(Moved (Ok g')) -> 
          game := g';
          let new_board_msg = Html.build_board_html_from_board g'.board in 
          let%lwt () = Dream.send socket new_board_msg in 
          loop ()
        | Game.(Moved (Error error)) ->
          let%lwt () = Dream.send socket error in 
          loop ()
        | Game.(BlackWin g') -> 
          let new_board_msg = Html.build_board_html_from_board g'.board in 
          let%lwt () = Dream.send socket new_board_msg in 
          let%lwt () = Dream.send socket "Black win" in 
          loop()
        | Game.(RedWin g') -> 
          let new_board_msg = Html.build_board_html_from_board g'.board in 
          let%lwt () = Dream.send socket new_board_msg in 
          let%lwt () = Dream.send socket "Red win" in 
          loop()
        (* | _ -> failwith "unimeplemented" *)
          
      end

    | None ->
      
      Dream.close_websocket socket
  in
  loop ()



let () = 
  let html = Html.build_html_from_board !game.board in 

    Dream.run
    @@ Dream.logger
    @@ Dream.router [
      Dream.get "/" (fun _ -> Dream.html html );
      Dream.get "/websocket" (fun _ -> Dream.websocket handle_client);
    ]

;;

