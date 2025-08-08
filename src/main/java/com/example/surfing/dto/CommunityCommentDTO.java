package com.example.surfing.dto;


import java.util.Date;

public class CommunityCommentDTO {
    private long communityCommentId;
    private long communityPostId;
    private long userId;
    private String userName;
    private String content;
    private Date createdAt;

    public long getCommunityCommentId() {
        return communityCommentId;
    }

    public void setCommunityCommentId(long communityCommentId) {
        this.communityCommentId = communityCommentId;
    }

    public long getCommunityPostId() {
        return communityPostId;
    }

    public void setCommunityPostId(long communityPodstId) {
        this.communityPostId = communityPodstId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
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

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
