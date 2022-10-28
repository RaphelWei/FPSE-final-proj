type rank = 
  | General        (* 帥/將 *)
  | Advisor        (* 仕/士 *)     
  | Elephant       (* 相/象 *)
  | Horse          (* 傌/馬 *)
  | Chariot        (* 俥/車 *)
  | Cannon         (* 炮/砲 *)
  | Soldier        (* 兵/卒 *)

type color = 
  | Red
  | Black

type position = int * int

type t = {
  id : rank;
  color : color;
  coord : position;
}


