<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        .form-container { width: 600px; margin: 30px auto; padding: 20px; border: 1px solid #ccc; border-radius: 8px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-size: 16px; font-weight: bold; }
        .form-group input, .form-group textarea { width: 100%; padding: 10px; font-size: 14px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .form-group textarea { height: 200px; resize: vertical; }
        .btn-container { text-align: right; }
        .btn-save { padding: 12px 25px; font-size: 16px; cursor: pointer; background-color: #007bff; color: white; border: none; border-radius: 4px; }
    </style>
</head>
<body>
    <div id="app" class="form-container">
        <h2>게시글 작성</h2>
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" v-model="title" placeholder="제목을 입력하세요">
        </div>
        <div class="form-group">
            <label for="contents">내용</label>
            <textarea id="contents" v-model="contents" placeholder="내용을 입력하세요"></textarea>
        </div>
        <div class="form-group">
            <label for="userId">작성자</label>
            <input type="text" id="userId" :value="userId" readonly style="background-color: #f2f2f2;">
        </div>
        <div class="btn-container">
            <button @click="fnAdd" class="btn-save">저장하기</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                title: '',
                contents: '',
                // JSP의 표현언어(EL)로 세션에 저장된 'sessionId' 값을 직접 가져옴
                userId: '${sessionId}'
            };
        },
        methods: {
            fnAdd: function () {
                if (!this.title.trim()) { alert('제목을 입력해주세요.'); return; }
                if (!this.contents.trim()) { alert('내용을 입력해주세요.'); return; }

                let param = {
                    title: this.title,
                    contents: this.contents,
                    userId: this.userId
                };

                // 오타 수정 ($ajax -> $.ajax), url 수정
                $.ajax({
                    url: "/bbs/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if (data.result === "success") {
                            alert('게시물 등록에 성공하였습니다. (게시물 번호: ' + data.bss_num + ')');
                            // 절대경로로 수정
                            location.href = "/bbs/list.do";
                        } else {
                            alert('게시글 등록에 실패하였습니다.');
                        }
                    },
                    error: function() {
                        alert("서버 통신 중 오류가 발생했습니다.");
                    }
                });
            }
        }
    });
    app.mount('#app');
</script>