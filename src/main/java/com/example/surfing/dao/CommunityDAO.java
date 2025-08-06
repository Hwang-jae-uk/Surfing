package com.example.surfing.dao;

import com.example.surfing.dto.CommunityPostDTO;
import com.example.surfing.utill.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommunityDAO {

    public int insertPost(CommunityPostDTO post) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO communitypost (title, content, username,user_id) VALUES (?, ?, ?, ?)";
        int result = 0;

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getUserName());
            pstmt.setLong(4, post.getUserId());
            result = pstmt.executeUpdate();
            result = 1;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt);
        }
        return result;
    }

    public List<CommunityPostDTO> getPosts() {
        String sql = "SELECT * FROM communitypost ORDER BY created_at DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<CommunityPostDTO> posts = new ArrayList<>();
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CommunityPostDTO post = new CommunityPostDTO();

                post.setCommunityPostId(rs.getLong("communitypost_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setUserName(rs.getString("username"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return posts;
    }
    public CommunityPostDTO getPost(long postId) {
        String sql = "SELECT * FROM communitypost WHERE communitypost_id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CommunityPostDTO post = new CommunityPostDTO();

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, postId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                post.setCommunityPostId(rs.getLong("communitypost_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setUserName(rs.getString("username"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
            }
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            DBManager.close(conn, pstmt, rs);
        }
        return post;
    }
}
