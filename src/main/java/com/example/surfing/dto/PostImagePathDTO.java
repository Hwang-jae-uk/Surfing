package com.example.surfing.dto;

public class PostImagePathDTO {
    private long postImageId;
    private long communitypostId;
    private String postImagePath;

    public long getPostImageId() {
        return postImageId;
    }

    public void setPostImageId(long post_image_id) {
        this.postImageId = post_image_id;
    }

    public long getCommunitypostId() {
        return communitypostId;
    }

    public void setCommunitypostId(long communitypostId) {
        this.communitypostId = communitypostId;
    }

    public String getPostImagePath() {
        return postImagePath;
    }

    public void setPostImagePath(String postIamgePath) {
        this.postImagePath = postIamgePath;
    }
}
