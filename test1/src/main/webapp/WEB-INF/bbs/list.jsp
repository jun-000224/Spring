<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }

            th {
                background-color: beige;
            }

            tr:nth-child(even) {
                background-color: azure;
            }

            #index {
                margin-right: 5px;
                text-decoration: none;
            }

            .active {
                color: black;
                font-weight: bold;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div>
                <table>
                    <tr>
                        <th><input type="checkbox" @clikc="fnAllCheck()"></th>
                        <th>제목</th>
                        <th>내용</th>
                        <th>작성자</th>
                        <th></th>
                    </tr>
                    <tr v-for="item in list" :key="item.bbsNum"> <!--:key="item.bbsNum"으로 동적인 키값 체크박스에 부여함-->
                        <td><input type="checkbox" :value="item.bbsNum" v-model="checkedList"></td>
                        <td><a herf="javascript:;">{{item.title}}</a></td>
                        <td>{{item.contents}}</td>
                        <td>{{item.userId}}</td>
                        <td><button @Click="fnUpdate">수정</button></td>
                    </tr>
                </table>
                <a href="/bbs/add.do"><button>글쓰기</button></a>
                <button href="/bbs/update.do">선택 삭제</button>
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
                    CheckedList : [] //체크박스 선택박스에 담긴 리스트(bbsNum이 담겨있음.)
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "/bbs/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list;
                        }
                    });
                },
                fnRemove: function (){
                    let self = this;

                    //유효성 검사
                    if(self.CheckedList.length === 0){
                        alert("삭제한 게시글을 선택해 주세요");
                        return
                    }

                    let jsonListj = JSON.stringify(self.CheckedList);
                    let param = {
                        bbsNumJson : jsonList
                    }

                    $.ajax({
                        url:"/bbs/remove.dox",
                        dataType:"json",
                        type : "POST",
                        data : param,
                        success : function(data){
                            if(data.result === "success"){
                                alert("삭제되었습니다");
                                self.CheckedList=[]; //선택목록 초기화
                                self.fnList();
                            }
                        }
                    })
                },
                fnUpdate : function(){
                    let self = this;
                    let param ={}
                    $.ajax({
                        url:"/bbs/updat.do",
                        dataType : "json",
                        type : "POST",
                        data : param,
                        success : function(data){
                            alert("수정을 시작합니다!");
                            
                        }

                    })
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