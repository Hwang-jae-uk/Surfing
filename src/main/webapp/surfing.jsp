<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>surfing</title>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=1xvj76oytg&submodules=geocoder"></script>
    <link rel="stylesheet" href="css/surfing.css"/>
</head>
<jsp:include page="header.jsp"/>
<body>
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
    window.onload = function () {
        const regionSelect = document.querySelector('select[name="searchRegion"]');
        const defaultValue = regionSelect.value;

        // 처음 들어오면 전체 데이터를 로딩하도록 호출
        if (defaultValue === "") {
            searchRegionList(""); // 전체 요청
        }
    };

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

    function showMap(lat , lot , address) {
        document.getElementById('mapModal').style.display = 'block';
        const mapAddressEl = document.getElementById('mapAddress');
        mapAddressEl.innerText = address;

        const map = new naver.maps.Map('modalMap', {
            center: new naver.maps.LatLng(lat, lot),
            zoom: 15,
            mapTypeControl: true
        });

        const marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(lat, lot),
            map: map
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
