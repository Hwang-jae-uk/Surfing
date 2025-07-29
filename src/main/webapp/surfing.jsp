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
      <div id="surfingListContainer">
          <jsp:include page="surfingList.jsp"/>
      </div>
  </div>


</body>
</html>
