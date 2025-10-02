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
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
        }
        th{
            background-color: beige;
        }
        input{
            width: 350px;
        }
    </style>
</head>
<body>
    <div id="app">
        <div>
            <table>
                <tr>
                    <th>제목</th>
                    <td><input v-model="title" placeholder="제목을 입력하세요"></td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>{{userId}}</td> </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea v-model="contents" cols="50" rows="20"></textarea></td>
                </tr>
                <tr>
                    <th>파일첨부</th>
                    <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
                </tr>
            </table>
            <div>
                <button @click="fnAdd">저장</button>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                title : "",
                userId : "${sessionId}", 
                contents : "",
                sessionId : "${sessionId}"
            };
        },
        methods: {
            fnAdd: function () {
                let self = this;

                let param = {
                    title : self.title,
                    userId : self.userId, 
                    contents : self.contents 
                };
                
                $.ajax({
                    url: "board-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("등록되었습니다.");
                        console.log(data.boardNo);
                        var form = new FormData();
	                    form.append( "file1",  $("#file1")[0].files[0] );
	                    form.append( "boardNo", data.boardNo); // 임시 pk
	                    self.upload(form); 
                        //location.href="board-list.do";
                    },
                    error: function(xhr, status, error) {
                        alert("등록에 실패했습니다. 다시 시도해주세요.");
                        console.error("Error:", error);
                    }
                });
            }, 
            upload : function(form){
                var self = this;
                    $.ajax({
                        url : "/fileUpload.dox"
                    , type : "POST"
                    , processData : false
                    , contentType : false
                    , data : form
                    , success:function(response) { 
                        console.log(data);
                    }	           
                });
            }
        },
        mounted() {
            let self = this;
            if(self.sessionId == ""){
                alert("로그인 후 이용해주세요!");
                location.href="/member/login.do";
            }
        }
    });

    app.mount('#app');
</script>