<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1f4d04f740efab89a992e3007585da78&libraries=services"></script>
</head>
<body>
    <div id="app">
        <div id="map" style="width:500px; height:400px;"></div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                map: null,
                infowindow: null
            };
        },
        methods: {
            fnList: function () {
                let self = this;
                let param = {};
                // [참고] AJAX URL 오타 수정: mpa2 -> map2
                $.ajax({
                    url: "/map/map2", // .do 확장자가 필요하면 추가하세요.
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        // ex) 여기서 self.map을 이용해 지도에 마커를 추가할 수 있습니다.
                    }
                });
            }
        },
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;

            self.map = new kakao.maps.Map(mapContainer, mapOption);
        }
    });

    app.mount('#app');
</script>