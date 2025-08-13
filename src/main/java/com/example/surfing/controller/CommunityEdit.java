package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dto.CommunityPostDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/community/edit")
public class CommunityEdit extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long communityPostId = Long.parseLong(request.getParameter("communityPostId"));
        CommunityDAO communityDAO = new CommunityDAO();
        CommunityPostDTO communityPostDTO = communityDAO.getPost(communityPostId);

        request.setAttribute("communityPostDTO", communityPostDTO);
        request.getRequestDispatcher("/communityEdit.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String communityPostId = request.getParameter("communityPostId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        CommunityDAO communityDAO = new CommunityDAO();
        CommunityPostDTO communityPostDTO = communityDAO.getPost(Long.parseLong(communityPostId));
        communityPostDTO.setTitle(title);
        communityPostDTO.setContent(content);
        communityDAO.updatePost(communityPostDTO);

        response.sendRedirect("/community/view?id=" + communityPostId);

    }
}
