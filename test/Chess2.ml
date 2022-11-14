open OUnit2
open Libgame

(* Utils test *)
let test_get_subgrid _ = 
  assert_equal (Utils.get_subgrid 
                [
                  [1;2;3;4;5;6;7;8];
                  [9;5;3;2;1;4;5;7];
                  [8;3;9;9;7;6;6;4]
                ]
                (1,1)
                (2,5))
                [
                  [5;3;2;1;4];
                  [3;9;9;7;6]
                ]
                
;;

let test_set_grid_idx _ = 
  let grid = [
      [1;2;3;4;5;6;7];
      [7;6;5;4;3;2;1];
      [2;2;3;3;4;4;5]
    ]
  in 
  assert_equal 
    (Utils.set_grid_idx grid (0,0) 1)
    [
      [1;2;3;4;5;6;7];
      [7;6;5;4;3;2;1];
      [2;2;3;3;4;4;5]
    ];
  assert_equal 
    (Utils.set_grid_idx grid (2,4) 1)
    [
      [1;2;3;4;5;6;7];
      [7;6;5;4;3;2;1];
      [2;2;3;3;1;4;5]
    ];
;;

(* Game logic test *)
let test_move_pattern_valid_aux _ = 
  
  (* Chariot *)
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Chariot; color=Red}]]) (true, Some {id=Chariot; color=Red});
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Chariot; color=Red}; {id=Empty;color=N};{id=Empty;color=N};{id=Empty;color=N};{id=Soldier;color=Black}]]) (true, Some {id=Soldier;color=Black});
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Chariot; color=Red}; {id=Empty;color=N};{id=Empty;color=N};{id=Empty;color=N};{id=Soldier;color=Red}]]) (false, None);
  assert_equal Game_logic.(move_pattern_valid_aux [[{id=Chariot; color=Red}; {id=Empty;color=N};{id=Empty;color=N};{id=Soldier;color=Red};{id=Soldier;color=Red}]]) (false, None);

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
  assert_equal Game_logic.(move_valid board (9,0) (9,0)) ({id=Chariot;color=Black}, Some {id=Chariot;color=Black}, true);

  (* Horse *)
  assert_equal Game_logic.(move_valid board (0,1) (1,1)) ({id=Horse;color=Red}, None, false);
  assert_equal Game_logic.(move_valid board (0,1) (2,0)) ({id=Horse;color=Red}, Some {id=Empty; color=N}, true);
  assert_equal Game_logic.(move_valid board (0,1) (2,2)) ({id=Horse;color=Red}, Some {id=Empty; color=N}, true);
  assert_equal Game_logic.(move_valid board (9,1) (7,0)) ({id=Horse;color=Black}, Some {id=Empty; color=N}, true);

;;


let test_move _ = 
  let board = Game_logic.init_board () in 
  assert_equal (Game_logic.move board (0,0) (1,1)) (Error "Invalid move");
  assert_equal (Game_logic.move board (0,1) (2,2)) (Ok (Utils.set_grid_idx board (2,2) {id=Horse;color=Red}, {id=Horse;color=Red}, {id=Empty; color=N}));
  assert_equal (Game_logic.move board (0,0) (2,0)) (Ok (Utils.set_grid_idx board (2,0) {id=Chariot;color=Red}, {id=Chariot;color=Red}, {id=Empty; color=N}));
  assert_equal (Game_logic.move board (0,0) (3,0)) (Error "Invalid move");
;;

let utils_tests = 
  "utils tests" >: test_list
  [
    "get_subgrid" >:: test_get_subgrid;
    "set_grid_idx" >:: test_set_grid_idx
  ]
let game_logic_tests = 
  "game logic tests" >: test_list
  [
    "move_pattern_valid_aux" >:: test_move_pattern_valid_aux;
    "move_pattern_valid" >:: test_move_valid;
    "move" >:: test_move
  ]

let series = "">::: [game_logic_tests; utils_tests]

let () = run_test_tt_main series