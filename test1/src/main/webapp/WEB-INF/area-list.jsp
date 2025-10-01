<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지역 정보 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        body { font-family: sans-serif; margin: 2em; }
        table, tr, td, th{
            border : 1px solid #ccc;
            border-collapse: collapse;
            padding : 8px 12px;
            text-align: center;
        }
        th{
            background-color: #f5f5f5;
        }
        tr:nth-child(even){
            background-color: #fafafa;
        }
        #index{
            margin-right: 5px;
            margin-left : 5px;
            text-decoration: none;
        }
        
    </style>
</head>
<body>
    <div id="app">
        <select v-model="si">
            <option value="">::전체::</option>
            <option :value="item.si" v-for="item in siList">{{item.si}}</option>
        </select>
        <table>
            <tr>
                <th>시/도</th>
                <th>구</th>
                <th>동</th>
                <th>NX</th>
                <th>NY</th>
            </tr>
            <tr v-for="item in list">
                <td>{{item.si}}</td>
                <td>{{item.gu}}</td>
                <td>{{item.dong}}</td>
                <td>{{item.nx}}</td>
                <td>{{item.ny}}</td>
            </tr>
        </table>

        <div class="pagination">
            <button @click="fnPage(startPage - 1)" v-if="startPage > 1">⏪</button>
            <button @click="fnLeft" :disabled="page <= 1">◀</button>
            
            <template v-for="num in endPage">
                <a href="javascript:;" v-if="num >= startPage" @click="fnPage(num)" id="index">
                    <span :class="{active : page == num}">{{num}}</span>
                </a>
            </template>
            
            <button @click="fnRight" :disabled="page >= index">▶</button>
            <button @click="fnPage(endPage + 1)" v-if="endPage < index">⏩</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                list: [],
                pageSize: 10, 
                page: 1,
                index: 0,
                blockPage: 10,
                startPage: 1,
                endPage: 0,
                si: "",// 선택한 시(도)의 값을 저장할 변수
                siList : []
            };
        },
        watch: {
            // 'si' 데이터의 값이 변경될 때마다 이 함수가 실행됩니다.
            si(newVal, oldVal) {
                this.page = 1; // 검색 조건이 바뀌었으므로 1페이지로 초기화
                this.fnList(); // 목록을 다시 조회
            }
        },
        methods: {
            fnList: function () {
                let self = this;
                let param = {
                    pageSize: self.pageSize,
                    page: (self.page - 1) * self.pageSize,
                    si: self.si // 'si' 값을 파라미터에 추가
                };
                $.ajax({
                    url: "/area/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                        
                        const currentBlock = Math.ceil(self.page / self.blockPage);
                        self.startPage = (currentBlock - 1) * self.blockPage + 1;
                        const lastPageInBlock = currentBlock * self.blockPage;
                        
                        self.endPage = lastPageInBlock > self.index ? self.index : lastPageInBlock;
                    }
                });
            },
            fnSiList: function () {
                let self = this;
                // '시' 목록은 전체를 가져오므로 불필요한 파라미터는 제거합니다.
                $.ajax({
                    url: "/area/Si.dox",
                    dataType: "json",
                    type: "POST",
                    success: function (data) {
                        self.siList = data.list;
                    }
                });
            },
            fnPage: function(num){
                if (num > 0 && num <= this.index) {
                    this.page = num;
                    this.fnList();
                }
            },
            fnLeft: function(){
                if(this.page > 1){
                    this.page--;
                    this.fnList();
                }
            },
            fnRight: function(){
                if(this.page < this.index){
                    this.page++;
                    this.fnList();
                }
            }
        },
        mounted() {
            this.fnList();
            this.fnSiList();
        }
    });

    app.mount('#app');
</script>