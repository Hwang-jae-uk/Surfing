package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/postcommentdelete")
public class PostCommentDelete extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long communityCommentId = Long.parseLong(request.getParameter("communityCommentId"));
        CommunityDAO communityDAO = new CommunityDAO();
        communityDAO.deletePostComment(communityCommentId);
        response.sendRedirect("/community/view?id=" + communityCommentId);
    }
}
