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
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div><input type="text" v-model="title" placeholder="제목을 입력하세요"></div>
        <div><textarea v-model="contents"></textarea></div>
        <div>작성자 : {{userId}}</div>
        <button @Click="fnUpdate">수정완료</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                title : '',
                contents : ''
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnUpdate: function () {
                let self = this;
                let param = {
                    title : self.title,
                    contents : self.contents
                };
                $.ajax({
                    url: "/bbs/update.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result==="success"){
                            alert("수정에 성공하였습니다!")
                            location.href="/bbs/list.do"
                        }else{
                            alert("오류가 발생하였습니다!")
                        }
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>