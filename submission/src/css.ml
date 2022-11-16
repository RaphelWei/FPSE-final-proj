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

.red {
    color: #f00;
}

#pos-101 {
    position: absolute;
    left: -25px;
    top: 515px
}

#pos-102 {
    position: absolute;
    left: 35px;
    top: 515px
}

#pos-103 {
    position: absolute;
    left: 95px;
    top: 515px
}

#pos-104 {
    position: absolute;
    left: 155px;
    top: 515px
}

#pos-105 {
    position: absolute;
    left: 215px;
    top: 515px
}

#pos-106 {
    position: absolute;
    left: 275px;
    top: 515px
}

#pos-107 {
    position: absolute;
    left: 335px;
    top: 515px
}

#pos-108 {
    position: absolute;
    left: 395px;
    top: 515px
}

#pos-109 {
    position: absolute;
    left: 455px;
    top: 515px
}

#pos-91 {
    position: absolute;
    left: -25px;
    top: 455px
}

#pos-92 {
    position: absolute;
    left: 35px;
    top: 455px
}

#pos-93 {
    position: absolute;
    left: 95px;
    top: 455px
}

#pos-94 {
    position: absolute;
    left: 155px;
    top: 455px
}

#pos-95 {
    position: absolute;
    left: 215px;
    top: 455px
}

#pos-96 {
    position: absolute;
    left: 275px;
    top: 455px
}

#pos-97 {
    position: absolute;
    left: 335px;
    top: 455px
}

#pos-98 {
    position: absolute;
    left: 395px;
    top: 455px
}

#pos-99 {
    position: absolute;
    left: 455px;
    top: 455px
}


#pos-81 {
    position: absolute;
    left: -25px;
    top: 395px
}

#pos-82 {
    position: absolute;
    left: 35px;
    top: 395px
}

#pos-83 {
    position: absolute;
    left: 95px;
    top: 395px
}

#pos-84 {
    position: absolute;
    left: 155px;
    top: 395px
}

#pos-85 {
    position: absolute;
    left: 215px;
    top: 395px
}

#pos-86 {
    position: absolute;
    left: 275px;
    top: 395px
}

#pos-87 {
    position: absolute;
    left: 335px;
    top: 395px
}

#pos-88 {
    position: absolute;
    left: 395px;
    top: 395px
}

#pos-89 {
    position: absolute;
    left: 455px;
    top: 395px
}

#pos-71 {
    position: absolute;
    left: -25px;
    top: 335px
}

#pos-72 {
    position: absolute;
    left: 35px;
    top: 335px
}

#pos-73 {
    position: absolute;
    left: 95px;
    top: 335px
}

#pos-74 {
    position: absolute;
    left: 155px;
    top: 335px
}

#pos-75 {
    position: absolute;
    left: 215px;
    top: 335px
}

#pos-76 {
    position: absolute;
    left: 275px;
    top: 335px
}

#pos-77 {
    position: absolute;
    left: 335px;
    top: 335px
}

#pos-78 {
    position: absolute;
    left: 395px;
    top: 335px
}

#pos-79 {
    position: absolute;
    left: 455px;
    top: 335px
}

#pos-61 {
    position: absolute;
    left: -25px;
    top: 275px
}

#pos-62 {
    position: absolute;
    left: 35px;
    top: 275px
}

#pos-63 {
    position: absolute;
    left: 95px;
    top: 275px
}

#pos-64 {
    position: absolute;
    left: 155px;
    top: 275px
}

#pos-65 {
    position: absolute;
    left: 215px;
    top: 275px
}

#pos-66 {
    position: absolute;
    left: 275px;
    top: 275px
}

#pos-67 {
    position: absolute;
    left: 335px;
    top: 275px
}

#pos-68 {
    position: absolute;
    left: 395px;
    top: 275px
}

#pos-69 {
    position: absolute;
    left: 455px;
    top: 275px
}

#pos-51 {
    position: absolute;
    left: -25px;
    top: 215px
}

#pos-52 {
    position: absolute;
    left: 35px;
    top: 215px
}

#pos-53 {
    position: absolute;
    left: 95px;
    top: 215px
}

#pos-54 {
    position: absolute;
    left: 155px;
    top: 215px
}

#pos-55 {
    position: absolute;
    left: 215px;
    top: 215px
}

#pos-56 {
    position: absolute;
    left: 275px;
    top: 215px
}

#pos-57 {
    position: absolute;
    left: 335px;
    top: 215px
}

#pos-58 {
    position: absolute;
    left: 395px;
    top: 215px
}

#pos-59 {
    position: absolute;
    left: 455px;
    top: 215px
}

#pos-41 {
    position: absolute;
    left: -25px;
    top: 155px
}

#pos-42 {
    position: absolute;
    left: 35px;
    top: 155px
}

#pos-43 {
    position: absolute;
    left: 95px;
    top: 155px
}

#pos-44 {
    position: absolute;
    left: 155px;
    top: 155px
}

#pos-45 {
    position: absolute;
    left: 215px;
    top: 155px
}

#pos-46 {
    position: absolute;
    left: 275px;
    top: 155px
}

#pos-47 {
    position: absolute;
    left: 335px;
    top: 155px
}

#pos-48 {
    position: absolute;
    left: 395px;
    top: 155px
}

#pos-49 {
    position: absolute;
    left: 455px;
    top: 155px
}

#pos-31 {
    position: absolute;
    left: -25px;
    top: 95px
}

#pos-32 {
    position: absolute;
    left: 35px;
    top: 95px
}

#pos-33 {
    position: absolute;
    left: 95px;
    top: 95px
}

#pos-34 {
    position: absolute;
    left: 155px;
    top: 95px
}

#pos-35 {
    position: absolute;
    left: 215px;
    top: 95px
}

#pos-36 {
    position: absolute;
    left: 275px;
    top: 95px
}

#pos-37 {
    position: absolute;
    left: 335px;
    top: 95px
}

#pos-38 {
    position: absolute;
    left: 395px;
    top: 95px
}

#pos-39 {
    position: absolute;
    left: 455px;
    top: 95px
}

#pos-21 {
    position: absolute;
    left: -25px;
    top: 35px
}

#pos-22 {
    position: absolute;
    left: 35px;
    top: 35px
}

#pos-23 {
    position: absolute;
    left: 95px;
    top: 35px
}

#pos-24 {
    position: absolute;
    left: 155px;
    top: 35px
}

#pos-25 {
    position: absolute;
    left: 215px;
    top: 35px
}

#pos-26 {
    position: absolute;
    left: 275px;
    top: 35px
}

#pos-27 {
    position: absolute;
    left: 335px;
    top: 35px
}

#pos-28 {
    position: absolute;
    left: 395px;
    top: 35px
}

#pos-99 {
    position: absolute;
    left: 455px;
    top: 35px
}

#pos-11 {
    position: absolute;
    left: -25px;
    top: -25px
}

#pos-12 {
    position: absolute;
    left: 35px;
    top: -25px
}

#pos-13 {
    position: absolute;
    left: 95px;
    top: -25px
}

#pos-14 {
    position: absolute;
    left: 155px;
    top: -25px
}

#pos-15 {
    position: absolute;
    left: 215px;
    top: -25px
}

#pos-16 {
    position: absolute;
    left: 275px;
    top: -25px
}

#pos-17 {
    position: absolute;
    left: 335px;
    top: -25px
}

#pos-18 {
    position: absolute;
    left: 395px;
    top: -25px
}

#pos-19 {
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