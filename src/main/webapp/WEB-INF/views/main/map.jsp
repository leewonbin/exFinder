<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주변검색</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/icon/EFL.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/map.css">
</head>

<body>
   <div class="all">
      <div class="ment">
          주변 은행, 환전소를 찾아보세요!
      </div>
      
        <div class="buttons">
            <button type="button" class="Bbutton" onclick="setActive(this); searchBanks()">은행 보기</button>
            <button type="button" class="Ebutton" onclick="setActive(this); searchCurrencyExchanges()">환전소 보기</button>
           <button class="Lbutton" onclick="moveToCurrentLocation()">
              <img src="${pageContext.request.contextPath}/resources/img/myLocation.png" alt="내 위치 보기" />
          </button>
          </div>
     </div>
          <script>
          function setActive(button) {
              // 모든 버튼에서 active 클래스를 제거
              const buttons = document.querySelectorAll('.Bbutton, .Ebutton');
              buttons.forEach(btn => btn.classList.remove('active'));
      
              // 클릭한 버튼에 active 클래스 추가
              button.classList.add('active');
          }
      </script>
<div class="map_wrap">
   
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
   
    <div id="menu_wrap" class="bg_white">
        
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
    <!-- 현재 위치 보기 버튼 추가 -->
    
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=abdcd2cf7081c6a96785335b69d49326&libraries=services"></script>
<script>
var markers = [];
var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(37.4989, 126.7213),
        level: 10
    };

var map = new kakao.maps.Map(mapContainer, mapOption); 
var ps = new kakao.maps.services.Places();  
var infowindow = new kakao.maps.InfoWindow({zIndex:1});
var currentLocationMarker;

// 페이지가 로드되면 현재 위치를 가져옵니다
window.onload = function() {
    getCurrentLocation();
};

function getCurrentLocation() {
    var lat = 0;
    var lon = 0;
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            lat = position.coords.latitude;
            lon = position.coords.longitude;

            // 위도와 경도를 가져온 후에 실행
            console.log("lat :" + lat);
            console.log("lon :" + lon);
            currentLocation = new kakao.maps.LatLng(lat, lon);
            map.setCenter(currentLocation); // 지도 중심을 내 위치로 이동
            addCurrentLocationMarker(currentLocation); // 내 위치 마커 표시
        }, function() {
            // 위치 정보 가져오기에 실패한 경우 기본 위치 설정
            lat = 37.4910;
            lon = 126.7208;

            // 기본 위치 사용
            console.log("lat (default) :" + lat);
            console.log("lon (default) :" + lon);
            currentLocation = new kakao.maps.LatLng(lat, lon);
            map.setCenter(currentLocation); // 지도 중심을 기본 위치로 이동
            addCurrentLocationMarker(currentLocation); // 기본 위치 마커 표시
        });
    } else {
        alert('Geolocation을 지원하지 않는 브라우저입니다.');
    }
}

//현재 위치로 이동하는 함수
function moveToCurrentLocation() {
    if (currentLocation) {
        map.setCenter(currentLocation); // 지도 중심을 내 위치로 이동
        
    } else {
        alert('현재 위치 정보가 없습니다. 위치를 먼저 가져와 주세요.');
    }
}

//현재 위치를 나타내는 마커를 추가하는 함수
function addCurrentLocationMarker(position) {
    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png', // 카카오맵 기본 위치 마커 이미지
        imageSize = new kakao.maps.Size(24, 35), // 마커 이미지 크기
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

    if (currentLocationMarker) {
        currentLocationMarker.setPosition(position);
    } else {
        currentLocationMarker = new kakao.maps.Marker({
            position: position,
            image: markerImage
        });
        currentLocationMarker.setMap(map);
    }
}

// 카테고리 은행 검색
function searchBanks() {
    if (!currentLocation) {
        alert('먼저 내 위치를 설정해주세요!');
        return false;
    }

    ps.categorySearch('BK9', function(data, status, pagination) {
        placesSearchCB(data, status, pagination);
    }, {
        location: currentLocation, // 현재 위치
        radius: 10000 // 검색 반경 설정 (미터 단위)
    });
}

// 환전소 검색
function searchCurrencyExchanges() {
    if (!currentLocation) {
        alert('먼저 내 위치를 설정해주세요!');
        return false;
    }

    // 환전소 검색을 위해 고정된 키워드 설정
    var keyword = "환전소";
    
    ps.keywordSearch(keyword, function(data, status, pagination) {
        placesSearchCB(data, status, pagination);
    }, {
        location: currentLocation, // 현재 위치
        radius: 5000 // 검색 반경 설정 (미터 단위)
    });
}

function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        // 각 장소에 대해 현재 위치와의 거리 계산 후 정렬
        var placesWithDistance = data.map(place => ({
            ...place,
            distance: calculateDistance(currentLocation.getLat(), currentLocation.getLng(), place.y, place.x)
        }));

        // 거리 순으로 정렬
        placesWithDistance.sort((a, b) => a.distance - b.distance);
        
        displayPlaces(placesWithDistance); // 정렬된 검색 결과를 표시합니다.
        displayPagination(pagination);
    } else {
        alert('검색 결과가 존재하지 않습니다.');
    }
}
//두 지점 간의 거리 계산 (단위: 미터)
function calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371000; // 지구의 반지름 (미터)
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
              Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c; // 두 지점 간의 거리
    return distance; // 미터 단위로 반환
}

function displayPlaces(places) {
    var listEl = document.getElementById('placesList'), 
        menuEl = document.getElementById('menu_wrap'),
        fragment = document.createDocumentFragment(), 
        bounds = new kakao.maps.LatLngBounds();

    removeAllChildNods(listEl);
    removeMarker();

    for (var i = 0; i < places.length; i++) {
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i], places[i].distance); // 거리 정보 전달

        bounds.extend(placePosition);

        (function(marker, title, itemEl, placePosition) {
            kakao.maps.event.addListener(marker, 'click', function() {
                highlightItem(itemEl); // 리스트 항목 강조
                displayInfowindow(marker, title); // 인포윈도우 표시
                itemEl.scrollIntoView({ behavior: 'smooth', block: 'nearest' }); // 강조된 항목이 보이도록 스크롤
            });

            itemEl.onclick = function() { // 리스트 항목 클릭 이벤트 추가
                highlightItem(itemEl); // 리스트 항목 강조
                map.setCenter(placePosition); // 지도 중심을 해당 장소로 이동
                displayInfowindow(marker, title); // 인포윈도우 표시
            };

            itemEl.onmouseover = function() {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout = function() {
                infowindow.close();
            };
        })(marker, places[i].place_name, itemEl, placePosition);

        fragment.appendChild(itemEl);
    }

    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    map.setBounds(bounds);
}

function getListItem(index, places, distance) { // 거리 정보 추가
    var el = document.createElement('li'),
        itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                   '<div class="info">' +
                   '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' + places.address_name + '</span>';
    } else {
        itemStr += '    <span>' + places.address_name + '</span>'; 
    }

    
    
    
 // 거리 정보 표시: 1km 이상일 때는 km, 1km 이하일 때는 m 단위로 표시
    let distanceText;
    if(distance>=1000){
       distanceText = (distance / 1000).toFixed(2) + ' km';
       
    }else{
       distanceText = Math.floor(distance) + ' m';
    }
    
    itemStr += '  <span class="tel">' + places.phone + '</span>' +
                '  <span class="distance">거리: ' + distanceText + '</span>' + // 거리 정보 표시
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

function addMarker(position, idx) {
    var imageSrc = '${pageContext.request.contextPath}/resources/img/marker.png', // 변경된 이미지 URL
        imageSize = new kakao.maps.Size(36, 37),
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
        marker = new kakao.maps.Marker({
            position: position,
            image: markerImage
        });

    marker.setMap(map);
    markers.push(marker); // 마커 저장
    return marker;
}

function removeMarker() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
}

function removeAllChildNods(el) {
    while (el.hasChildNodes()) {
        el.removeChild(el.lastChild);
    }
}

function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        current = pagination.current,
        total = pagination.totalPages;

    removeAllChildNods(paginationEl);

    for (var i = 1; i <= total; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (current === i) {
            el.className = 'on';
        } else {
            el.onclick = (function(index) {
                return function() {
                    pagination.gotoPage(index);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
    infowindow.setContent(content);
    infowindow.open(map, marker);
}

//리스트 항목 강조하는 함수
function highlightItem(itemEl) {
    var listItems = document.querySelectorAll('#placesList .item');
    listItems.forEach(function(item) {
        item.classList.remove('highlight');
        item.style.backgroundColor = ''; // 배경색 초기화
    });
    itemEl.classList.add('highlight');
    /* itemEl.style.backgroundColor = '#05203C'; */ // 강조색 변경
}
</script>
</body>
</html>
