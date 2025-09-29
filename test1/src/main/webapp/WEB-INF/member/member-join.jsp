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
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div>
                <label>아이디 : <input v-model="id"></label>
                <button @click="fnCheck">중복체크</button>
            </div>
            <div>
                <label>비밀번호 : <input type="password" v-model="pwd"></label>
            </div>
            <div>
                주소 : <input v-model="addr"><button @click="fnAddr">주소검색</button>
            </div>
            <div>
                문자인증 : <input> <button @click="fnSms">인증번호 전송</button>
            </div>
        </div>
    </body>

    </html>

    <script>
        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            console.log(roadFullAddr);
            console.log(addrDetail);
            console.log(zipNo);
            window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
        }





        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    id: "",
                    pwd: "",
                    addr: ""
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnCheck: function () {
                    let self = this;
                    let param = {
                        id : self.id
                    };
                    $.ajax({
                        url: "/member/check.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if(data.result == "true"){
                                alert("이미 사용중인 아아디 입니다!")
                            }else{
                                alert("사용 가능한 아아디 입니다!")
                            }
                        }
                    });
                },
                fnAddr : function(){
                    window.open("/addr.do", "addr", "width=500, hegight=500");
                },
                fnResult : function(roadFullAddr, addrDetail, zipNo){
                    let self = this;
                    self.addr = roadFullAddr;
                },
                fnSms : function(){
                    let self = this;
                    let param = {
                    };
                    $.ajax({
                        url: "/send-one",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                        }
                    });
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                window.vueObj = this;

            }
        });

        app.mount('#app');
    </script>