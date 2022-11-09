open Core;;

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

type stone = (stone_type * color)

let different_color s1 s2 =
    match s1, s2 with
    | (_, Black), (_, Black)
    | (_, Red), (_, Red)
    | (_, N), (_, N) -> false
    | _ -> true

let init_board () = 
  [
    [(Che,Red);   (Ma,Red);   (Xiang,Red);    (Shi,Red);    (Jiang,Red);    (Shi,Red);    (Xiang,Red);    (Ma,Red);     (Che,Red)];
    [(Empty,N);   (Empty,N);  (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N)];
    [(Empty,N);   (Pao,Red);  (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N);      (Pao,Red);    (Empty,N)];
    [(Zu,Red);    (Empty,N);  (Zu,Red);       (Empty,N);    (Zu,Red);       (Empty,N);    (Zu,Red);       (Empty,N);    (Zu,Red)];
    [(Empty,N);   (Empty,N);  (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N)];

    [(Empty,N);   (Empty,N);  (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N)];
    [(Zu,Black);   (Empty,N);  (Zu,Black);      (Empty,N);    (Zu,Black);      (Empty,N);    (Zu,Black);      (Empty,N);    (Zu,Black)];
    [(Empty,N);   (Pao,Black); (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N);      (Pao,Black);   (Empty,N)];
    [(Empty,N);   (Empty,N);  (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N);      (Empty,N);    (Empty,N)];
    [(Che,Black);  (Ma,Black);  (Xiang,Black);   (Shi,Black);   (Jiang,Black);   (Shi,Black);   (Xiang,Black);   (Ma,Black);    (Che,Black)];
  ]




let get_piece_str p = 
  match fst p with 
  | Empty -> ""
  | Che -> "車"
  | Ma -> "傌"
  | Xiang -> "相"
  | Shi -> "仕"
  | Jiang -> "帅"
  | Pao -> "炮"
  | Zu -> "兵"

let get_piece_color p = 
  match snd p with 
  | Red -> "red"
  | Black -> "black"
  | N -> "red"



let move_valid_aux subgrid = 
    (* 
        Validate the pattern of stone movement, and do not take care of the absolute movement
        Assume the subgrid is well-shaped ( a rectangle )
        and the move is from the upper-left corner to lower-right corner *)
    match subgrid with 

    (* Che can only move vertically or horizontally *)
    | [(Che, c)::t] ->
        (* move horizontally *)
        begin
            match List.rev t with 
            | [] -> true
            | h::t_ -> 
                if different_color (Che,c) h 
                    && Core.List.for_all t_ ~f:(function | (Empty, N) -> true | _ -> false)
                then true
                else false

        end
        (* Move vertically *)
    | [(Che, c)]::t -> 
        begin
            match List.rev t with 
            | [] -> true
            | [st]::t_ -> 
                if different_color (Che,c) st 
                    && Core.List.for_all t_  ~f:(function | [(Empty, N)] -> true | _ -> false)
                then true
                else false
            | _ -> false
        end
    

    (* Ma zou ri *)
    | [ [(Ma,c);        _];
        [(Empty,N);     _];
        [_;             st]]
        
    
    (* Xiang fei tian *)
    | [ [(Xiang, c);            _;  _]; 
        [_;             (Empty,N);  _];
        [_;                     _;  st]] 

    (* Shi diagonal *)
    | [ [(Shi,c); _];
        [_;       st]]


    (* Jiang *)
    | [ [(Jiang, c) ];
        [st         ]]

    | [[(Jiang, c); st]] -> 
    
        if different_color (Ma,c) st 
        then true 
        else false
    
    (* Ge shan pao *)
    | [(Pao, c)::t] ->
        begin
        match List.rev t with 
        | [] -> true
        | h::t_ ->
            if different_color h (Pao,c)
                && List.count t_ ~f:(function | (Empty,N) -> false | _ -> true) = 1
            then true
            else false
        end
    
    | [(Pao,c)]::t -> 
        begin
            match List.rev t with 
            | [] -> true
            | [st]::t_ ->
                if different_color st (Pao,c) 
                    && List.count t_ ~f:(function | [(Empty,N)] -> false | _ -> true) = 1
                then true 
                else false
            | _ -> false
        end
    
    | _ -> false

