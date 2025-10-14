<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 상세 정보</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 10px 15px;
        }
        th{
            background-color: beige;
            width: 120px;
        }
        td {
            text-align: left;
            width: 500px;
        }
        td img {
            max-width: 400px;
            height: auto;
            border-radius: 5px;
        }
        td pre {
            white-space: pre-wrap; /* 긴 텍스트 자동 줄바꿈 */
            word-break: break-all;
            font-family: inherit; /* 부모 폰트 스타일 상속 */
            margin: 0;
        }
        .back-button { 
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #333;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div id="app">
        <h2>제품 상세 정보</h2>
        <table>
            <tr>
                <th>제품명</th>
                <td>{{ product.foodName }}</td>
            </tr>
            <tr>
                <th>가격</th>
                <td>₩{{ fnFormatPrice(product.price) }}</td>
            </tr>
            <tr>
                <th>이미지</th>
                <td>
                    <img :src="product.filePath ? product.filePath : '/img/default.png'" :alt="product.foodName + ' 이미지'">
                </td>
            </tr>
            <tr>
                <th>제품 설명</th>
                <td><pre>{{ product.foodInfo }}</pre></td>
            </tr>
        </table>
        
        <a href="/product.do" class="back-button">목록으로</a>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                // Controller가 model.addAttribute로 넘겨준 foodNo를 받습니다.
                foodNo: "${foodNo}",
                // 상세 정보를 담을 객체 (처음엔 비어있음)
                product: {}
            };
        },
        methods: {
            // 제품 상세 정보를 Ajax로 가져오는 함수
            fnGetProductDetail: function () {
                let self = this;
                let param = {
                    foodNo: self.foodNo
                };
                $.ajax({
                    url: "/product/view.dox", // 새로 만든 JSON API 주소 호출
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        // 성공 시, 서버로부터 받은 product 데이터를 Vue 데이터에 할당
                        self.product = data.product;
                    },
                    error: function(xhr, status, error) {
                        console.error("Error:", error);
                        alert("제품 정보를 불러오는 데 실패했습니다.");
                    }
                });
            },
            // 숫자에 콤마(,)를 추가하는 함수
            fnFormatPrice: function(price) {
                if (price === undefined || price === null) return '';
                return price.toLocaleString();
            }
        },
        mounted() {
            // Vue 앱이 준비되면(페이지가 로드되면) 상세 정보를 가져오는 함수를 즉시 실행
            this.fnGetProductDetail();
        }
    });
    app.mount('#app');
</script>