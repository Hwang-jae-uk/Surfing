package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/postdelete")
public class PostDelete extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long communityPostId = Long.parseLong(request.getParameter("communityPostId"));
        CommunityDAO communityDAO = new CommunityDAO();
        communityDAO.deletePost(communityPostId);
        response.sendRedirect("community.jsp");

    }
}
