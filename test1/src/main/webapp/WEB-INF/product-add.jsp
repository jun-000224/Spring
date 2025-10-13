<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        table, tr, td, th { border: 1px solid black; border-collapse: collapse; padding: 5px 10px; }
        th { background-color: beige; width: 100px; }
        input, select, textarea { width: 350px; padding: 5px; }
        .container { width: 600px; margin: 20px auto; }
    </style>
</head>
<body>
    <div id="app" class="container">
        <h1>상품 등록</h1>
        <table>
            <tr>
                <th>음식 종류</th>
                <td>
                    <select v-model="selectedMenu">
                        <option value="">-- 카테고리 선택 --</option>
                        <option v-for="menu in menuItems" :value="menu.menuNo">{{ menu.menuName }}</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>메뉴명</th>
                <td><input v-model="foodName" placeholder="메뉴명을 입력하세요"></td>
            </tr>
            <tr>
                <th>설명</th>
                <td><textarea v-model="foodInfo" rows="5" placeholder="간단한 설명을 입력하세요"></textarea></td>
            </tr>
            <tr>
                <th>가격</th>
                <td><input type="number" v-model="price" placeholder="숫자만 입력하세요"></td>
            </tr>
            <tr>
                <th>이미지</th>
                <td><input type="file" id="fileInput" name="fileInput" accept=".jpg, .png, .jpeg"></td>
            </tr>
        </table>
        <div style="margin-top: 10px; text-align: right;">
            <button @click="fnAdd">저장</button>
            <button onclick="location.href='/product.do'">목록</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                menuItems: [],    // select 태그의 옵션이 될 배열 (e.g., [{menuNo:1, menuName:'한식'}, ...])
                selectedMenu: '', // 선택된 음식 종류의 menuNo
                foodName: '',     // 입력된 메뉴명
                foodInfo: '',     // 입력된 설명
                price: ''         // 입력된 가격
            };
        },
        methods: {
            // 저장 버튼 클릭 시 실행
            fnAdd: function () {
                let self = this;
                
                // 유효성 검사
                if (self.selectedMenu == "") { alert("음식 종류를 선택하세요."); return; }
                if (self.foodName == "") { alert("메뉴명을 입력하세요."); return; }
                if (self.price == "") { alert("가격을 입력하세요."); return; }
                if ($("#fileInput")[0].files.length === 0) { alert("이미지를 선택하세요."); return; }

                // 1. FormData에 파일 정보 먼저 담기
                var form = new FormData();
                form.append("file", $("#fileInput")[0].files[0]);

                // 2. 파일 외 텍스트 정보를 서버로 전송
                let param = {
                    menuNo: self.selectedMenu,
                    foodName: self.foodName,
                    foodInfo: self.foodInfo,
                    price: self.price,
                    // ✨ 우선 임시 파일명/경로를 보내고 실제 파일 처리는 서버에서 함
                    fileName: $("#fileInput")[0].files[0].name,
                    filePath: "/uploads/" // 실제 파일이 저장될 서버 경로 (예시)
                };
                
                $.ajax({
                    url: "/product/add.dox", // 상품 추가 요청
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if (data.result === "success") {
                            alert("상품이 등록되었습니다.");
                            // 여기서 실제 파일 업로드 로직을 추가하거나,
                            // Service에서 한번에 처리했다면 목록 페이지로 이동
                            location.href = "/product.do";
                        } else {
                            alert("등록에 실패했습니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("서버 통신에 실패했습니다. 다시 시도해주세요.");
                    }
                });
            }
        },
        mounted() {
            let self = this;
            // 페이지가 로딩되면 select 태그를 채우기 위해 depth=1인 메뉴 목록을 서버에 요청
            $.ajax({
                url: "/product/getPrimaryMenus.dox",
                dataType: "json",
                type: "POST",
                success: function (data) {
                    self.menuItems = data.menuList;
                }
            });
        }
    });

    app.mount('#app');
</script>