<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
        <div>
            <table>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>닉네임</th>
                    <th>생년월일</th>
                    <th>성별</th>
                    <th>해제</th>
                </tr>
                <tr v-for="item in list">
                    <td>
                        <a href="javascript:;" @click="fnView(item.userId)">{{item.userId}}</a>
                    </td>
                    <td>{{item.name}}</td>
                    <td>{{item.nickName}}</td>
                    <td>{{item.cBirth}}</td>
                    <td>{{item.gender}}</td>
                    <td>
                        <button @click="fnRemoveCnt(item.userId)" v-if="item.cnt >= 5">정지해제</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : []
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/mgr/member/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data.list);
                        self.list = data.list;
                    }
                });
            },
            fnRemoveCnt : function(userId){
                let self = this;
                let param = {
                    id : userId
                };
                $.ajax({
                    url: "/mgr/remove-cnt.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("계정 정지가 해제되었습니다!");
                            self.fnList();
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnView : function(userId){
                // /mgr/member/view.do 로 이동
                pageChange("/mgr/member/view.do", {userId : userId});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>