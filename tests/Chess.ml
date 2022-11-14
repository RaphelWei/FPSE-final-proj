open OUnit2;;
open Libgame


let test_move_valid_aux _ = 
  assert_equal 1 1;

  (* Che *)
  assert_equal Game.(move_valid_aux [[(Che,Red)]]) true;
  assert_equal Game.(move_valid_aux [[(Che,Red); (Empty,N); (Empty,N); (Zu, Black)]]) true;
  assert_equal Game.(move_valid_aux [[(Che,Black); (Empty,N); (Empty,N); (Zu, Red)]]) true;
  assert_equal Game.(move_valid_aux [[(Che,Black); (Empty,N); (Zu,Red); (Zu, Red)]]) false;

  assert_equal Game.(move_valid_aux [ [(Che, Black)]; 
                                      [(Empty, N)]; 
                                      [(Empty, N)]; 
                                      [(Zu,Red)]]) true;
  assert_equal Game.(move_valid_aux [ [(Che, Black)]; 
                                      [(Empty, N)]; 
                                      [(Empty, N)]; 
                                      [(Empty,N)]]) true;
  assert_equal Game.(move_valid_aux [ [(Che, Black)]; 
                                      [(Empty, N)]; 
                                      [(Che, Red)]; 
                                      [(Empty,N)]; 
                                      [(Zu,Red)]]) false;
  assert_equal Game.(move_valid_aux [ [(Che, Black); (Empty,N)]; 
                                      [(Empty, N); (Empty,N)]; 
                                      [(Che, Red); (Empty,N)]; 
                                      [(Empty,N); (Empty,N)]; 
                                      [(Zu,Red); (Empty,N)]]) false;


  (* Ma zou ri *)
  assert_equal Game.(move_valid_aux [ [(Ma, Red); (Empty, N)]; 
                                      [(Empty,N); (Zu, Red)]; 
                                      [(Empty,N); (Ma,Black)]]) true;
  assert_equal Game.(move_valid_aux [ [(Ma, Red); (Empty, N)]; 
                                      [(Zu,Red);  (Zu, Red)]; 
                                      [(Empty,N); (Ma,Black)]]) false; (* ban ma tui *)
  assert_equal Game.(move_valid_aux [ [(Ma, Red); (Empty, N); (Empty,N)]; 
                                      [(Zu,Red);  (Zu, Red);  (Empty,N)]; 
                                      [(Empty,N); (Ma,Black); (Empty,N)]]) false; (* ban ma tui *)

  (* Xiang fei tian *)
  assert_equal Game.(move_valid_aux [ [(Xiang, Red); (Empty,N); (Zu, Red)];
                                      [(Che, Red);   (Empty,N); (Empty, N)];
                                      [(Che, Black); (Empty,N); (Zu, Black)]]) true;
                              
  assert_equal Game.(move_valid_aux [ [(Xiang, Red); (Empty,N); (Zu, Red)];
                                      [(Che, Red);   (Zu, Red); (Empty, N)];
                                      [(Che, Black); (Empty,N); (Zu, Black)]]) false;

  assert_equal Game.(move_valid_aux [ [(Xiang, Red); (Empty,N);];
                                      [(Che, Red);   (Zu, Red);];
                                      [(Che, Black); (Empty,N);]]) false;

  (* Shi *)
  assert_equal Game.(move_valid_aux [ [(Shi, Red); (Empty,N);];
                                      [(Che, Red);   (Zu, Black);]]) true;

  assert_equal Game.(move_valid_aux [ [(Shi, Red); (Empty,N);];
                                      [(Che, Red);   (Zu, Red);];
                                      [(Che, Black); (Empty,N);]]) false;
                    

  assert_equal Game.(move_valid_aux [ [(Jiang, Red); (Empty,N);];]) true;
  assert_equal Game.(move_valid_aux [ [(Jiang, Red); (Che, Red);];]) false;
  assert_equal Game.(move_valid_aux [ [(Jiang, Red)];
                                      [(Zu, Black)]]) true;
  assert_equal Game.(move_valid_aux [ [(Jiang, Red)];
                                      [(Zu, Black)];
                                      [(Empty, N)]]) false;
  
  (* Pao *)
  assert_equal Game.(move_valid_aux [[(Pao,Red); (Empty,N); (Zu,Red); (Empty,N); (Zu,Black)]]) true;
  assert_equal Game.(move_valid_aux [[(Pao,Red); (Empty,N); (Empty,N); (Empty,N); (Zu,Black)]]) false;
  assert_equal Game.(move_valid_aux [[(Pao,Red); (Empty,N); (Zu, Black); (Empty,N); (Zu,Red)]]) false;
  
;;


let game_logic_tests = 
  "game logic tests" >: test_list
  [
    "move_valid_aux" >:: test_move_valid_aux
  ]

let series = "">::: [game_logic_tests]

let () = run_test_tt_main series
