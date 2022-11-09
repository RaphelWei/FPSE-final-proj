(* 2d list operations *)

open Core;;


let get_subgrid (board : 'a list list)(i1,j1) (i2,j2) = 
  let imin = min i1 i2 in 
  let imax = max i1 i2 in 
  let jmin = min j1 j2 in 
  let jmax = max j1 j2 in 
  (* get the subgrid board[imin:imax, jmin:jmax]*)

  List.fold_left  board 
                  ~init:(0, []) 
                  ~f:(
                    fun (rowidx, acc) row -> 
                      if imin <= rowidx && rowidx < imax
                      then 
                        (rowidx + 1), List.sub row ~pos:jmin ~len:(jmax-jmin) :: acc
                      else 
                        (rowidx + 1), acc

                  )
  |> snd
;;
