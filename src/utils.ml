open Core;;

(* get the subgrid board[imin:imax+1, jmin:jmax+1] between two positions (current and next)*)
let get_subgrid (board : 'a list list) (i1,j1) (i2,j2) = 
  let imin = min i1 i2 in 
  let imax = max i1 i2 in 
  let jmin = min j1 j2 in 
  let jmax = max j1 j2 in 

  List.fold_left 
        board
        ~init:(0,[])
        ~f:(
          fun (rowidx, acc) row -> 
            if imin <= rowidx && rowidx <= imax
            then 
              (rowidx + 1), List.sub row ~pos:jmin ~len:(jmax-jmin+1) :: acc
            else 
              (rowidx + 1), acc
        )
  |> snd
  |> List.rev
;;

(* set the ij index of the list as the given element *)
let set_list_idx l idx elem =   
  List.fold_left
          l
          ~init:(0,[])
          ~f:(
            fun (i,acc) item -> 
              if i <> idx
              then i + 1, item :: acc 
              else i + 1, elem :: acc 
          )
  |> snd
  |> List.rev
;;

(* returns a new grid with location (i, j) updated *)
(* assumes i and j are valid indices *)
let set_grid_idx (board : 'a list list) (i,j) elem = 
  List.fold_left
          board
          ~init:(0,[])
          ~f:(
            fun (idx, acc) item ->
              if i <> idx 
              then idx+1, item::acc
              else idx+1, (set_list_idx item j elem)::acc
          )
  |> snd
  |> List.rev
;;

(* retrieve an optioanl elem from list *)
let get_list_idx l idx = 
  List.fold_until
            l 
            ~init:(0,None)
            ~f:(
              fun (i, _) item -> 
                if i = idx
                then Stop (i, Some item)
                else Continue (i+1, None)
            )
            ~finish:Fn.id
  |> snd
;;

(* retrieve an optioanl elem from broad *)
let get_grid_idx board (i,j) = 
  List.fold_until
            board
            ~init:(0,None)
            ~f:(
              fun (idx,_) row ->
                if idx = i
                then Stop (idx, get_list_idx row j)
                else Continue (idx + 1, None)
            )
            ~finish:Fn.id
  |> snd
;;

let range start _end = 
  List.init (_end-start) ~f:(fun x->start + x)


(* returns a list of all pieces on the board of the given color*)
let get_pieces board color = 
  List.fold_left
          board
          ~init:[]
          ~f:(
            fun acc row -> 
              List.fold_left
                      row
                      ~init:acc
                      ~f:(
                        fun acc item -> 
                          match item with 
                          | Some (c,_) when c = color -> item :: acc
                          | _ -> acc
                      )
          )
  |> List.rev
;;



let opposite_color color = 
  match color with 
  | Red -> Black
  | Black -> Red
;;

(* returns a list of all possible moves for a given piece *)
