<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        #board table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
    
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <table>
                <tr>
                    <th>제목</th>
                    <td>{{info.title}}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>{{info.userId}}</td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td>{{info.cnt}}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <img v-for="item in fileList" :src="item.filePath">
                        {{info.contents}}
                    </td>
                </tr>         
            </table>

            <hr>
            <table class="board" id="comment">
            <tr v-for = "item in commentList">
                <th>{{item.nickName}}</th>
                <td>{{item.contents}}</td>
                <td><button>삭제</button></td>
                <td><button>수정</button></td>
            </tr>
            </table>
            <hr>
            <table id="input">
                <th>댓글 입력</th>
                <td>
                    <textarea cols="40" rows="4" v-model="contents"></textarea>
                </td>
                <td><button @click="fnCommentAdd">저장</button></td>
            </table>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                boardNo : "${boardNo}", //request객체로 보낸 값임.
                info : {},
                commentList : [],
                sessionId : "${sessionId}",
                contents : "", //댓글 입력 v-model로 연결할 변수
                fileList : []
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo : function (boardNo) {
                let self = this;
                let param = {
                    boardNo : self.boardNo
                };
                $.ajax({
                    url: "board-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.commentList = data.commentList;
                        self.fileList = data.fileList;
                        self.info = data.info;
                    }
                });
            },
            fnCommentAdd : function (boardNo) {
                let self = this;
                let param = {  //xml이랑 연결되는 이름
                    id : self.sessionId, //작성자 아이디
                    contents : self.contents, //작성 내용
                    boardNo : self.boardNo //어떤 게시글것인가
                };
                $.ajax({
                    url: "/comment/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.contents = "";
                        self.fnInfo();
                        
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            this.fnInfo();
            
        }
    });

    app.mount('#app');
</script>