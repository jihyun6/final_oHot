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
    <div class="col-sm-12" id="map" style="width: 100%; height: 450px;">
        <div id="menu_wrap" class="bg_white flex"
            style="position:absolute;top:10px;left:10px;z-index:10;width:250px;height:120px;overflow:auto;padding:5px;border:1px solid #ccc;background:#ffffff;">
            <div class="input-group">
            </div>
            <hr style="margin: 10px 0 5px 0;">
            <div id="placesList" ></div>
        </div>
    </div>


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

        // 장소 검색 객체를 생성합니다
        var ps = new kakao.maps.services.Places();


        // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
        ps.keywordSearch('${goodsVO.ticketVO.tkLctn}', placesSearchCB);


        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {

                // 정상적으로 검색이 완료됐으면
                // 검색 목록과 마커를 표출합니다
                displayPlaces(data);


            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                alert('검색 결과가 존재하지 않습니다.');
                return;

            } else if (status === kakao.maps.services.Status.ERROR) {

                alert('검색 결과 중 오류가 발생했습니다.');
                return;

            }
        }


        // 검색 결과 목록과 마커를 표출하는 함수입니다
        function displayPlaces(places) {

            var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            listStr = '';

            // 검색 결과 목록에 추가된 항목들을 제거합니다
            removeAllChildNods(listEl);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();


            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new kakao.maps.LatLng(places[0].y, places[0].x),
            marker = addMarker(placePosition, 0),
            itemEl = getListItem(0, places[0]); // 검색 결과 항목 Element를 생성합니다

            fragment.appendChild(itemEl);

            // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            coords = placePosition;

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setCenter(placePosition);


        }

        // 검색결과 항목을 Element로 반환하는 함수입니다
    function getListItem(index, places) {
        

        var el = document.createElement('div'),
            itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                '<div class="info" style="font-size:12px;">' +
                '   <h5 style="font-size:15px;">' + places.place_name + '</h5>';

        if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span><br>' ;
        } else {
            itemStr += '    <span>' + places.address_name + '</span>';
        }

        itemStr += '  <span class="tel">' + places.phone + '</span>' +
            '</div>';

        el.innerHTML = itemStr;
        el.className = 'item';

        return el;
    }

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions = {
                spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
    }



    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
        }
    }	
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