<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Places SearchBox Example</title>
    <style>
        /* 검색 박스 스타일 */
        #searchBox {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 10;
            background: white;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.3);
        }
        /* 버튼 스타일 */
        #refreshButton {
            position: absolute;
            top: 10px;
            left: 60%; /* 검색 박스 옆에 위치 */
            transform: translateX(-50%);
            z-index: 10;
            padding: 10px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        #refreshButton:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
    <!-- 검색 박스 -->
    <input id="searchBox" type="text" value="환전은행" placeholder="검색할 장소 입력" />

    <!-- 위치 재조회 버튼 -->
    <button id="refreshButton">내 위치</button>

    <!-- 지도 표시할 DIV -->
    <div id="googleMap" style="width: 100%; height: 700px;"></div>

    <script>
        let map;
        let markers = []; // 마커 배열
        let infowindow;
        let currentLocationMarker; // 현재 위치 마커

        // 지도를 초기화하는 함수
        function initMap() {
            const mapOptions = { 
                center: new google.maps.LatLng(37.5665, 126.978), // 서울 중심
                zoom: 10
            };

            map = new google.maps.Map(
                document.getElementById("googleMap"),
                mapOptions
            );

            // 검색 박스 생성
            const input = document.getElementById("searchBox");
            const searchBox = new google.maps.places.SearchBox(input);

            // 인포윈도우 설정
            infowindow = new google.maps.InfoWindow();

            // 현재 위치 가져오기
            getCurrentLocation();

            // 검색 박스의 장소가 변경될 때 이벤트 리스너 추가
            searchBox.addListener("places_changed", () => {
                const places = searchBox.getPlaces();

                // 검색 결과가 없는 경우
                if (places.length == 0) {
                    return;
                }

                // 마커를 지우고 새로 생성하기 위해 배열 초기화
                markers.forEach(marker => marker.setMap(null));
                markers = [];

                // 모든 장소에 대해 마커와 인포윈도우 설정
                places.forEach(place => {
                    if (!place.geometry) {
                        console.log("Returned place contains no geometry");
                        return;
                    }

                    // 마커 생성
                    const marker = new google.maps.Marker({
                        map: map,
                        position: place.geometry.location,
                    });

                    // 클릭 시 Google Maps로 이동
                    google.maps.event.addListener(marker, 'click', () => {
                        // 장소의 URL을 생성
                        const placeUrl = `https://www.google.com/maps/place/?q=place_id:${place.place_id}`;
                        // 클릭 시 Google Maps로 이동
                        window.open(placeUrl, '_blank'); // 새 탭에서 열기
                    });

                    markers.push(marker); // 생성된 마커를 배열에 추가

                    // 지도를 해당 장소로 이동
                    if (place.geometry.viewport) {
                        map.fitBounds(place.geometry.viewport);
                    } else {
                        map.setCenter(place.geometry.location);
                        map.setZoom(15);
                    }
                });
            });
        }

        // 현재 위치 가져오기
        function getCurrentLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition((position) => {
                    const currentLocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };

                    // 지도를 현재 위치로 이동
                    map.setCenter(currentLocation); 

                    // 현재 위치 마커 표시
                    if (currentLocationMarker) {
                        currentLocationMarker.setMap(null); // 이전 마커 제거
                    }

                    currentLocationMarker = new google.maps.Marker({
                        position: currentLocation,
                        map: map,
                        title: "내 위치",
                        icon: {
                            url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" // 파란 점 아이콘
                        }
                    });

                    searchNearbyPlaces(currentLocation); // 주변 장소 검색
                }, () => {
                    handleLocationError(true, map.getCenter());
                });
            } else {
                handleLocationError(false, map.getCenter());
            }
        }

        // 현재 위치 주변에 "환전은행" 검색
        function searchNearbyPlaces(location) {
            const request = {
                location: location,
                radius: '5000', // 반경 5km
                keyword: '환전은행' // 고정된 검색어
            };

            const service = new google.maps.places.PlacesService(map);
            service.nearbySearch(request, (results, status) => {
                if (status === google.maps.places.PlacesServiceStatus.OK) {
                    markers.forEach(marker => marker.setMap(null)); // 이전 마커 제거
                    markers = []; // 배열 초기화

                    results.forEach(place => {
                        // 마커 생성
                        const marker = new google.maps.Marker({
                            map: map,
                            position: place.geometry.location,
                        });

                        // 클릭 시 Google Maps로 이동
                        google.maps.event.addListener(marker, 'click', () => {
                            // 장소의 URL을 생성
                            const placeUrl = `https://www.google.com/maps/place/?q=place_id:${place.place_id}`;
                            // 클릭 시 Google Maps로 이동
                            window.open(placeUrl, '_blank'); // 새 탭에서 열기
                        });

                        markers.push(marker); // 생성된 마커를 배열에 추가
                    });
                } else {
                    console.error('Nearby search failed: ' + status);
                }
            });
        }

        // 위치 오류 처리
        function handleLocationError(browserHasGeolocation, pos) {
            infowindow.setContent(browserHasGeolocation ?
                'Error: The Geolocation service failed.' :
                'Error: Your browser doesn\'t support geolocation.');
            infowindow.setPosition(pos);
            infowindow.open(map);
        }

        // 위치 재조회 버튼 클릭 시 현재 위치 재조회
        document.getElementById('refreshButton').addEventListener('click', () => {
            getCurrentLocation();
        });

        // Google Maps 스크립트가 로드된 후 호출
        window.addEventListener('DOMContentLoaded', (event) => {
            // Google Maps API 로드
            const script = document.createElement('script');
            script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyDFufL6lOYJtGe4s2iz3zlDQTkQQeb8bOw&libraries=places&callback=initMap";
            script.async = true;
            script.defer = true;
            document.body.appendChild(script);
        });
    </script>
</body>
</html>
