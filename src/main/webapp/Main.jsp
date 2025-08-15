<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/header.jsp"/>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="/css/Main.css">
    <link rel="stylesheet" href="css/groups.css"/>
    <title>home</title>
</head>
<body>

    <div class="main-wrapper">

        <div class="main-container">
            <div class="main-img-container">
                <img class="main-img" src="/img/main-surfingHI.jpg">
                <div class="main-HIimg-text">
                    <h2>"Shaka! 바다는 오늘도 당신을 기다립니다."</h2>
                </div>
            </div>
            <div class="main-img-container">
                <img class="main-img" onclick="location.href='/surfing'" src="/img/main-surfing.jpg">
                <div class="main-img-text">떠나보자</div>
            </div>
            <div class="main-img-container">
                <img class="main-img" onclick="location.href='/groups'" src="/img/main-surfing2.jpg">
                <div class="main-img-text">함께가자</div>
            </div>
        </div>

        <!-- Slider main container -->
        <div class="swiper group-card-swiper">
            <div class="swiper-wrapper">
                <c:forEach var="group" items="${groups}">
                    <div class="swiper-slide">
                        <span class="group-card"
                              data-phone="${group.phone}"
                              data-title="${group.title}"
                              data-user="${group.userName}"
                              data-desc="${group.description}"
                              data-from="${group.fromLocation}"
                              data-to="${group.toLocation}"
                              data-date="${group.meetingDate}"
                              data-members="${group.maxMembers}">
                            <div class="card-header">
                                <div class="card-header-user">
                                    <div class="user-avatar"><img src="${pageContext.servletContext.getInitParameter('profileImage')}/${group.getProfileImagePath()}"/></div>
                                    <span class="user-name">${group.userName}</span>
                                </div>
                            </div>
                            <div class="group-info">
                                ${group.title}
                                <p><strong>From:</strong> ${group.fromLocation}</p>
                                <p><strong>To:</strong> ${group.toLocation}</p>
                                <p><strong>Date:</strong>${group.meetingDate}</p>
                            </div>
                            <button class="view-details-btn">View Details</button>
                        </span>
                    </div>
                </c:forEach>
            </div>
            <div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </div>
        <div class="table-wrapper">
            <table class="post-table">
                <thead>
                <tr>
                    <th>No</th>
                    <th>Title</th>
                    <th>userName</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty posts}">
                    <tr>
                        <td colspan="4">아직 게시글이 없습니다.</td>
                    </tr>
                </c:if>
                <c:if test="${not empty posts}">
                    <c:forEach var="post" items="${posts}" varStatus="status">
                        <tr>
                            <td>${status.index+1}</td>
                            <td><a href="/community/view?id=${post.communityPostId}">${post.title}</a></td>
                            <td>${post.userName}</td>
                            <td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <!-- Details Modal -->
    <div class="modal-wrapper" id="details-modal-wrapper" style="display: none;">
        <div class="details-modal-overlay">
            <div class="details-modal-content">
                <span class="close-details-btn">&times;</span>
                <h2 id="details-title"></h2>
                <p><strong>Created by:</strong> <span id="details-user"></span></p>
                <p><strong>Description:</strong> <span id="details-desc"></span></p>
                <p><strong>From:</strong> <span id="details-from"></span></p>
                <p><strong>To:</strong> <span id="details-to"></span></p>
                <p><strong>Phone:</strong><span id="details-phone"></span></p>
                <p><strong>Date:</strong> <span id="details-date"></span></p>
                <p><strong>Max Members:</strong> <span id="details-members"></span></p>
            </div>
        </div>
    </div>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const swiper = new Swiper('.group-card-swiper', {
            loop: false,  // 마지막index에서 버튼누르면 처음으로 돌아가는
            slidesPerView: 'auto',  // 화면에 기본으로 몇개보여줄지
            spaceBetween: 10,       // 슬라이드 간 간격 픽셀 단위
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });

        const detailsModalWrapper = document.getElementById('details-modal-wrapper');
        const detailsCloseBtn = document.querySelector('.close-details-btn');

        document.querySelectorAll('.view-details-btn').forEach(button => {
            button.addEventListener('click', (event) => {
                const card = event.target.closest('.group-card');
                document.getElementById('details-phone').textContent = card.dataset.phone;
                document.getElementById('details-title').textContent = card.dataset.title;
                document.getElementById('details-user').textContent = card.dataset.user;
                document.getElementById('details-desc').textContent = card.dataset.desc;
                document.getElementById('details-from').textContent = card.dataset.from;
                document.getElementById('details-to').textContent = card.dataset.to;
                document.getElementById('details-date').textContent = card.dataset.date;
                document.getElementById('details-members').textContent = card.dataset.members;
                detailsModalWrapper.style.display = 'block';
            });
        });

        detailsCloseBtn.addEventListener('click', () => {
            detailsModalWrapper.style.display = 'none';
        });

        window.addEventListener('click', (event) => {
            if (event.target === detailsModalWrapper) {
                detailsModalWrapper.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>