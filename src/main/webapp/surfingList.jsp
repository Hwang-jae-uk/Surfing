<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="css/surfingList.css"/>

<div class="surfing-list-wrapper">
    <div class="surfing-list-header">
        <h1>Surfing Grade Forecast</h1>
    </div>

    <div class="surfing-cards-container">
        <c:forEach var="entry" items="${groupedData}">
            <c:set var="surfingList" value="${entry.value.items}" />
            <div class="surfing-card">
                <div class="card-header">
                    <span class="beach-name">${entry.key}</span>
                    <button class="map-btn" type="button" onclick="showMap(${surfingList[0].lat}, ${surfingList[0].lot} , '${entry.value.address}')">지도보기</button>
                </div>
                <div class="forecast-list">
                    <c:forEach var="i" begin="0" end="${fn:length(surfingList) - 1}" step="2">
                        <c:set var="am" value="${surfingList[i]}" />
                        <c:set var="pm" value="${surfingList[i+1]}" />
                        <div class="forecast-item" onclick="showDetailsModal(
                            '${entry.key}',
                            '${am.predcYmd}',
                            {avgWvhgt: '${am.avgWvhgt}', avgWvpd: '${am.avgWvpd}', avgWspd: '${am.avgWspd}', avgWtem: '${am.avgWtem}', lastScr: '${am.lastScr}', totalIndex: '${am.totalIndex}'},
                            {avgWvhgt: '${pm.avgWvhgt}', avgWvpd: '${pm.avgWvpd}', avgWspd: '${pm.avgWspd}', avgWtem: '${pm.avgWtem}', lastScr: '${pm.lastScr}', totalIndex: '${pm.totalIndex}'}
                        )">
                            <span class="forecast-date">${am.predcYmd}</span>
                            <div class="grades">
                                <c:if test="${not empty am.totalIndex}">
                                    <span class="forecast-grade grade-${am.lastScr}">오전: ${am.totalIndex}</span>
                                </c:if>
                                <c:if test="${not empty pm.totalIndex}">
                                    <span class="forecast-grade grade-${pm.lastScr}">오후: ${pm.totalIndex}</span>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>
</div>



