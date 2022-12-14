let css () = 
"
html,
body {
    margin: 0;
    padding: 0
}

/* 棋盘样式 */
.container {
    box-sizing: border-box;
    position: relative;
    top: 50px;
    width: 500px;
    height: 560px;
    border: 6px solid #000;
    margin: 0 auto;

}

.board {
    box-sizing: border-box;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-240px, -270px);
    width: 480px;
    height: 540px;
}

.board-wrap {
    width: 100%;
    height: 100%;
    border-collapse: collapse;
}

.biasA,
.biasB,
.biasC,
.biasD {
    box-sizing: border-box;
    position: absolute;
    z-index: -1;
    width: 170px;
    border-top: 2px solid #000;
}

.biasA {
    top: 60px;
    left: 154px;
    transform: rotate(45deg)
}

.biasB {
    top: 60px;
    left: 154px;
    transform: rotate(-45deg)
}

.biasC {
    bottom: 58px;
    left: 154px;
    transform: rotate(45deg)
}

.biasD {
    bottom: 58px;
    left: 154px;
    transform: rotate(-45deg)
}

.cell {
    position: relative;
    box-sizing: border-box;
    width: 60px;
    height: 60px;
    border: 2px solid #000;
}

.right-bottom {
    box-sizing: border-box;
    position: absolute;
    right: 5px;
    bottom: 5px;
    width: 15px;
    height: 15px;
    border-right: 2px solid #000;
    border-bottom: 2px solid #000;
}

.left-bottom {
    box-sizing: border-box;
    position: absolute;
    left: 5px;
    bottom: 5px;
    width: 15px;
    height: 15px;
    border-left: 2px solid #000;
    border-bottom: 2px solid #000;
}

.right-top {
    box-sizing: border-box;
    position: absolute;
    right: 5px;
    top: 5px;
    width: 15px;
    height: 15px;
    border-right: 2px solid #000;
    border-top: 2px solid #000;
}

.left-top {
    box-sizing: border-box;
    position: absolute;
    left: 5px;
    top: 5px;
    width: 15px;
    height: 15px;
    border-left: 2px solid #000;
    border-top: 2px solid #000;
}

.no-inner-border {
    border-left: none;
    border-right: none;
}

.have-border-left {
    border-left: 2px solid #000;
}

.have-border-right {
    border-right: 2px solid #000;
}

/* 棋盘样式结束 */
/* 棋子样式 */
.chess {
    box-sizing: border-box;
    width: 50px;
    height: 50px;
    border: 2px solid #000;
    border-radius: 50px;
    text-align: center;
    line-height: 46px;
    font-size: 28px;
    font-weight: 700;
    background-color: #F1C07E;
    cursor: pointer;
    user-select: none;
}

.chess_n {
    box-sizing: border-box;
    width: 50px;
    height: 50px;
    user-select: none;
}

.red {
    color: #f00;
}

.black {
    color: #00f;
}

#pos-10_1 {
    position: absolute;
    left: -25px;
    top: 515px
}

#pos-10_2 {
    position: absolute;
    left: 35px;
    top: 515px
}

#pos-10_3 {
    position: absolute;
    left: 95px;
    top: 515px
}

#pos-10_4 {
    position: absolute;
    left: 155px;
    top: 515px
}

#pos-10_5 {
    position: absolute;
    left: 215px;
    top: 515px
}

#pos-10_6 {
    position: absolute;
    left: 275px;
    top: 515px
}

#pos-10_7 {
    position: absolute;
    left: 335px;
    top: 515px
}

#pos-10_8 {
    position: absolute;
    left: 395px;
    top: 515px
}

#pos-10_9 {
    position: absolute;
    left: 455px;
    top: 515px
}

#pos-9_1 {
    position: absolute;
    left: -25px;
    top: 455px
}

#pos-9_2 {
    position: absolute;
    left: 35px;
    top: 455px
}

#pos-9_3 {
    position: absolute;
    left: 95px;
    top: 455px
}

#pos-9_4 {
    position: absolute;
    left: 155px;
    top: 455px
}

#pos-9_5 {
    position: absolute;
    left: 215px;
    top: 455px
}

#pos-9_6 {
    position: absolute;
    left: 275px;
    top: 455px
}

#pos-9_7 {
    position: absolute;
    left: 335px;
    top: 455px
}

#pos-9_8 {
    position: absolute;
    left: 395px;
    top: 455px
}

#pos-9_9 {
    position: absolute;
    left: 455px;
    top: 455px
}


#pos-8_1 {
    position: absolute;
    left: -25px;
    top: 395px
}

#pos-8_2 {
    position: absolute;
    left: 35px;
    top: 395px
}

#pos-8_3 {
    position: absolute;
    left: 95px;
    top: 395px
}

#pos-8_4 {
    position: absolute;
    left: 155px;
    top: 395px
}

#pos-8_5 {
    position: absolute;
    left: 215px;
    top: 395px
}

#pos-8_6 {
    position: absolute;
    left: 275px;
    top: 395px
}

#pos-8_7 {
    position: absolute;
    left: 335px;
    top: 395px
}

#pos-8_8 {
    position: absolute;
    left: 395px;
    top: 395px
}

#pos-8_9 {
    position: absolute;
    left: 455px;
    top: 395px
}

#pos-7_1 {
    position: absolute;
    left: -25px;
    top: 335px
}

#pos-7_2 {
    position: absolute;
    left: 35px;
    top: 335px
}

#pos-7_3 {
    position: absolute;
    left: 95px;
    top: 335px
}

#pos-7_4 {
    position: absolute;
    left: 155px;
    top: 335px
}

#pos-7_5 {
    position: absolute;
    left: 215px;
    top: 335px
}

#pos-7_6 {
    position: absolute;
    left: 275px;
    top: 335px
}

#pos-7_7 {
    position: absolute;
    left: 335px;
    top: 335px
}

#pos-7_8 {
    position: absolute;
    left: 395px;
    top: 335px
}

#pos-7_9 {
    position: absolute;
    left: 455px;
    top: 335px
}

#pos-6_1 {
    position: absolute;
    left: -25px;
    top: 275px
}

#pos-6_2 {
    position: absolute;
    left: 35px;
    top: 275px
}

#pos-6_3 {
    position: absolute;
    left: 95px;
    top: 275px
}

#pos-6_4 {
    position: absolute;
    left: 155px;
    top: 275px
}

#pos-6_5 {
    position: absolute;
    left: 215px;
    top: 275px
}

#pos-6_6 {
    position: absolute;
    left: 275px;
    top: 275px
}

#pos-6_7 {
    position: absolute;
    left: 335px;
    top: 275px
}

#pos-6_8 {
    position: absolute;
    left: 395px;
    top: 275px
}

#pos-6_9 {
    position: absolute;
    left: 455px;
    top: 275px
}

#pos-5_1 {
    position: absolute;
    left: -25px;
    top: 215px
}

#pos-5_2 {
    position: absolute;
    left: 35px;
    top: 215px
}

#pos-5_3 {
    position: absolute;
    left: 95px;
    top: 215px
}

#pos-5_4 {
    position: absolute;
    left: 155px;
    top: 215px
}

#pos-5_5 {
    position: absolute;
    left: 215px;
    top: 215px
}

#pos-5_6 {
    position: absolute;
    left: 275px;
    top: 215px
}

#pos-5_7 {
    position: absolute;
    left: 335px;
    top: 215px
}

#pos-5_8 {
    position: absolute;
    left: 395px;
    top: 215px
}

#pos-5_9 {
    position: absolute;
    left: 455px;
    top: 215px
}

#pos-4_1 {
    position: absolute;
    left: -25px;
    top: 155px
}

#pos-4_2 {
    position: absolute;
    left: 35px;
    top: 155px
}

#pos-4_3 {
    position: absolute;
    left: 95px;
    top: 155px
}

#pos-4_4 {
    position: absolute;
    left: 155px;
    top: 155px
}

#pos-4_5 {
    position: absolute;
    left: 215px;
    top: 155px
}

#pos-4_6 {
    position: absolute;
    left: 275px;
    top: 155px
}

#pos-4_7 {
    position: absolute;
    left: 335px;
    top: 155px
}

#pos-4_8 {
    position: absolute;
    left: 395px;
    top: 155px
}

#pos-4_9 {
    position: absolute;
    left: 455px;
    top: 155px
}

#pos-3_1 {
    position: absolute;
    left: -25px;
    top: 95px
}

#pos-3_2 {
    position: absolute;
    left: 35px;
    top: 95px
}

#pos-3_3 {
    position: absolute;
    left: 95px;
    top: 95px
}

#pos-3_4 {
    position: absolute;
    left: 155px;
    top: 95px
}

#pos-3_5 {
    position: absolute;
    left: 215px;
    top: 95px
}

#pos-3_6 {
    position: absolute;
    left: 275px;
    top: 95px
}

#pos-3_7 {
    position: absolute;
    left: 335px;
    top: 95px
}

#pos-3_8 {
    position: absolute;
    left: 395px;
    top: 95px
}

#pos-3_9 {
    position: absolute;
    left: 455px;
    top: 95px
}

#pos-2_1 {
    position: absolute;
    left: -25px;
    top: 35px
}

#pos-2_2 {
    position: absolute;
    left: 35px;
    top: 35px
}

#pos-2_3 {
    position: absolute;
    left: 95px;
    top: 35px
}

#pos-2_4 {
    position: absolute;
    left: 155px;
    top: 35px
}

#pos-2_5 {
    position: absolute;
    left: 215px;
    top: 35px
}

#pos-2_6 {
    position: absolute;
    left: 275px;
    top: 35px
}

#pos-2_7 {
    position: absolute;
    left: 335px;
    top: 35px
}

#pos-2_8 {
    position: absolute;
    left: 395px;
    top: 35px
}

#pos-2_9 {
    position: absolute;
    left: 455px;
    top: 35px
}

#pos-1_1 {
    position: absolute;
    left: -25px;
    top: -25px
}

#pos-1_2 {
    position: absolute;
    left: 35px;
    top: -25px
}

#pos-1_3 {
    position: absolute;
    left: 95px;
    top: -25px
}

#pos-1_4 {
    position: absolute;
    left: 155px;
    top: -25px
}

#pos-1_5 {
    position: absolute;
    left: 215px;
    top: -25px
}

#pos-1_6 {
    position: absolute;
    left: 275px;
    top: -25px
}

#pos-1_7 {
    position: absolute;
    left: 335px;
    top: -25px
}

#pos-1_8 {
    position: absolute;
    left: 395px;
    top: -25px
}

#pos-1_9 {
    position: absolute;
    left: 455px;
    top: -25px
}

.black {
    color: #000;
}



.action {
    position: absolute;
    left: -200px;
    width: 100px;
    height: 548px;
    text-align: center;
}

.action h3 {
    font-size: 24px;
}

#red-act {
    position: absolute;
    bottom: 60px;
}

#black-act {
    position: absolute;
    top: -10px;
}

.show {
    margin: 15px auto;
    width: 60px;
    height: 60px;
    line-height: 54px;
    font-size: 32px;
}

.red-time-container,
.black-time-container {
    font-weight: 550;
    font-size: 20px;
}

.red-time-container {
    position: relative;
    top: 468px;
    color:red;
}
.black-time-container {
    position: relative;
    top: 52px;
}
"