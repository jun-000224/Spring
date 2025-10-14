<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 등록</title>
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
    </style>
</head>
<body>
    <div id="app">
        <div>
            <table>
                <tr>
                    <th>
                        카테고리
                    </th>
                    <td>
                        <select v-model="menuPart">
                            <option v-for="item in menuList" :value="item.menuNo">
                                {{item.menuName}}
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>
                        제품번호(소분류)
                    </th>
                    <td>
                        <input v-model="menuNo" class="txt" placeholder="메뉴번호 입력">
                    </td>
                </tr>
                <tr>
                    <th>
                        음식명
                    </th>
                    <td>
                        <input v-model="foodName">
                    </td>
                </tr>
                <tr>
                    <th>
                        음식 설명
                    </th>
                    <td>
                        <textarea v-model="foodInfo" cols="25" rows="5"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>
                        가격
                    </th>
                    <td>
                        <input v-model="price">
                    </td>
                </tr>
                <tr>
                    <th>
                        이미지
                    </th>
                    <td>
                        <input type="file" id="file1" name="file1" accept=".jpg, .png">
                    </td>
                </tr>
            </table>
        </div> 
        <div>
            <button @click="fnAddMenu">제품 등록</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                foodName : "",
                foodInfo : "",
                price : "",
                menuNo : "", // 소분류 메뉴 번호
                menuPart : "10", // 대분류 메뉴 번호
                menuList : []
            };
        },
        methods: {
            fnMenuList : function () {
                let self = this;
                let param = {
                    depth : 1 // 1차 카테고리만 가져오기
                };
                $.ajax({
                    url: "/product/menu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.menuList = data.menuList;
                    }
                });
            },
            // 파일 업로드를 위해 FormData 사용 방식으로 수정
            fnAddMenu: function () {
                let self = this;
                
                // FormData 객체 생성
                let formData = new FormData();
                
                // 1. 텍스트 데이터 추가
                formData.append('menuNo', self.menuNo);
                formData.append('menuPart', self.menuPart);
                formData.append('foodName', self.foodName);
                formData.append('foodInfo', self.foodInfo);
                formData.append('price', self.price);
                
                // 2. 파일 데이터 추가 (파일이 선택되었을 경우)
                if ($('#file1')[0].files[0]) {
                    formData.append('file1', $('#file1')[0].files[0]);
                }
                
                // 3. jQuery.ajax()를 통해 FormData 전송
                $.ajax({
                    url: "/product/add.dox", 
                    dataType: "json",
                    type: "POST",
                    data: formData, // data에 FormData 객체 전달
                    processData: false, //  Query-string 변환 비활성화
                    contentType: false, //  Multipart/form-data로 전송되도록 contentType 설정 비활성화
                    success: function (data) {
                        if(data.result == "success") {
                            alert("제품이 성공적으로 등록되었습니다.");
                            location.href="/product.do"; 
                        } else {
                            alert("등록에 실패했습니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("서버 통신 중 오류가 발생했습니다.");
                        console.error("Error:", error);
                    }
                });
            }
        },
        mounted() {
            let self = this;
            self.fnMenuList();
        }
    });

    app.mount('#app');
</script>