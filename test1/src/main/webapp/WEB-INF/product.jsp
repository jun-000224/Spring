<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>쇼핑몰 헤더</title>
    <link rel="stylesheet" href="/css/product-style.css">
    <style>
        /* 드롭다운 메뉴 동작을 위한 최소한의 CSS */
        nav ul li { position: relative; display: inline-block; }
        nav ul li .dropdown-menu { display: none; position: absolute; background-color: white; border: 1px solid #ccc; list-style: none; padding: 0; margin: 0; z-index: 10; }
        nav ul li:hover .dropdown-menu { display: block; }
    </style>
</head>
<body>
    <div id="app">
        <header>
            <div class="logo">
                <img src="/img/logo.png" alt="쇼핑몰 로고">
            </div>
            <nav>
                <ul>
                    <li v-for="item in menuList" v-if="item.depth == 1" class="dropdown">
                        <a href="#" @click.prevent="fnList(item.menuNo)">{{item.menuName}}</a>
                        <ul class="dropdown-menu" v-if="item.cnt > 0"> 
                            <span v-for="subItem in menuList">
                                <li v-if="item.menuNo == subItem.menuPart"><a href="#" @click.prevent="fnList(subItem.menuNo)">{{subItem.menuName}}</a></li>
                            </span>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="search-bar">
                <input v-model="keyword" @keyup.enter="fnList()" type="text" placeholder="상품을 검색하세요...">
                <button @click="fnList()">검색</button>
            </div>
            <div class="login-btn">
                <button>로그인</button>
            </div>
        </header>

        <main>
            <section class="product-list">
                <div v-for="item in list" class="product-item">
                    <img :src="item.filePath" alt="제품 1">
                    <h3>{{item.foodName}}</h3>
                    <p>{{item.foodInfo}}</p>
                    <p class="price">₩{{item.price.toLocaleString()}}</p>
                </div>
            </section>
        </main>
        
        <div style="padding: 20px;">
            <a href="/product-add.do">
                <button>음식 추가</button>
            </a>
        </div>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list: [],
                menuList: [],
                keyword: ""
            };
        },
        methods: {
            fnList: function(menuNo) {
                var self = this;
                
             
                if(menuNo) {
                    self.keyword = "";
                }

                var nparmap = {
                    keyword: self.keyword,
                    menuNo: menuNo || '' 
                };
                
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        
                        if (data.menuList) {
                            self.menuList = data.menuList;
                        }
                    }
                });
            }
        },
        mounted() {
            var self = this;
            self.fnList(); 
        }
    });
    app.mount('#app');
</script>