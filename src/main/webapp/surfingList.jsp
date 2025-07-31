<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="css/surfing.css"/>

<c:forEach var="entry" items="${groupedData}">
  <div class="surfingGroup">
    <c:set var="surfingList" value="${entry.value}" />
    <div class="surfingMap">
      <h2 style="display: inline-block">${entry.key}</h2> <!-- 해수욕장 이름 -->
      <button class="map-btn" type="button" onclick="showMap('${surfingList[0].lat}', '${surfingList[0].lot}')">지도보기</button>
    </div>
    <div id="mapModal">
        <button class="mapModal-remove-btn" onclick="closeMapModal()">&times;</button>
        <div id="modalMap" style="width:100%; height:100%;"></div>
    </div>
    <div class="surfing-region-info">
      <c:forEach var="i" begin="0" end="${(surfingList.size()) - 1}" step="2">
        <div onclick="showModal(${i})" class="surfing-region-info-detail">
          <div>📅${surfingList[i].predcYmd}</div>
          <div>🌊오전: ${surfingList[i].totalIndex} (${surfingList[i].lastScr})</div>
          <c:if test="${!empty surfingList[i+1].lastScr}">
            <div>🌊오후: ${surfingList[i+1].totalIndex} (${surfingList[i+1].lastScr})</div>
          </c:if>
        </div>
      </c:forEach>
    </div>
    <div class="surfing-region-info">
      <c:forEach var="i" begin="0" end="${fn:length(surfingList) - 1}" step="2">
        <!-- 상세 모달 내용 -->
        <div id="modal-${i}" class="modal" style="display:none;" >
          <div id="modal-content-${i}" >
            <h3 style="cursor: pointer" onclick="closeSurfingInfoModal(${i})" >${surfingList[i].predcYmd} &nbsp;&nbsp;-&nbsp;&nbsp; 닫기</h3>
            <p>🌊 오전</p>
            <ul>
              <li>평균 높이: ${surfingList[i].avgWvhgt}</li>
              <li>파도 주기: ${surfingList[i].avgWvpd}</li>
              <li>풍속: ${surfingList[i].avgWspd}</li>
              <li>수온: ${surfingList[i].avgWtem}</li>
            </ul>
            <c:if test="${surfingList[i+1].avgWvhgt != '' && surfingList[i+1].avgWvhgt!= ' ' &&!empty surfingList[i+1].avgWvhgt}">
              <p>🌊 오후</p>
              <ul>
                <li>평균 높이: ${surfingList[i+1].avgWvhgt}</li>
                <li>파도 주기: ${surfingList[i+1].avgWvpd}</li>
                <li>풍속: ${surfingList[i+1].avgWspd}</li>
                <li>수온: ${surfingList[i+1].avgWtem}</li>
              </ul>
            </c:if>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</c:forEach>
<script>
  function showModal(id) {
    document.getElementById("modal-" + id).style.display = "block";
  }
  function closeSurfingInfoModal(id){
    document.getElementById("modal-" + id).style.display="none"
  }
  function showMap(lat, lng) {
    document.querySelector('#mapModal').style.display = 'block';

    const map = new naver.maps.Map('modalMap', {
      center: new naver.maps.LatLng(lat, lng),
      zoom: 10
    });

    new naver.maps.Marker({
      position: new naver.maps.LatLng(lat, lng),
      map: map
    });
  }

  function closeMapModal() {
    document.getElementById('mapModal').style.display = 'none';
  }
 


</script>

