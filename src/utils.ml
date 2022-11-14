open Core;;

let get_subgrid (board : 'a list list) (i1,j1) (i2,j2) = 
  let imin = min i1 i2 in 
  let imax = max i1 i2 in 
  let jmin = min j1 j2 in 
  let jmax = max j1 j2 in 
  (* get the subgrid board[imin:imax+1, jmin:jmax+1]*)

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


let set_list_idx l idx elem =   
(* set the ij index of the list as the given element *)
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