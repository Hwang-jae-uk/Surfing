<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>surfing</title>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=1xvj76oytg"></script>
    <link rel="stylesheet" href="css/surfing.css"/>
</head>
<body>
  <jsp:include page="header.jsp"/>
  <div class="surfing-wrapper">
      <form method="get" action="/surfing" >
          <div>
              <select name="searchRegion" onchange="searchRegionList(this.value)">
                  <option value="제주특별자치도">제주특별자치도</option>
                  <option value="강원도">강원도</option>
                  <option value="부산광역시">부산광역시</option>
                  <option value="충청남도">충청남도</option>
                  <option value="전라남도">전라남도</option>
                  <option value="경상남도">경상남도</option>
                  <option value="경상북도">경상북도</option>
                  <option value="울산광역시">울산광역시</option>
              </select>
              <label>해수욕장 명 : </label>
              <input type="text" name="searchword">
              <button type="submit">검색</button>
          </div>
      </form>
      <c:forEach var="i" begin="0" end="${fn:length(surfingDataList)-1}" step="2" varStatus="status">
        <div class="surfingInfo-wrapper">
            <div>
                <span>${surfingDataList[i].surfPlcNm}</span>
                <span>${surfingDataList[i].predcNoonSeCd}</span>
            </div>
            <div>
                <span><strong>오전 : </strong></span>
                <span>파도 평균 높이 : ${surfingDataList[i].avgWvhgt}</span>
                <span>파도 주기 : ${surfingDataList[i].avgWvpd}</span>
                <span>평균 풍속 : ${surfingDataList[i].avgWspd}</span>
                <span>평균 수온 : ${surfingDataList[i].avgWtem}</span>
                <span>서핑 등급 : ${surfingDataList[i].totalIndex}</span>
                <span>서핑 지수 점수 : ${surfingDataList[i].lastScr}</span>
            </div>
            <div>
                <span><strong>오후 : </strong></span>
                <span>파도 평균 높이 : ${surfingDataList[i+1].avgWvhgt}</span>
                <span>파도 주기 : ${surfingDataList[i+1].avgWvpd}</span>
                <span>평균 풍속 : ${surfingDataList[i+1].avgWspd}</span>
                <span>평균 수온 : ${surfingDataList[i+1].avgWtem}</span>
                <span>서핑 등급 : ${surfingDataList[i+1].totalIndex}</span>
                <span>서핑 지수 점수 : ${surfingDataList[i+1].lastScr}</span>
            </div>
        </div>
        <button type="button" onclick="showMap(${surfingDataList[i].lat}, ${surfingDataList[i].lot})">지도보기</button>
        <div id="mapModal">
            <button class="mapModal-remove-btn" onclick="closeModal()">&times;</button>
            <div id="modalMap" style="width:100%; height:100%;"></div>
        </div>
      </c:forEach>
  </div>
  <script>
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

      function closeModal() {
          document.getElementById('mapModal').style.display = 'none';
          // document.getElementById('modalMap').innerHTML = ''; // 지도를 초기화해서 다시 로딩되도록
      }

      <%--function searchRegionList(region){--%>
      <%--    fetch(`/searchRegionList?region=` + encodeURIComponent(region))--%>
      <%--        .then(response => response.json())--%>
      <%--        .then(data => {--%>
      <%--            const container = document.querySelector(".surfing-wrapper")--%>
      <%--            container.innerHTML = '';--%>

      <%--            data.forEach((item , idx) => {--%>
      <%--                const surfHtml=`--%>
      <%--                <div class="surfingInfo-wrapper">--%>
      <%--                  <div><span>${item.surfPlcNm}</span><span>${item.predcNoonSeCd}</span></div>--%>
      <%--                  <div><strong>오전 : </strong>--%>
      <%--                      <span>파도 평균 높이 : ${item.avgWvhgt}</span>--%>
      <%--                      <span>파도 주기 : ${item.avgWvpd}</span>--%>
      <%--                      <span>평균 풍속 : ${item.avgWspd}</span>--%>
      <%--                      <span>평균 수온 : ${item.avgWtem}</span>--%>
      <%--                      <span>서핑 등급 : ${item.totalIndex}</span>--%>
      <%--                      <span>서핑 지수 점수 : ${item.lastScr}</span>--%>
      <%--                  </div>--%>
      <%--                  <div><strong>오후 : </strong>--%>
      <%--                      <span>파도 평균 높이 : ${item.avgWvhgt}</span>--%>
      <%--                      <span>파도 주기 : ${item.avgWvpd}</span>--%>
      <%--                      <span>평균 풍속 : ${item.avgWspd}</span>--%>
      <%--                      <span>평균 수온 : ${item.avgWtem}</span>--%>
      <%--                      <span>서핑 등급 : ${item.totalIndex}</span>--%>
      <%--                      <span>서핑 지수 점수 : ${item.lastScr}</span>--%>
      <%--                  </div>--%>

      <%--                  <button onclick="showMap(${item.lat}, ${item.lot})">지도보기</button>--%>
      <%--                </div>`;--%>
      <%--                container.innerHTML += surfHtml;--%>
      <%--            })--%>
      <%--        })--%>
      <%--}--%>
  </script>
</body>
</html>
