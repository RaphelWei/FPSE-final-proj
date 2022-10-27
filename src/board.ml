open Piece

type b = Piece.t option array array

type t = {
  board: b;
  mutable turn: Piece.t;
  mutable winner: Piece.t option;
  mutable moves: int;
}




