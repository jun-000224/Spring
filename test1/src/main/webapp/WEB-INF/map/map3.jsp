<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5e03846a5bae385cef3b2da33124bd8d&libraries=services"></script>
    <title>첫번째 페이지</title>
    <style>
        /* 카카오 지도 및 검색 스타일 */
        .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
        .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
        .map_wrap {position:relative;width:100%;height:500px;}
        #menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
        .bg_white {background:#fff;}
        #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
        #menu_wrap .option{text-align: center;}
        #menu_wrap .option p {margin:10px 0;}  
        #menu_wrap .option button {margin-left:5px;}
        #placesList li {list-style: none;}
        #placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
        #placesList .item span {display: block;margin-top:4px;}
        #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
        #placesList .item .info{padding:10px 0 10px 55px;}
        #placesList .info .gray {color:#8a8a8a;}
        #placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
        #placesList .info .tel {color:#009900;}
        #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
        #placesList .item .marker_1 {background-position: 0 -10px;}
        #placesList .item .marker_2 {background-position: 0 -56px;}
        #placesList .item .marker_3 {background-position: 0 -102px}
        #placesList .item .marker_4 {background-position: 0 -148px;}
        #placesList .item .marker_5 {background-position: 0 -194px;}
        #placesList .item .marker_6 {background-position: 0 -240px;}
        #placesList .item .marker_7 {background-position: 0 -286px;}
        #placesList .item .marker_8 {background-position: 0 -332px;}
        #placesList .item .marker_9 {background-position: 0 -378px;}
        #placesList .item .marker_10 {background-position: 0 -423px;}
        #placesList .item .marker_11 {background-position: 0 -470px;}
        #placesList .item .marker_12 {background-position: 0 -516px;}
        #placesList .item .marker_13 {background-position: 0 -562px;}
        #placesList .item .marker_14 {background-position: 0 -608px;}
        #placesList .item .marker_15 {background-position: 0 -654px;}
        #pagination {margin:10px auto;text-align: center;}
        #pagination a {display:inline-block;margin-right:10px;}
        #pagination .on {font-weight: bold; cursor: default;color:#777;}
    </style>
</head>
<body>
    <div id="app">
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

            <div id="menu_wrap" class="bg_white">
                <div class="option">
                    <div>
                        <form @submit.prevent="searchPlaces">
                            키워드 : <input v-model="keyword" type="text" size="15"> 
                            <button type="submit">검색하기</button> 
                        </form>
                    </div>
                </div>
                <hr>
                <ul id="placesList">
                    <li v-for="(place, index) in places" :key="index" class="item">
                        <span :class="'markerbg marker_' + (index + 1)"></span>
                        <div class="info">
                            <h5>{{ place.place_name }}</h5>
                            <span v-if="place.road_address_name">{{ place.road_address_name }}</span>
                            <span class="jibun gray" v-if="place.road_address_name">{{ place.address_name }}</span>
                            <span v-else>{{ place.address_name }}</span>
                            <span class="tel">{{ place.phone }}</span>
                        </div>
                    </li>
                </ul>
                <div id="pagination">
                    <a v-for="page in pagination.pages" :key="page" href="#" :class="{ on: page === pagination.current }" @click="gotoPage(page)">
                        {{ page }}
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                keyword: '부평역 맛집',
                places: [],
                markers: [],
                map: null,
                pagination: {
                    current: 1,
                    pages: []
                }
            };
        },
        methods: {
            initializeMap() {
                const mapContainer = document.getElementById('map');
                const mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567),
                    level: 3
                };
                this.map = new kakao.maps.Map(mapContainer, mapOption);
            },
            searchPlaces() {
                const ps = new kakao.maps.services.Places();
                const keyword = this.keyword.trim();

                if (!keyword) {
                    alert('키워드를 입력해주세요!');
                    return;
                }

                ps.keywordSearch(keyword, this.placesSearchCB);
            },
            placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    this.displayPlaces(data, pagination);
                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                    alert('검색 결과가 존재하지 않습니다.');
                } else if (status === kakao.maps.services.Status.ERROR) {
                    alert('검색 결과 중 오류가 발생했습니다.');
                }
            },
            displayPlaces(data, pagination) {
                this.places = data;
                this.pagination.pages = Array.from({ length: pagination.last }, (_, i) => i + 1);
                this.clearMarkers();

                const bounds = new kakao.maps.LatLngBounds();
                data.forEach((place, index) => {
                    const position = new kakao.maps.LatLng(place.y, place.x);
                    const marker = this.addMarker(position, index);
                    bounds.extend(position);
                });

                this.map.setBounds(bounds);
            },
            addMarker(position, index) {
                const imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
                const imageSize = new kakao.maps.Size(36, 37);
                const imgOptions = {
                    spriteSize: new kakao.maps.Size(36, 691),
                    spriteOrigin: new kakao.maps.Point(0, (index * 46) + 10),
                    offset: new kakao.maps.Point(13, 37)
                };
                const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
                const marker = new kakao.maps.Marker({
                    position: position,
                    image: markerImage
                });

                marker.setMap(this.map);
                this.markers.push(marker);
                return marker;
            },
            clearMarkers() {
                this.markers.forEach(marker => marker.setMap(null));
                this.markers = [];
            },
            gotoPage(page) {
                this.pagination.current = page;
                this.searchPlaces();
            }
        },
        mounted() {
            this.initializeMap();
            this.searchPlaces();
        }
    });

    app.mount('#app');
</script>