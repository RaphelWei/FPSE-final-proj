open Core;;

[@@@coverage off]
type color =  
  | Red
  | Black 
  | N 
  [@@deriving compare, yojson]
;;
[@@@coverage on]




[@@@coverage off]
type rank = 

  | General        (* 帥/將 *) 
  | Advisor        (* 仕/士 *)   
  | Elephant       (* 相/象 *) 
  | Horse          (* 傌/馬 *) 
  | Chariot        (* 俥/車 *) 
  | Cannon         (* 炮/砲 *) 
  | Soldier        (* 兵/卒 *) 
  | Empty 
  [@@deriving yojson]
;;
 [@@@coverage on]

[@@@coverage off]
type piece = {
  id : rank;
  color : color;
} [@@deriving yojson][@@coverage off];;

type boardt = piece list list [@@deriving yojson];;
[@@@coverage on]

[@@@coverage off]
let get_piece_str p = 
  
  match p with 
  | {id=General; color=Red} -> "帥"
  | {id=General; color=Black} -> "將"

  | {id=Advisor; color=Red} -> "仕"
  | {id=Advisor; color=Black} -> "士"

  | {id=Elephant; color=Red} -> "相"
  | {id=Elephant; color=Black} -> "象"

  | {id=Horse; color=Red} -> "傌"
  | {id=Horse; color=Black} -> "馬"

  | {id=Chariot; color=Red} -> "俥"
  | {id=Chariot; color=Black} -> "車"

  | {id=Cannon; color=Red} -> "炮"
  | {id=Cannon; color=Black} -> "砲"

  | {id=Soldier; color=Red} -> "兵"
  | {id=Soldier; color=Black} -> "卒"

  | {id=Empty; color=N} -> " + "
  | _ -> failwith "possible"
;;
[@@@coverage on]


let opponent_color = function Red -> Black | Black -> Red | N -> failwith "Impossible"

let init_board () = 
  (*
    ---------> y
    |
    |
    |
    |
    v x

    starting at (0,0)
   *)
  [
    [{id=Chariot;color=Red};    {id=Horse;color=Red};     {id=Elephant;color=Red};    {id=Advisor;color=Red};   {id=General;color=Red};     {id=Advisor;color=Red};   {id=Elephant;color=Red};      {id=Horse;color=Red};       {id=Chariot;color=Red};];
    [{id=Empty; color=N};       {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};          {id=Empty; color=N};        {id=Empty; color=N};];
    [{id=Empty; color=N};       {id=Cannon; color=Red};   {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};          {id=Cannon; color=Red};     {id=Empty; color=N};];
    [{id=Soldier; color=Red};   {id=Empty; color=N};      {id=Soldier; color=Red};    {id=Empty; color=N};      {id=Soldier; color=Red};    {id=Empty; color=N};      {id=Soldier; color=Red};      {id=Empty; color=N};        {id=Soldier; color=Red};];
    [{id=Empty; color=N};       {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};          {id=Empty; color=N};        {id=Empty; color=N};];
 
    [{id=Empty; color=N};       {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};          {id=Empty; color=N};        {id=Empty; color=N};];
    [{id=Soldier; color=Black}; {id=Empty; color=N};      {id=Soldier; color=Black};  {id=Empty; color=N};      {id=Soldier; color=Black};  {id=Empty; color=N};      {id=Soldier; color=Black};    {id=Empty; color=N};        {id=Soldier; color=Black};];
    [{id=Empty; color=N};       {id=Cannon; color=Black}; {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};          {id=Cannon; color=Black};   {id=Empty; color=N};];
    [{id=Empty; color=N};       {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};        {id=Empty; color=N};      {id=Empty; color=N};          {id=Empty; color=N};        {id=Empty; color=N};];
    [{id=Chariot;color=Black};  {id=Horse;color=Black};   {id=Elephant;color=Black};  {id=Advisor;color=Black}; {id=General;color=Black};   {id=Advisor;color=Black}; {id=Elephant;color=Black};    {id=Horse;color=Black};     {id=Chariot;color=Black};];
    
  ]
;;


let move_pattern_valid_aux (subgrid : boardt)= 
    (* 
        Validate the pattern of stone movement, and do not take care of the absolute movement
        Assume the subgrid is well-shaped ( a rectangle )
        and the move is from the upper-left corner to lower-right corner *)
    match subgrid with 

    (* Chariot can only move vertically or horizontally *)
    | [{id=Chariot; color}::t] ->
        (* move horizontally *)
        begin
            match List.rev t with 
            | [] -> (true,Some {id=Chariot; color})
            | h::t_ -> 
                if Int.(compare_color color h.color <> 0)
                    && Core.List.for_all t_ ~f:(function | {id=Empty; color=N} -> true | _ -> false)
                then (true,Some h)
                else (false, None)

        end
        (* Move vertically *)
    | [{id=Chariot; color}]::t -> 
        begin
            match List.rev t with 
            | [] -> (true,Some {id=Chariot; color})
            | [st]::t_ -> 
                if Int.(compare_color color st.color <> 0)
                    && Core.List.for_all t_  ~f:(function | [{id=Empty; color=N}] -> true | _ -> false)
                then (true,Some st)
                else (false,None)
            | _ -> (false,None)
        end

    (* Ma zou ri *)
    | [ [{id=Horse; color};       _];
        [{id=Empty; color=N};     _];
        [_;                     st]]
        
    
    (* Xiang fei tian *)
    | [ [{id=Elephant; color};   _;                   _]; 
        [_;                     {id=Empty;color=N};   _];
        [_;                     _;                   st]] 

    (* Shi diagonal *)
    | [ [{id=Advisor;color};  _];
        [_;                   st]]


    (* Jiang *)
    | [ [{id=General;color} ];
        [st         ]]

    | [[{id=General;color}; st]] 

    (* Zu *)
    | [[{id=Soldier;color};st]]
    | [ [{id=Soldier;color}];
        [st] ]
    -> 
    
        if compare_color color st.color <> 0
        then (true, Some st )
        else (false, None)



    (* Ge shan pao *)
    | [{id=Cannon;color}::t] ->
        begin
        match List.rev t with 
        | [] -> (true, Some {id=Cannon;color})
        | h::t_ ->
            if (compare_color (opponent_color color) h.color = 0
                && List.count t_ ~f:(function | {id=Empty;color=N} -> false | _ -> true) = 1
            ) || (
              List.for_all t ~f:(function | {id=Empty;color=N} -> true | _ -> false)
            )
            then (true, Some h)
            else (false, None)
        end
    
    | [{id=Cannon;color}]::t -> 
        begin
            match List.rev t with 
            | [] -> (true, Some {id=Cannon;color})
            | [st]::t_ ->
                if (compare_color (opponent_color color) st.color = 0 
                    && List.count t_ ~f:(function | [{id=Empty;color=N}] -> false | _ -> true) = 1
                ) || (
                  List.for_all t ~f:(function | [{id=Empty;color=N}] -> true | _ -> false)
                )
                then (true, Some st)
                else (false, None)
            | _ -> (false, None)
        end

    | _ -> (false, None)
;;


let move_range_valid_aux (subgrid : boardt) (i1,j1) (i2,j2) = 
  match subgrid with 

  (* Elephant cannot pass the river *)
  | ({id=Elephant; color=Red}::_)::_ ->
    if i2 >= 5 then false else true
  | ({id=Elephant; color=Black}::_)::_ -> 
    if i2 <= 4 then false else true

  (* Advisor and General cannot exit the Camp *)
  | ({id=Advisor; color=Red}::_)::_
  | ({id=General; color=Red}::_)::_ ->
    if 0 <= i2 && i2 <= 2 && 3 <= j2 && j2 <= 5
    then true
    else false

  | ({id=Advisor; color=Black}::_)::_
  | ({id=General; color=Black}::_)::_ ->
    if 7 <= i2 && i2 <= 9 && 3 <= j2 && j2 <= 5
    then true
    else false
  
  | ({id=Soldier; color=Red}::_)::_ ->
    if i1 <= 4 
    then 
      begin
        if i2 >= i1 && j2 = j1 then true else false
      end
    else
      begin 
        if i2 >= i1 then true else false
      end 

  | ({id=Soldier; color=Black}::_)::_ ->
    if i1 >= 4 
    then 
      begin
        if i2 <= i1 && j2 = j1 then true else false
      end
    else
      begin 
        if i2 <= i1 then true else false
      end 

  

  | _ -> true
;;


let valid_pos (i,j) = 
  (* whether (i,j) is a position in board *)
  if 0 <= i && i <= 9 && 0 <= j && j <= 8
  then true
  else false
;;


let move_valid (board : boardt) (i1,j1) (i2,j2) =
  let subgrid = 
    Utils.get_subgrid board (i1,j1) (i2,j2)
    |> (fun x -> if i1 <= i2 then x else List.rev x)
    |> (fun x -> if j1 <= j2 then x else List.map x ~f:List.rev)
  in  
  let pattern_valid, pc = move_pattern_valid_aux subgrid in
  let valid = 
    Bool.(<>) (i1=i2 && j1=j2) true && (* not moving is not allowed *)
    valid_pos (i1,j1) && 
    valid_pos (i2,j2) && 
    pattern_valid && 
    (move_range_valid_aux subgrid (i1,j1) (i2,j2)) 
  in 
  match subgrid with 
  | (h::_)::_ -> (h, pc, valid)
  | _ -> failwith "impossible" [@coverage off]
;;

let move board src dest = 
  let pc_src, pc_dest, valid =  move_valid board src dest in 

  match (valid, pc_dest) with 
  | true, Some pc -> 
    begin 
      let b = Utils.set_grid_idx board dest pc_src in 
      let b' =  Utils.set_grid_idx b src {id=Empty;color=N} in 
      Ok (b', pc_src, pc)
    end
  | false, _ -> Error "Invalid move"
  | _ -> failwith "Impossible" [@coverage off]
;;

let valid_move_list board (i,j) = 
  let moves = 
    match Utils.get_grid_idx board (i,j) with 
    | Some {id=General;_}
    | Some {id=Soldier;_} -> [(i-1,j);(i+1,j);(i,j-1);(i,j+1)]
    | Some {id=Advisor;_} -> [(i-1,j-1);(i-1,j+1);(i+1,j-1);(i+1,j+1)]
    | Some {id=Elephant;_} -> [(i-2,j-2);(i-2,j+2);(i+2,j-2);(i+2,j+2)]
    | Some {id=Horse;_} -> [(i-1,j-2);(i-2,j-1);
                            (i-1,j+2);(i-2,j+1);
                            (i+1,j-2);(i+2,j-1);
                            (i+1,j+2);(i+2,j+1)]
    | Some {id=Chariot;_}
    | Some {id=Cannon;_} -> 
        let is = Utils.range 0 10 in 
        let js = Utils.range 0 9 in 
        List.map is ~f:(fun x -> (x,j)) @ List.map js ~f:(fun x -> (i,x))
    | Some {id=Empty;_} -> []
    | None -> failwith "valid_move_list: attempt to move a piece that's not in the board"
  in 
  moves 
  |> List.filter ~f:valid_pos
  |> List.filter ~f:(fun dest -> 
                          let _,_, v = move_valid board (i,j) dest in v)
;;