package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dto.CommunityCommentDTO;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/community/comment")
public class CommunityComment extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String json = sb.toString();
        CommunityCommentDTO commentDTO = new Gson().fromJson(json, CommunityCommentDTO.class);

        System.out.println("getCommunityPodstId: " + commentDTO.getCommunityPostId());
        System.out.println("userName: " + commentDTO.getUserName());
        System.out.println("userId: " + commentDTO.getUserId());
        System.out.println("content: " + commentDTO.getContent());

        CommunityDAO communityDAO = new CommunityDAO();
        communityDAO.insertComment(commentDTO);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"status\":\"ok\"}");
    }
}
