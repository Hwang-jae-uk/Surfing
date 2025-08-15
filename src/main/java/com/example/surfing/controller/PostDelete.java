package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dto.CommunityCommentDTO;
import com.example.surfing.dto.PostImagePathDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/postdelete")
public class PostDelete extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long communityPostId = Long.parseLong(request.getParameter("communityPostId"));


        CommunityDAO communityDAO = new CommunityDAO();
        List<PostImagePathDTO> postImages = communityDAO.getPostImage(communityPostId);

        if(postImages.size() > 0){
            File upload = new File(request.getServletContext().getInitParameter("postImagePath"));
            for(PostImagePathDTO comment : postImages){
                File alreadyFile = new File(upload , comment.getPostImagePath());
                if(alreadyFile.exists()){
                    alreadyFile.delete();
                }
            }
        }

        communityDAO.deletePost(communityPostId);
        response.sendRedirect("community.jsp");

    }
}
