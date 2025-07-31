<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>surfing</title>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=1xvj76oytg&submodules=geocoder"></script>
    <link rel="stylesheet" href="css/surfing.css"/>
</head>
<body>
  <jsp:include page="header.jsp"/>
  <div class="surfing-wrapper">
      <div class="surfing-wrapper-overlay">
          <h1>지역을 선택해주세요</h1>
          <form method="get" action="/surfing"  >
              <div>
                  <select class="surfing-region-form" name="searchRegion" onchange="searchRegionList(this.value)">
                      <option value="">전체</option>
                      <option value="제주특별자치도">제주특별자치도</option>
                      <option value="강원도">강원도</option>
                      <option value="부산광역시">부산광역시</option>
                      <option value="충청남도">충청남도</option>
                      <option value="전라남도">전라남도</option>
                      <option value="경상남도">경상남도</option>
                      <option value="경상북도">경상북도</option>
                      <option value="울산광역시">울산광역시</option>
                  </select>
              </div>
          </form>
      </div>
      <div id="surfingListContainer">
          <jsp:include page="surfingList.jsp"/>
      </div>

      <!-- Modals -->
      <div id="detailsModal" class="modal-wrapper">
          <div class="modal-content">
              <span class="modal-close-btn" onclick="closeDetailsModal()">&times;</span>
              <div class="modal-header">
                  <h2 id="modalBeachName"></h2>
                  <p id="modalDate"></p>
              </div>
              <div class="modal-body">
                  <div id="am-details">
                      <p class="period">🌊 오전 (<span id="amTotalIndex"></span>)</p>
                      <ul>
                          <li><span>평균 파고</span> <span id="amAvgWvhgt"></span> m</li>
                          <li><span>파도 주기</span> <span id="amAvgWvpd"></span> 초</li>
                          <li><span>풍속</span> <span id="amAvgWspd"></span> m/s</li>
                          <li><span>수온</span> <span id="amAvgWtem"></span> °C</li>
                      </ul>
                  </div>
                  <div id="pm-details">
                      <p class="period">🌊 오후 (<span id="pmTotalIndex"></span>)</p>
                      <ul>
                          <li><span>평균 파고</span> <span id="pmAvgWvhgt"></span> m</li>
                          <li><span>파도 주기</span> <span id="pmAvgWvpd"></span> 초</li>
                          <li><span>풍속</span> <span id="pmAvgWspd"></span> m/s</li>
                          <li><span>수온</span> <span id="pmAvgWtem"></span> °C</li>
                      </ul>
                  </div>
              </div>
          </div>
      </div>

      <div id="mapModal">
          <div id="mapModal-content">
              <button class="mapModal-remove-btn" onclick="closeMapModal()">&times;</button>
              <div id="modalMap" style="width:100%; height:90%;"></div>
              <div id="mapAddress" style="padding-top: 10px; text-align: center; font-size: 1.1em; font-weight: 500;"></div>
          </div>
      </div>
  </div>

<script>
    function searchRegionList(region) {
        fetch("/searchRegion?region=" + encodeURIComponent(region))
            .then(response => response.text())
            .then(html => {
                document.getElementById("surfingListContainer").innerHTML = html;
            })
            .catch(error => {
                console.error("검색 실패:", error);
            });
    }

    const detailsModal = document.getElementById('detailsModal');

    function showDetailsModal(beachName, date, amData, pmData) {
        // Populate Modal Header
        document.getElementById('modalBeachName').innerText = beachName;
        document.getElementById('modalDate').innerText = date;

        // Populate AM details
        if (amData && amData.totalIndex) {
            document.getElementById('am-details').style.display = 'block';
            document.getElementById('amTotalIndex').innerText = amData.totalIndex;
            document.getElementById('amAvgWvhgt').innerText = amData.avgWvhgt || 'N/A';
            document.getElementById('amAvgWvpd').innerText = amData.avgWvpd || 'N/A';
            document.getElementById('amAvgWspd').innerText = amData.avgWspd || 'N/A';
            document.getElementById('amAvgWtem').innerText = amData.avgWtem || 'N/A';
        } else {
            document.getElementById('am-details').style.display = 'none';
        }

        // Populate PM details
        if (pmData && pmData.totalIndex) {
            document.getElementById('pm-details').style.display = 'block';
            document.getElementById('pmTotalIndex').innerText = pmData.totalIndex;
            document.getElementById('pmAvgWvhgt').innerText = pmData.avgWvhgt || 'N/A';
            document.getElementById('pmAvgWvpd').innerText = pmData.avgWvpd || 'N/A';
            document.getElementById('pmAvgWspd').innerText = pmData.avgWspd || 'N/A';
            document.getElementById('pmAvgWtem').innerText = pmData.avgWtem || 'N/A';
        } else {
            document.getElementById('pm-details').style.display = 'none';
        }

        detailsModal.style.display = 'flex';
    }

    function closeDetailsModal() {
        detailsModal.style.display = 'none';
    }

    function showMap(lat, lng) {
        document.getElementById('mapModal').style.display = 'block';
        const mapAddressEl = document.getElementById('mapAddress');
        mapAddressEl.innerText = '주소를 불러오는 중...'; // Set loading state

        const map = new naver.maps.Map('modalMap', {
            center: new naver.maps.LatLng(lat, lng),
            zoom: 15
        });
        new naver.maps.Marker({
            position: new naver.maps.LatLng(lat, lng),
            map: map
        });
        console.log(naver.maps.Service);
        // Reverse Geocoding
        naver.maps.Service.reverseGeocode({
            coords: new naver.maps.LatLng(lat, lng),
            orders: [naver.maps.Service.OrderType.ADDR],
            output: 'json',
            v2: true
        }, function(status, response) {
            console.log("status",status)
            console.log("response" , response)
            console.log(lat,lng)
            if (status !== naver.maps.Service.Status.OK) {
                mapAddressEl.innerText = '주소 조회에 실패했습니다.';
                return;
            }


            const result = response.v2.results[0]; // 응답이 있는 경우
            if (result) {
                const address = result.region.area1.name + " " +
                    result.region.area2.name + " " +
                    result.region.area3.name + " " +
                    (result.land.name || '') + " " +
                    (result.land.number1 || '');
                mapAddressEl.innerText = address.trim();
            } else {
                mapAddressEl.innerText = '주소 정보가 없습니다.';
            }
        });
    }

    function closeMapModal() {
        document.getElementById('mapModal').style.display = 'none';
    }

    // Close modal when clicking outside of it
    window.onclick = function(event) {
        if (event.target === detailsModal) {
            closeDetailsModal();
        }
        if (event.target === document.getElementById('mapModal')) {
            closeMapModal();
        }
    }
</script>


</body>
</html>
