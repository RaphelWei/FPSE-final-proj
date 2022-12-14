open Libgame;;
(* open Dream;; *)


let () = 
  let game = Game.init_game () in 
  let html = Html.build_html_from_board game.board in 

    Dream.run
    @@ Dream.logger
    @@ Dream.router [
      Dream.get "/" (fun _ -> Dream.html html );
      Dream.get "/websocket"
      (fun _ ->
        Dream.websocket (fun websocket ->
          match%lwt Dream.receive websocket with
          | Some msg ->
            Core.Printf.printf "%s\n" msg;
            Dream.send websocket msg;
          | _ ->
            Dream.close_websocket websocket));
    ]

;;

(* let game = Game.init_game () in 
  let html = Html.build_html_from_board game.board in 
  print_string html
;; *)