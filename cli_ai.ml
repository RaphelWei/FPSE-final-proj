open Core;;
open Libgame.Game;;
open Libgame.Game_logic;;
open Libgame.Ai;;


let color_str c = 
  match c with 
    | Black -> "\027[30m " (* "\027[32m " *)
    | Red -> "\027[31m " (* "\027[31m " *)
    | N -> "\027[37m" (* "\027[0m" *)
;;

let build_piece_str p = 
  let color_str = color_str p.color in
  let rank_str = get_piece_str p in 
  color_str ^ " " ^ rank_str
;;

let build_row (l : piece list) = 
  List.fold_left
          l
          ~init:""
          ~f:(fun acc item -> acc ^ build_piece_str item)
  |> fun x -> x ^ "\n"
;;




let build_board_str (g : game) = 
  let c = color_str g.turn ^ "*"in 
  List.fold_left
         g.board
          ~init:(0, "")
          ~f:(
            fun (idx, acc) row -> 
              if idx = 5
              then (idx + 1, acc ^  color_str N ^ "------------------------------------\n" ^ 
                                    "            楚河       汉界   " ^ c ^  "     \n" ^ 
                                    color_str N ^ "------------------------------------\n" ^
                                    build_row row)
              else (idx + 1, acc ^ build_row row)
          )
  |> snd
  |> fun x -> x ^ color_str N
;;

let parse string = Scanf.sscanf string "(%d,%d) (%d,%d)" (fun a b c d -> a,b,c,d )

let () = 
  let g = ref (init_game ()) in 
  let endgame = ref false in 
  !g |> build_board_str |> print_string;
  print_string "\n";
  print_string "\n";
  while not !endgame do 
    let (i1,j1), (i2,j2) = 
      if compare_color !g.turn Black = 0
        
      then 
        let s = Caml.read_line () in 
        let (i1,j1,i2,j2) = parse s in 
        (i1,j1), (i2,j2)
      else 
        naive_min_max !g 2
    in 

    match update !g (i1,j1) (i2,j2) with 
    | BlackWin g ->  
        g |> build_board_str |> print_string; 
        Printf.printf "Black Wins ! \n"; endgame := true
    | RedWin g -> 
        g |> build_board_str |> print_string;
        Printf.printf "Red Wins ! \n"; endgame := true
    | Moved (Error msg) -> Printf.printf "%s!\n" msg;
    | Moved (Ok g') -> 
        g' |> build_board_str |> print_string; 
        print_string "\n";
        print_string "\n";
        g := g';
  done

;;

