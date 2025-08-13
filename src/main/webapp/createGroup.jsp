<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create a New Surf Group</title>
    <link rel="stylesheet" href="/css/createGroup.css"/>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="create-group-wrapper">
        <div class="create-group-header">
            <h1>Create a New Surf Group</h1>
        </div>
        <form id="create-group" class="create-group-form" action="/creategroup" method="post" onsubmit="return confirm('그룹을 생성하시겠습니까?')">
            <div class="form-grid">
                <div class="form-group">
                    <label for="group-title">Title</label>
                    <input type="text" id="group-title" name="title" placeholder="e.g., Weekend trip to Yangyang" required>
                </div>
                <div class="form-group">
                    <label for="from-location">From</label>
                    <input type="text" id="from-location" name="fromLocation" placeholder="e.g., Seoul, Gangnam" required>
                </div>
                <div class="form-group">
                    <label for="to-location">To</label>
                    <input type="text" id="to-location" name="toLocation" placeholder="e.g., Yangyang, Jukdo Beach" required>
                </div>
                <div class="form-group">
                    <label for="meetingDate">Date</label>
                    <input type="date" id="meetingDate" name="meetingDate" required>
                </div>
                <div class="form-group">
                    <label for="max-members">Max Members</label>
                    <input type="number" id="max-members" name="maxMembers" min="1" placeholder="e.g., 4" required>
                </div>
                <div class="form-group">
                    <label for="group-description">Description</label>
                    <textarea id="group-description" name="description" placeholder="Share details about your trip, like your skill level, what you plan to do, etc." required></textarea>
                </div>
            </div>
            <div class="form-actions">
                <a href="/groups" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Create Group</button>
            </div>
        </form>
    </div>
<%--<script>--%>
<%--    document.getElementById('create-group').addEventListener('submit' , function (e){--%>
<%--        e.preventDefault()--%>
<%--        if (!confirm("정말로 생성하시겠습니까?")) {--%>
<%--            return;--%>
<%--        }--%>
<%--        alert("그룹이 생성되었습니다.")--%>
<%--        location.href = '/groups';--%>


<%--    })--%>
<%--</script>--%>
</body>
</html>
