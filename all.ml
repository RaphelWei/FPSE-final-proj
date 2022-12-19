open Libgame;;

let update_game (g : Libgame.Game.game) move_str = 
  match Core.String.split move_str ~on:'_' |> Core.List.map ~f:(int_of_string) with 
  | m1::m2::m3::m4::[] -> Game.update g (m1-1,m2-1) (m3-1,m4-1)
  | _ -> failwith "impossible"
;;


let handle_client_pve socket =
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
          (* game := g';
          let new_board_msg = Html.build_board_html_from_board g'.board in 
          let%lwt () = Dream.send socket new_board_msg in  *)
          let (i1,j1), (i2,j2) = Libgame.Ai.min_max_alpha_beta g' 4 in 
          begin 
            match Game.update g' (i1,j1) (i2,j2) with  
            | Moved (Ok g'') -> 
              game := g'';
              let new_board_msg = Html.build_board_html_from_board g''.board in 
              let%lwt () = Dream.send socket new_board_msg in 
              loop()
            | Game.(BlackWin g'') -> 
              let new_board_msg = Html.build_board_html_from_board g''.board in 
              let%lwt () = Dream.send socket new_board_msg in 
              let%lwt () = Dream.send socket "Black win" in 
              loop()
            | Game.(RedWin g'') -> 
              let new_board_msg = Html.build_board_html_from_board g''.board in 
              let%lwt () = Dream.send socket new_board_msg in 
              let%lwt () = Dream.send socket "Red win" in 
              loop()
            | _ -> failwith ""
          end
          (* loop () *)
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
;;

let handle_client_pvp socket =
  let game = ref (Game.init_game ()) in 
  let rec loop () =
    match%lwt Dream.receive socket with
    | Some msg ->
      begin

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
;;

let () = 
  let game = ref (Game.init_game ()) in 
  Dream.run
  @@ Dream.logger
  @@ Dream.router[
    Dream.get "/index" (fun _ -> Libgame.Html.build_index_page () |> Dream.html);

    Dream.get "/pve" (fun _ -> Libgame.Html.build_html_from_board (!game.board) "pve" |> Dream.html );
    Dream.get "/websocket/pve" (fun _ -> Dream.websocket handle_client_pve);

    Dream.get "/pvp" (fun _ -> Libgame.Html.build_html_from_board (!game.board) "pvp" |> Dream.html );
    Dream.get "/websocket/pvp" (fun _ -> Dream.websocket handle_client_pvp);
  ]