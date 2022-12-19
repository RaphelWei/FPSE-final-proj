open Core;;



let build_index_page () = 
    "
    <!DOCTYPE html>
    <html>
    <head>
    <style>
    .container { 
    height: 400px;
    position: relative;
    border: 3px solid green; 
    }

    .center {
    margin: 0;
    position: absolute;
    top: 50%;
    left: 50%;
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    }
    </style>
    </head>
    <body>

    <h2>Chinese Chess Game</h2>

    <div class=\"container\">
    <div class=\"center\">
        <button style=\"height: 80px; width: 200px;\" onclick=\"window.location.href='pvp';\"> Play against a player </button> <br>
        <p></p>
        <button style=\"height: 80px; width: 200px;\" onclick=\"window.location.href='pve';\"> Play against AI </button>
    </div>
    </div>

    </body>
    </html>
    "
;;

let build_chess_html_from_piece i j piece = 
  (*
    i : row index of piece
    j : col index of piece
    piece: type stone
   *)
  let str = Game_logic.get_piece_str piece in 
  let color = 
    match piece.color with 
    | Game_logic.Black -> "black" 
    | Game_logic.Red -> "red" 
    | Game_logic.N -> ""
  in
  if Core.String.(str = " + ") then 
    Printf.sprintf "<div class=\"chess_n\" id=\"pos-%d_%d\" onclick=\"piece_clicked(%d,%d)\">%s</div>\n" i j i j "" 
  else 
    Printf.sprintf "<div class=\"chess %s\" id=\"pos-%d_%d\" onclick=\"piece_clicked(%d,%d)\">%s</div>\n" color i j i j str 


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

let build_board_html_from_board (board : Game_logic.boardt) = 
  (*
    board : stone list list
   *)
  List.fold_left
    board
    ~init:("<div class=\"chessContent\" id=\"board_div\">\n", 1)
    ~f:(fun (acc, i) row -> (acc ^ build_row_html_from_row row i, i+1))
  |> fst |> fun x -> x ^ "</div>"


let build_html_from_board (board : Game_logic.boardt) gametype = 
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
    <script>
        let socket = new WebSocket(\"ws://\" + window.location.host + \"/websocket/%s\");
        var coord_pair = [];
        function piece_clicked(i,j){
            console.log(coord_pair.length);
            coord_pair.push(i);
            coord_pair.push(j);
            if (coord_pair.length == 4){
                
                var msg = \"\" + coord_pair[0] + \"_\" + coord_pair[1] + \"_\" + coord_pair[2] + \"_\" + coord_pair[3];
                coord_pair = [];
                // msg = \"8_2_8_4\";
                console.log(msg);
                socket.send(msg);
            }
        }
        socket.onopen = function () {
            
        };

        socket.onmessage = function (msg) {
            console.log(msg.data);
            if(msg.data.length <= 100){
                alert(msg.data);
            }else{
                var board_div = document.getElementById('board_div');
                board_div.innerHTML = msg.data;
            }
        };
    </script>
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
  gametype
  board_str