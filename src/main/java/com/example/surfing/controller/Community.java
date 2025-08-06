package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.CommunityPostDTO;
import com.example.surfing.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/community")
public class Community extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommunityDAO dao = new CommunityDAO();
        List<CommunityPostDTO> posts = dao.getPosts();

        request.setAttribute("posts", posts);
        request.getRequestDispatcher("community.jsp").forward(request, response);
    }
}

