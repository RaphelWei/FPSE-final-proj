val get_subgrid : 'a list list -> (int * int) -> (int * int) -> 'a list list;;

(* set the ij index of the grid as the given element *)
val set_grid_idx : 'a list list -> (int * int) -> 'a -> 'a list list;;

val get_list_idx : 'a list -> int -> 'a option;;

val get_grid_idx : 'a list list -> (int * int) -> 'a option;;

val range : int -> int -> int list;;

(* val not : bool -> bool;; *)
