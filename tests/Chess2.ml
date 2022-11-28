open OUnit2
open Libgame

(* Utils test *)
let grid1 = [
  [1;2;3;4;5;6;7;8];
  [9;5;3;2;1;4;5;7];
  [8;3;9;9;7;6;6;4]
]
let test_get_subgrid _ = 
  assert_equal (Utils.get_subgrid grid1 (1,1)(2,5))
                [
                  [5;3;2;1;4];
                  [3;9;9;7;6]
                ];
  assert_equal (Utils.get_subgrid grid1(0,0)(2,7)) grid1;
  assert_equal (Utils.get_subgrid grid1 (2,7)(2,7)) [[4]];
  assert_equal  (Utils.get_subgrid grid1 (2,5)(1,1))
                [
                  [5;3;2;1;4];
                  [3;9;9;7;6]
                ];
  assert_equal  (Utils.get_subgrid grid1 (1,7)(1,1))
                [
                  [5;3;2;1;4;5;7]
                ]
;;

let grid2 = [
      [1;2;3;4;5;6;7];
      [7;6;5;4;3;2;1];
      [2;2;3;3;4;4;5]
    ]
let test_set_grid_idx _ = 
  assert_equal 
    (Utils.set_grid_idx grid2 (0,0) 1)
    [
      [1;2;3;4;5;6;7];
      [7;6;5;4;3;2;1];
      [2;2;3;3;4;4;5]
    ];
  assert_equal 
    (Utils.set_grid_idx grid2 (2,4) 1)
    [
      [1;2;3;4;5;6;7];
      [7;6;5;4;3;2;1];
      [2;2;3;3;1;4;5]
    ];
;;

let test_get_list_idx _ = 
  assert_equal (Utils.get_list_idx [1;2;3;4;5] 0) (Some 1);
  assert_equal (Utils.get_list_idx [1;2;3;4;5] 2) (Some 3);
  assert_equal (Utils.get_list_idx [1;2;3;4;5] 5) (None);
  assert_equal (Utils.get_list_idx [1;2;3;4;5] 6) (None);
;;

let test_get_grid_idx _ = 
  let board = [
    [1;2;3;4;5;6;7];
    [0;4;2;1;5;6;7]
  ]
  in 
  assert_equal (Utils.get_grid_idx board (0,0)) (Some 1);
  assert_equal (Utils.get_grid_idx board (1,4)) (Some 5);
  assert_equal (Utils.get_grid_idx board (3,0)) (None);
  assert_equal (Utils.get_grid_idx board (1,7)) (None);
;;





(* Game logic test *)
let test_move_pattern_valid_aux _ = 
  
  (* Chariot *)
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Chariot; color=Red}]]) (true, Some {id=Chariot; color=Red});
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Chariot; color=Red}; {id=Empty;color=N};{id=Empty;color=N};{id=Empty;color=N};{id=Soldier;color=Black}]]) 
              (true, Some {id=Soldier;color=Black});
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Chariot; color=Red}; {id=Empty;color=N};{id=Empty;color=N};{id=Empty;color=N};{id=Soldier;color=Red}]]) 
              (false, None);
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Chariot; color=Red}; {id=Empty;color=N};{id=Empty;color=N};{id=Soldier;color=Red};{id=Soldier;color=Red}]]) 
              (false, None);

  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Chariot; color=Red}]; 
                                              [{id=Empty;color=N}];
                                              [{id=Empty;color=N}];
                                              [{id=Empty;color=N}];
                                              [{id=Soldier;color=Black}]
                                            ]) (true, Some {id=Soldier;color=Black});
  
  assert_equal Game_logic.(move_pattern_valid_aux [
                                              [{id=Chariot; color=Red}]; 
                                              [{id=Empty;color=N}];
                                              [{id=Empty;color=N}];
                                              [{id=Empty;color=N}];
                                              [{id=Soldier;color=Red}]
                                            ]) (false, None);

  assert_equal Game_logic.(move_pattern_valid_aux [
                                              [{id=Chariot; color=Red}]; 
                                              [{id=Empty;color=N}];
                                              [{id=Empty;color=N}];
                                              [{id=Empty;color=N}];
                                              [{id=Soldier;color=Red}]
                                            ]) (false, None);

  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Chariot; color=Red}]; 
                                              [{id=Empty;color=N}];
                                              [{id=Empty;color=N}];
                                              [{id=Soldier;color=Red}];
                                              [{id=Soldier;color=Red}]
                                            ]) (false, None);
  
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Chariot; color=Red}; {id=Chariot; color=Black};]; 
                                              [{id=Empty;color=N}; {id=Chariot; color=Black};];
                                              [{id=Empty;color=N}; {id=Chariot; color=Black};];
                                              [{id=Soldier;color=Red}; {id=Empty; color=N};];
                                              [{id=Soldier;color=Red}; {id=Chariot; color=Black};]
                                            ]) (false, None);

  (* Ma zou ri *)
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Horse;color=Red}; {id=Empty;color=N}]; 
                                              [{id=Empty;color=N}; {id=Soldier;color=Red}]; 
                                              [{id=Empty;color=N}; {id=Horse;color=Black}]]) (true, Some {id=Horse;color=Black});

  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Horse;color=Red}; {id=Empty;color=N}]; 
                                              [{id=Soldier;color=Red}; {id=Soldier;color=Red}]; 
                                              [{id=Empty;color=N}; {id=Horse;color=Black}]]) (false, None);

  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Horse;color=Red}; {id=Empty;color=N}; {id=Empty;color=N}]; 
                                              [{id=Soldier;color=Red}; {id=Soldier;color=Red};{id=Empty;color=N}]; 
                                              [{id=Empty;color=N}; {id=Horse;color=Black};{id=Empty;color=N}]]) (false, None);

  (* Xiang fei tian *)
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Elephant;color=Red}; {id=Empty;color=N}; {id=Empty;color=N}];
                                              [{id=Chariot; color=Red}; {id=Empty;color=N}; {id=Empty;color=N}];
                                              [{id=Chariot; color=Red}; {id=Chariot; color=Red}; {id=Soldier; color=Black}]]) (true, Some {id=Soldier; color=Black});

  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Elephant;color=Red}; {id=Empty;color=N}; {id=Empty;color=N}];
                                              [{id=Chariot; color=Red}; {id=Soldier;color=Red}; {id=Empty;color=N}];
                                              [{id=Chariot; color=Red}; {id=Chariot; color=Red}; {id=Soldier; color=Black}]]) (false, None);

  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Elephant;color=Red}; {id=Empty;color=N}];
                                              [{id=Chariot; color=Red}; {id=Soldier;color=Red};];
                                              [{id=Chariot; color=Red}; {id=Chariot; color=Red};]]) (false, None);

  (* Advisor *)
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Advisor;color=Red}; {id=Empty;color=N};];
                                              [{id=Chariot;color=Red}; {id=Soldier;color=Black};]]) (true, Some {id=Soldier;color=Black});

  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Advisor;color=Red}; {id=Empty;color=N};];
                                              [{id=Chariot;color=Red}; {id=Soldier;color=Black};];
                                              [{id=Chariot;color=Red}; {id=Soldier;color=Black}]]) (false, None);

  (* General *)
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=General;color=Red}; {id=Empty;color=N};];]) (true, Some {id=Empty;color=N});
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=General;color=Red}; {id=Soldier;color=Red};];]) (false, None);
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=General;color=Red}]; 
                                                    [{id=Soldier;color=Black};];]) (true, Some {id=Soldier;color=Black});
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=General;color=Red}]; 
                                              [{id=Soldier;color=Red};];]) (false, None);
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=General;color=Red}]; 
                                              [{id=Empty;color=N}];
                                              [{id=Soldier;color=Red};];]) (false, None);

  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Cannon;color=Red}; {id=Empty;color=N}; {id=Soldier;color=Red}; {id=Empty;color=N}; {id=Soldier;color=Black}]]) (true, Some {id=Soldier;color=Black});
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Cannon;color=Red}; {id=Empty;color=N}; {id=Empty;color=N}; {id=Empty;color=N}; {id=Soldier;color=Black}]]) (false, None);
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Cannon;color=Red}; {id=Empty;color=N}; {id=Soldier;color=Red}; {id=Empty;color=N}; {id=Soldier;color=Red}]]) (false, None);
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Cannon;color=Red}]; 
                                              [{id=Empty;color=N}]; 
                                              [{id=Soldier;color=Red}];
                                              [{id=Empty;color=N}];
                                              [{id=Soldier;color=Red}]]) (false, None);
  assert_equal Game_logic.(move_pattern_valid_aux [ [{id=Cannon;color=Red}]; 
                                              [{id=Empty;color=N}]; 
                                              [{id=Soldier;color=Red}];
                                              [{id=Empty;color=N}];
                                              [{id=Soldier;color=Black}]]) (true, Some {id=Soldier;color=Black});
;;

let test_move_valid _ = 
  assert_equal 1 1;
  let board = Game_logic.init_board () in 

  (* Chariot *)

  assert_equal Game_logic.(move_valid board (0,0) (2,0)) ({id=Chariot;color=Red}, Some {id=Empty; color=N}, true);
  assert_equal Game_logic.(move_valid board (0,0) (2,1)) ({id=Chariot;color=Red}, None, false);
  assert_equal Game_logic.(move_valid board (0,0) (0,1)) ({id=Chariot;color=Red}, None, false);
  assert_equal Game_logic.(move_valid board (9,0) (7,0)) ({id=Chariot;color=Black}, Some {id=Empty; color=N}, true);
  assert_equal Game_logic.(move_valid board (9,0) (9,1)) ({id=Chariot;color=Black}, None, false);

  (* Horse *)
  assert_equal Game_logic.(move_valid board (0,1) (1,1)) ({id=Horse;color=Red}, None, false);
  assert_equal Game_logic.(move_valid board (0,1) (2,0)) ({id=Horse;color=Red}, Some {id=Empty; color=N}, true);
  assert_equal Game_logic.(move_valid board (0,1) (2,2)) ({id=Horse;color=Red}, Some {id=Empty; color=N}, true);
  assert_equal Game_logic.(move_valid board (9,1) (7,0)) ({id=Horse;color=Black}, Some {id=Empty; color=N}, true);

;;


let test_move _ = 
  let board = Game_logic.init_board () in 
  assert_equal (Game_logic.move board (0,0) (1,1)) (Error "Invalid move");

  let b1 = Utils.set_grid_idx board (2,2) {id=Horse;color=Red} in 
  assert_equal (Game_logic.move board (0,1) (2,2)) (Ok (Utils.set_grid_idx b1 (0,1) {id=Empty;color=N}, {id=Horse;color=Red}, {id=Empty; color=N}));
  (* assert_equal (Game_logic.move board (0,0) (2,0)) (Ok (Utils.set_grid_idx board (2,0) {id=Chariot;color=Red}, {id=Chariot;color=Red}, {id=Empty; color=N})); *)
  assert_equal (Game_logic.move board (0,0) (3,0)) (Error "Invalid move");
;;


let test_valid_move_list _ =  
  let board = Game_logic.init_board () in 
  assert_equal 1 1;
  assert_equal (Game_logic.valid_move_list board (0,0) ) [(1,0);(2,0)]
;;

let test_valid_next_steps_aux _ = 
  let g = Game.init_game () in 
  assert_equal (Game.valid_next_steps_aux g (9,0) |> List.length) 2;
  assert_equal (Game.valid_next_steps_aux g (7,1) |> List.length) 12;
  assert_equal (Game.valid_next_steps_aux g (6,0) |> List.length) 1;
  assert_equal (Game.valid_next_steps_aux g (9,2) |> List.length) 2;
;;

let utils_tests = 
  "utils tests" >: test_list
  [
    "get_subgrid" >:: test_get_subgrid;
    "set_grid_idx" >:: test_set_grid_idx;
    "get_list_idx" >:: test_get_list_idx;
    "get_board_idx" >:: test_get_grid_idx
  ]
let game_logic_tests = 
  "game logic tests" >: test_list
  [
    "move_pattern_valid_aux" >:: test_move_pattern_valid_aux;
    "move_pattern_valid" >:: test_move_valid;
    "move" >:: test_move;
    "valid_move_list" >:: test_valid_move_list;
    "valid_next_steps_aux" >:: test_valid_next_steps_aux
  ]

let series = "">::: [game_logic_tests; utils_tests]

let () = run_test_tt_main series