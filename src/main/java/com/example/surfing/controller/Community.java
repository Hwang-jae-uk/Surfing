package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dto.CommunityPostDTO;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/community")
public class Community extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommunityDAO dao = new CommunityDAO();

        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            // AJAX request for more posts
            try {
                int page = 1; // Default to page 1
                if (!pageStr.isEmpty()) {
                    try {
                        page = Integer.parseInt(pageStr);
                    } catch (NumberFormatException e) {
                        // Keep page at 1 if parsing fails
                    }
                }

                int offset = (page - 1) * 20;
                List<CommunityPostDTO> posts = dao.getPosts(offset, 20);

                // Manually create a list of maps for safer JSON serialization
                List<Map<String, Object>> postsForJson = new ArrayList<>();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                for (CommunityPostDTO post : posts) {
                    Map<String, Object> postMap = new LinkedHashMap<>();
                    postMap.put("communityPostId", post.getCommunityPostId());
                    postMap.put("title", post.getTitle());
                    postMap.put("userName", post.getUserName());
                    if (post.getCreatedAt() != null) {
                        postMap.put("createdAt", sdf.format(post.getCreatedAt()));
                    } else {
                        postMap.put("createdAt", ""); // Or some default value
                    }
                    postsForJson.add(postMap);
                }

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String json = new Gson().toJson(postsForJson);
                response.getWriter().write(json);

            } catch (Exception e) {
                // Log the error and send an error response
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Error processing request\"}");
            }
        } else {
            // Initial page load
            List<CommunityPostDTO> posts = dao.getPosts(0, 20);
            request.setAttribute("posts", posts);
            request.getRequestDispatcher("community.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String searchTitle = request.getParameter("searchTitle");

        CommunityDAO dao = new CommunityDAO();
        List<CommunityPostDTO> posts = dao.searchPostsByTitle(searchTitle);


        request.setAttribute("posts", posts);
        request.setAttribute("searchTitle", searchTitle);
        request.getRequestDispatcher("community.jsp").forward(request, response);
    }
}

