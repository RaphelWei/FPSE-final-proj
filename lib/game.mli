type color = 
  | Red
  | Black
  | N
;;

type stone_type = 
  | Che 
  | Ma
  | Xiang 
  | Shi
  | Jiang
  | Pao
  | Zu
  | Empty
;;

type stone 

(* val valid_moves : (stone list list) -> (int * int) -> (int * int) -> (int * int) list *)

val init_board : unit -> (stone_type * color) list list

val get_piece_str : (stone_type * color) -> string

val get_piece_color : (stone_type * color) -> string

val move_valid_aux : (stone_type * color) list list -> bool

val move_valid : (stone_type)
