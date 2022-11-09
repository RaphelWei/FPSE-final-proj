open Core;;
(* open Game;; *)



let build_chess_html_from_piece i j piece = 
  (*
    i : row index of piece
    j : col index of piece
    piece: type stone
   *)
  let str = Game.get_piece_str piece in 
  let color = Game.get_piece_color piece in
  if Core.String.(str = "") then 
    ""
  else 
    Printf.sprintf "<div class=\"chess %s\" id=\"pos-%d%d\">%s</div>\n" color i j str



let build_row_html_from_row l i = 
  (*
    l : a list of [type stone]
    i : row index
   *)
  List.fold_left
    l
    ~init:("", 1)
    ~f:(
      fun (acc, j) piece ->
        let newstr = build_chess_html_from_piece i j piece in 
        (acc ^ newstr, j+1)
    )
  |> fst

let build_board_html_from_board board = 
  (*
    board : stone list list
   *)
  List.fold_left
    (board |> List.rev)
    ~init:("<div class=\"chessContent\">\n", 1)
    ~f:(fun (acc, i) row -> (acc ^ build_row_html_from_row row i, i+1))
  |> fst |> fun x -> x ^ "</div>"


let build_html_from_board board = 
  (*
    build a html page from a [stone list list]
   *)
  let board_str = build_board_html_from_board board in 
  let css_str = Css.css () in 
  Printf.sprintf
"
  <!DOCTYPE html>
  <html lang=\"zh-CN\">

  <head>
      <meta charset=\"UTF-8\">
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
      <style>
      %s
      </style>
  </head>

  <body>
    <div class=\"container\">
        <!-- 棋盘布局开始 -->
        <div class=\"board\">
            <div class=\"biasA\"></div>
            <div class=\"biasB\"></div>
            <div class=\"biasC\"></div>
            <div class=\"biasD\"></div>
            <table class=\"board-wrap\">
                <tr>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                </tr>
                <tr>
                    <td class=\"cell\">
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\">
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-bottom\"></div>
                    </td>
                </tr>
                <tr>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                        <div class=\"right-bottom\"></div>
                    </td>
                </tr>
                <tr>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                    </td>
                </tr>
                <tr>
                    <td class=\"cell no-inner-border have-border-left\"></td>
                    <td class=\"cell no-inner-border\"></td>
                    <td class=\"cell no-inner-border\"></td>
                    <td class=\"cell no-inner-border\"></td>
                    <td class=\"cell no-inner-border\"></td>
                    <td class=\"cell no-inner-border\"></td>
                    <td class=\"cell no-inner-border\"></td>
                    <td class=\"cell no-inner-border have-border-right\"></td>
                </tr>
                <tr>
                    <td class=\"cell\">
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-bottom\"></div>
                    </td>
                </tr>
                <tr>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                        <div class=\"left-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                        <div class=\"right-bottom\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                        <div class=\"left-bottom\"></div>
                    </td>
                </tr>
                <tr>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                    </td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\">
                        <div class=\"right-top\"></div>
                    </td>
                    <td class=\"cell\">
                        <div class=\"left-top\"></div>
                    </td>
                </tr>
                <tr>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                    <td class=\"cell\"></td>
                </tr>
            </table>
            %s
        </div>
    </div> 
  </body>
  "
  css_str
  board_str