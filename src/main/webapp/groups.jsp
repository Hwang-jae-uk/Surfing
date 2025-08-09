<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find a Surf Group</title>
    <link rel="stylesheet" href="css/groups.css"/>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="groups-wrapper">
        <div class="groups-header">
            <h1>Find a Surf Group</h1>
            <div class="header-actions">
                <button id="search-btn" class="search-action-btn">Search</button>
                <button onclick="location.href='/creategroup'" class="create-group-btn">Create Group</button>
            </div>
        </div>

        <div class="group-card-wrapper">
            <c:forEach var="group" items="${groups}">
                <div class="group-cards-container">
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
                                <div class="user-avatar"></div>
                                <span class="user-name">${group.userName}</span>
                            </div>
                                <c:if test="${user.email != null && user.userId == group.userId }">
                                    <form class="group-delete-form" action="/groups" method="post" onclick="confirm('정말로 삭제하시겠습니까?')">
                                        <input type="hidden" name="groupId" value="${group.groupMeetingId}">
                                        <button type="submit" class="btn-delete-comment" >삭제하기</button>
                                    </form>
                                </c:if>
                                <c:if test="${!(user.email != null && user.userId == group.userId)}">
                                    <span><fmt:formatDate value="${group.createdAt}" pattern="yyyy-MM-dd a hh"/>시 </span>
                                </c:if>
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
    </div>

    <!-- Search Modal -->
    <div class="modal-wrapper" id="search-modal-wrapper" style="display: none">
        <div id="search-modal" class="search-modal-overlay" >
            <div class="search-modal-content">
                <span class="close-btn">&times;</span>
                <h2>Search for a Group</h2>
                <form id="group-search-form">
                    <div class="search-input-group">
                        <label for="from-location">From</label>
                        <input type="text" id="from-location" placeholder="e.g., Seoul">
                    </div>
                    <div class="search-input-group">
                        <label for="to-location">To</label>
                        <input type="text" id="to-location" placeholder="e.g., Yangyang">
                    </div>
                    <div class="search-input-group">
                        <label for="search-date">Date</label>
                        <input type="date" id="search-date">
                    </div>
                    <button type="submit" class="find-btn">Find Groups</button>
                </form>
            </div>
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


    <script>
        // Search Modal handling
        const searchBtn = document.getElementById('search-btn');
        const searchModalWrapper = document.getElementById('search-modal-wrapper');
        const searchCloseBtn = document.querySelector('.close-btn');

        searchBtn.addEventListener('click', () => {
            searchModalWrapper.style.display = 'block';
        });

        searchCloseBtn.addEventListener('click', () => {
            searchModalWrapper.style.display = 'none';
        });

        window.addEventListener('click', (event) => {
            if (event.target === searchModalWrapper) {
                searchModalWrapper.style.display = 'none';
            }
        });

        // Details Modal handling
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


        // Search/Filter logic
        document.getElementById('group-search-form').addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent form submission

            const fromValue = document.getElementById('from-location').value.toLowerCase();
            const toValue = document.getElementById('to-location').value.toLowerCase();
            const dateValue = document.getElementById('search-date').value;

            const groupCards = document.querySelectorAll('.group-card');

            groupCards.forEach(card => {
                const cardFrom = card.dataset.from.toLowerCase();
                const cardTo = card.dataset.to.toLowerCase();
                const cardDate = card.dataset.date;

                const fromMatch = fromValue === '' || cardFrom.includes(fromValue);
                const toMatch = toValue === '' || cardTo.includes(toValue);
                const dateMatch = dateValue === '' || cardDate === dateValue;

                if (fromMatch && toMatch && dateMatch) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });

            searchModalWrapper.style.display = 'none'; // Hide modal after search
        });
    </script>
</body>
</html>
