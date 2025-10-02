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
        .index{
            margin-right: 10px;
            text-decoration: none;
            color: black;
        }
        .active{
            color : red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            도/특별시 : 
            <select v-model="si" @change="fnGuList">
                <option value="">:: 전체 ::</option>
                <option :value="item.si" v-for="item in siList">{{item.si}}</option>
            </select>
            구 : 
            <select v-model="gu" >
                <option value="">:: 선택 ::</option>
                <option :value="item.gu" v-for="item in guList">{{item.gu}}</option>
            </select>
            <button @click="fnList">검색</button>
        </div> 
        <div>
            <table>
                <tr>
                    <th>도, 특별시</th>
                    <th>구</th>
                    <th>동</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.si}}</td>
                    <td>{{item.gu}}</td>
                    <td>{{item.dong}}</td>
                </tr>
            </table>
            <div>
                <a @click="fnPage(num)" class="index" href="javascript:;" v-for="num in index">
                    <span :class="{active : page == num}">{{num}}</span>
                </a>
            </div>
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
                pageSize : 20,
                page : 1,
                index : 0,
                siList : [],
                guList : [],

                si : "", // 선택한 시(도)의 값
                gu : "" // 선택한 구 값
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    pageSize : self.pageSize,
                    page : (self.page-1) * self.pageSize,
                    si : self.si,
                    gu : self.gu
                };
                $.ajax({
                    url: "/area/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);

                    }
                });
            },
            fnPage : function(num){
                let self = this;
                self.page = num;
                self.fnList();
            },
            fnSiList : function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/area/si.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.siList = data.list;

                    }
                });
            },
            fnGuList : function () {
                let self = this;
                let param = {
                    si : self.si
                };
                $.ajax({
                    url: "/area/gu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.gu = "";
                        self.guList = data.list;

                    }
                });
            },
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
            self.fnSiList();
        }
    });

    app.mount('#app');
</script>