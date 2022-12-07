open Core
open Dream

let clients : (int, Dream.websocket) Hashtbl.t =
  Hashtbl.create 5

let sessions : (int, Dream.session) Hashtbl.t =
  Hashtbl.create 5

let game_id = ref 0

let games : (int, Game.game) Hashtbl.t =
  Hashtbl.create 5
let session_id =
  Dream.cookie "session_id"

let track =
  let last_client_id = ref 0 in
  fun websocket ->
    last_client_id := !last_client_id + 1;
    Hashtbl.replace clients !last_client_id websocket;
    !last_client_id

let forget client_id =
  Hashtbl.remove clients client_id

let handle_client client =
  let client_id = track client in
  let rec loop () =
    match%lwt Dream.receive client with
    | Some message ->
      let%lwt () = send message in
      loop ()
    | None ->
      forget client_id;
      Dream.close_websocket client
  in
  loop ()

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [

    Dream.get "/"
      (fun _ -> Dream.html home);

    Dream.get "/websocket"
      (fun _ -> Dream.websocket handle_client);

  ]