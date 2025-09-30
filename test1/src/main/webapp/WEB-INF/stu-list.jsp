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
			<input v-model="keyword" placeholder="검색어">
			<button @click="fnInfo">검색</button>
		</div>
        <div>
            <table>
                <tr>
                    <th>학번</th>
                    <th>이름</th>
                    <th>학과</th>
                    <th>학년</th>
                    <th>성별</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.stuNo}}</td>
                    <td><a href="javascript:;" @click="fnView(item.stuNo)">{{item.stuName}}</a></td>
                    <td>{{item.stuDept}}</td>
                    <td>{{item.stuGrade}}</td>
                    <td>{{item.stuGender}}</td>
                    <td><button @click="fnRemove(item.stuNo)">삭제</button></td>
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
				keyword : "",
                list : []
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "stu-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
                        self.list = data.list;
                    }
                });
            },
            fnInfo: function () {
                let self = this;
                let param = {
					keyword : self.keyword
				};
                $.ajax({
                    url: "stu-info.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						console.log(data);
                    }
                });
            },
            fnRemove: function (stuNo) {
                let self = this;
                let param = {
                    stuNo : stuNo
                };
                $.ajax({
                    url: "stu-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
						alert("삭제되었습니다.");
                        self.fnList();
                    }
                });
            },
            fnView(stuNo){
                pageChange("/stu-view.do", {stuNo : stuNo});
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