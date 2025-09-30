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
        <div>
            <select v-model ="searchOption">
                <option value = "all">::전체::</option>
                <option value = "title">::제목::</option>
                <option value = "id">::작성자::</option>
            </select>
            검색어 : <input v-model="keyword" @keyup.enter="fnList">
            <button @click="fnList"> 검색</button>
        </div>
        <div>
            <select v-model="kind" @change="fnList">
                <option value=""> :: 전체 :: </option>
                <option value="1"> :: 공지사항 :: </option>
                <option value="2"> :: 자유게시판 :: </option>
                <option value="3"> :: 문의사항 :: </option>
            </select>

            <select v-model="sortBy" @change="fnList">
                <option value="num"> :: 번호순 :: </option>
                <option value="title"> :: 제목순 :: </option>
                <option value="view"> :: 조회순 :: </option>
            </select>
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.boardNo}}</td>
                    <td><a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a>
                        <span v-if="item.commentCnt != 0" style = "color : red">[{{item.commentCnt}}]</span>
                    </td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cnt}}</td>
                    <td>{{item.cdate}}</td>
                    <td><button v-if="sessionId == item.userId || status == 'A'" @click="fnRemove(item.boardNo)">삭제</button></td>
                </tr>
            </table>

            <button @click="fnAdd()" style ="margin-top : 10px">글쓰기</button>
        </div>
        
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : [],
                kind : "",
                sortBy : "num",
                keyword: "",
                searchOption : "all", //검색옵션 (기본 : 전체)

                sessionId : "${sessionId}",
                status : "${sessionStatus}" // sessionStauts -> sessionStatus 오타 수정
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    kind : self.kind,
                    sortBy : self.sortBy,
                    keyword : self.keyword,
                    searchOption : self.searchOption
                };
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                    }
                });
            },
            //게시글 추가하기
            fnAdd: function () {
                location.href = "board-add.do"
            },
            //게시글 삭제하기
            fnRemove: function (boardNo) {
                if (!confirm("정말 삭제하시겠습니까?")) {
                    return;
                }
                
                let self = this;
                let param = {
                    boardNo : boardNo,
                    userId : self.sessionId // userId -> self.sessionId 로 수정
                };
                $.ajax({
                    url: "board-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다.");
                        self.fnList();
                    }
                });
            }, 
            fnView : function(boardNo){
                pageChange("board-view.do", {boardNo : boardNo});
            },
            fnSearch : function(keyword){
                // fnList로 통합되었으므로 비워둡니다.
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