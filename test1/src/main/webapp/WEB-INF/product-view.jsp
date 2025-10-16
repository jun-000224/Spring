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
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
                제품명 : {{info.foodName}}
            </div>
            <div>
                가격 : {{info.price}}
            </div>
            <div>
                정보 : {{info.foodInfo}}
            </div>
            <div>
                개수 : <input v-model="num">
            </div>
            <div>
                <button @Click="fnPayment">주문하기</button>
            </div>
        </div>
    </body>

    </html>

    <script>
        IMP.init("imp26875526");
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    foodNo: "${foodNo}",
                    foodName: "${foodName}",
                    sessionId: "${sessionId}",
                    info: {},
                    num: 1
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnInfo: function () {
                    let self = this;
                    let param = {
                        foodNo: self.foodNo
                    };
                    $.ajax({
                        url: "/product/view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.info = data.info;
                        },
                    });
                },
                fnPayment() {
                    let self = this;
                    IMP.request_pay({
                        pg: "kakaopay", //원하는 채널의 PG값 넣기
                        pay_method: "card",
                        merchant_uid: "merchant_" + new Date().getTime(),
                        name: self.info.foodName,
                        amount: 1 * self.num, //self.info.price * self.num
                        buyer_tel: "010-0000-0000",
                    }, function (rsp) { // callback
                        console.log(rsp);
                        if (rsp.success) {
                            // 결제 성공 시
                            alert("성공");
                            console.log(rsp);
                            self.fnPayHistory(rsp.imp_uid, rsp.paid_amount);

                        } else {
                            // 결제 실패 시
                            alert("실패");
                            console.log(rsp);
                        }
                    });
                },
                fnPayHistory: function (uid, amount) {
                    let self  = this;
                    let param = {
                        foodNo : self.foodNo,
                        uid : uid,
                        amount : amount,
                        userId : self.sessionId
                    };
                    $.ajax({
                        url: "/payment/payment.dox",
                        type: "POST",
                        data: param,
                        success: function (data){
                            alert("성공적으로 결제되었습니다!");
                        },
                    })
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnInfo();
            }



        });

        app.mount('#app');
    </script>