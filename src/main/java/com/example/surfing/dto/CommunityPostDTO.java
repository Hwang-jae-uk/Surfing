package com.example.surfing.dto;

import java.util.Date;

public class CommunityPostDTO {
    private long communityPostId;
    private long userId;
    private String userName;
    private String title;
    private String content;
    private Date createdAt;

    public long getUserId() {return userId;}

    public void setUserId(long userId) {this.userId = userId;}

    public long getCommunityPostId() {
        return communityPostId;
    }

    public void setCommunityPostId(long communityPostId) {
        this.communityPostId = communityPostId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {this.userName = userName;}

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createAt) {this.createdAt = createAt;}
}
