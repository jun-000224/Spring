<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>쇼핑몰</title>
    <link rel="stylesheet" href="/css/product-style.css">
    <style>
        /* a 태그에 기본 적용되는 밑줄과 색상을 제거하기 위해 추가 */
        .product-item {
            text-decoration: none;
            color: inherit;
            display: block; /* a 태그를 블록 요소로 만들어 영역 전체를 클릭할 수 있게 함 */
        }
    </style>
</head>
<body>
    <div id="app">
        <header>
            <div class="logo">
                <a href="/product.do"><img src="/img/logo.png" alt="쇼핑몰 로고"></a>
            </div>

            <nav>
                <ul>
                    <li v-for="item in menuList" class="dropdown">
                        <a href="#" v-if="item.depth == 1" @click="fnList(item.menuNo, '')">{{item.menuName}}</a>
                        <ul class="dropdown-menu" v-if="item.cnt > 0">
                            <span v-for="subItem in menuList">
                                <li v-if="item.menuNo == subItem.menuPart ">
                                    <a href="#" @click="fnList('', subItem.menuNo)">{{subItem.menuName}}</a>
                                </li>
                            </span>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="search-bar">
                <input v-model="keyword" @keyup.enter="fnList('', '')" type="text" placeholder="상품을 검색하세요...">
                <button @click="fnList('', '')">검색</button>
            </div>
            <div class="add-btn">
                <button onclick="location.href='/product/add.do'">제품등록</button>
            </div>
        </header>

        <main>
            <section class="product-list">
                <a v-for="item in list" :href="'/product/view.do?foodNo=' + item.foodNo" class="product-item">
                    <img :src="item.filePath ? item.filePath : '/img/default.png'" alt="제품 이미지">
                    <h3>{{item.foodName}}</h3>
                    <p>{{item.foodInfo}}</p>
                    <p class="price">₩{{item.price.toLocaleString()}}</p>
                </a>
            </section>
        </main>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list : [],
                menuList : [],
                keyword : ""
            };
        },
        methods: {
            fnList : function(part, menuNo) {
                var self = this;
                var nparmap = {
                    keyword : self.keyword,
                    menuPart : part,
                    menuNo : menuNo
                };
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.menuList = data.menuList;
                    }
                });
            }
        },
        mounted() {
            var self = this;
            self.fnList('', '');
        }
    });
    app.mount('#app');
</script>