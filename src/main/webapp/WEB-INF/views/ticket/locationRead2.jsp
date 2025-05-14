<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="/js/jquery-3.6.0.js"></script>
    <script
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bbbb5ddb701600ead3a6e1ca8df07686&libraries=services"></script>
</head>

<body>
<script type="text/javascript">
    var map;
    var coords;
    document.addEventListener("DOMContentLoaded", function () {
        // 마커를 담을 배열입니다
        var markers = [];

        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(37.5408621, 127.0024870), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도를 생성합니다    
        map = new kakao.maps.Map(mapContainer, mapOption); 

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch('${goodsVO.ticketVO.tkLctnAddress}', function (result, status) {

            // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {

                coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;">${goodsVO.ticketVO.tkLctn}</div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            } else {
                console.error("주소 검색 실패: " + status);
            }


        });
        // Bootstrap 탭 전환 이벤트 바인딩
        const lctnTab = document.getElementById('lctn-tab');
        lctnTab.addEventListener('shown.bs.tab', function (event) {
            setTimeout(function () {
                map.relayout();
                map.setCenter(coords);
            }, 200);
        });



        // 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
        map.setDraggable(false);

        // 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
        map.setZoomable(false);

    });

</script>
</body>
</html>