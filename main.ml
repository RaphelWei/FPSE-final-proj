let board = Libgame.Game.init_board ();;

(* let h = Libgame.Game.build_html_from_board board *)
let h = Libgame.Html.build_html_from_board board;;


let () = 
  Dream.run @@
  Dream.logger @@ 
  Dream.router [
    Dream.get "/" 
    (
      fun _ -> Dream.html h
    );
  ]