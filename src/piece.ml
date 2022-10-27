type piece_type = 
  | King        (* 将 *)
  | Guard       (* 仕 *)     
  | Bishop      (* 象 *)
  | Knight      (* 馬 *)
  | Rook        (* 車 *)
  | Cannon      (* 砲 *)
  | Pawn        (* 卒 *)

type color = 
  | Red
  | Black

type t = {
  piece_type : piece_type;
  color : color;
}


