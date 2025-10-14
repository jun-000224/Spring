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
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1f4d04f740efab89a992e3007585da78&libraries=services"></script>

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
        <select style="margin-bottom : 20px; padding:5px" v-model="key" @change="fnChange">
            <option value="">:: 선택 ::</option>
            <option value="MT1">대형마트</option>
            <option value="CS2">편의점</option>
            <option value="PS3">어린이집, 유치원</option>
            <option value="SC4">학교</option>
            <option value="AC5">학원</option>
            <option value="PK6">주차장</option>
            <option value="OL7">주유소, 충전소</option>
            <option value="SW8">지하철역</option>
            <option value="BK9">은행</option>
            <option value="CT1">문화시설</option>
            <option value="AG2">중개업소</option>
            <option value="PO3">공공기관</option>
            <option value="AT4">관광명소</option>
            <option value="AD5">숙박</option>
            <option value="FD6">음식점</option>
            <option value="CE7">카페</option>
            <option value="HP8">병원</option>
            <option value="PM9">약국</option>
        </select>
        <div id="map" style="width:500px;height:400px;"></div>
    </div>
</body>

</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                key: '',
                infowindow: null,
                map: null,
                markers: [],
            };
        },
        methods: {
            // 함수(메소드) - (key : function())

            // select 값이 변경될 때 호출되는 새로운 메소드
            fnChange: function () {
                this.clearMarkers();
                if (this.key) { // v-model을 통해 이미 data의 key 값은 변경된 상태
                    this.searchPlaces(this.key);
                }
            },
            searchPlaces: function (categoryCode) {
                var ps = new kakao.maps.services.Places(this.map);
                ps.categorySearch(categoryCode, this.placesSearchCB, { useMapBounds: true });
            },
            clearMarkers: function () {
                for (let i = 0; i < this.markers.length; i++) {
                    this.markers[i].setMap(null);
                }
                this.markers = [];
            },
            // 키워드 검색 완료 시 호출되는 콜백함수 입니다
            placesSearchCB: function (data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    for (var i = 0; i < data.length; i++) {
                        this.displayMarker(data[i]);
                    }
                }
            },
            // 지도에 마커를 표시하는 함수입니다
            displayMarker: function (place) {
                let self = this;
                // 마커를 생성하고 지도에 표시합니다
                var marker = new kakao.maps.Marker({
                    map: this.map,
                    position: new kakao.maps.LatLng(place.y, place.x)
                });

                this.markers.push(marker);

                kakao.maps.event.addListener(marker, 'click', function () {
                    self.infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                    self.infowindow.open(self.map, marker);
                });
            },
        },
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;

            // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
            self.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                    level: 5 // 지도의 확대 레벨
                };

            // 지도를 생성합니다      
            self.map = new kakao.maps.Map(mapContainer, mapOption);
        }
    });

    app.mount('#app');
</script>