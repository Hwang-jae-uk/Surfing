package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dto.CommunityPostDTO;
import com.example.surfing.dto.PostImagePathDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

@WebServlet("/community/edit")
@MultipartConfig
public class CommunityEdit extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long communityPostId = Long.parseLong(request.getParameter("communityPostId"));
        CommunityDAO communityDAO = new CommunityDAO();
        CommunityPostDTO communityPostDTO = communityDAO.getPost(communityPostId);
        List<PostImagePathDTO> postImage = communityDAO.getPostImage(communityPostId);

        request.setAttribute("postImage", postImage);
        request.setAttribute("communityPostDTO", communityPostDTO);
        request.getRequestDispatcher("/communityEdit.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String communityPostId = request.getParameter("communityPostId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String deletedImages = request.getParameter("deletedImages");

        CommunityDAO communityDAO = new CommunityDAO();

        if (deletedImages != null && !deletedImages.isEmpty()) {
            String[] deletedImageNames = deletedImages.split(",");
            String uploadPath = getServletContext().getInitParameter("postImagePath");


            for (String imageName : deletedImageNames) {
                communityDAO.deletePostImage(imageName);
                File imageFile = new File(uploadPath , imageName);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }
        }

        Collection<Part> fileParts = request.getParts();
        if(fileParts.size() > 0) {
            for (Part filePart : fileParts) {
                if (!"file".equals(filePart.getName())) continue;
                String originalFileName = filePart.getSubmittedFileName();
                if (originalFileName != null && !originalFileName.isEmpty()) {

                    String uniqueFileName = UUID.randomUUID().toString();
                    String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                    uniqueFileName = uniqueFileName + extension;

                    try {
                        String uploadPath = getServletContext().getInitParameter("postImagePath");
                        File uploadDir = new File(uploadPath);
                        if(!uploadDir.exists()){
                            uploadDir.mkdirs();
                        }
                        File fileToSave = new File(uploadPath, uniqueFileName);
                        filePart.write(fileToSave.getAbsolutePath());

                        PostImagePathDTO postImagePathDTO = new PostImagePathDTO();
                        postImagePathDTO.setCommunitypostId(Long.parseLong(communityPostId));
                        postImagePathDTO.setPostImagePath(uniqueFileName);

                        communityDAO.inserPostImage(postImagePathDTO);

                    }catch (Exception e) {
                        e.printStackTrace();
                    }

                }
            }
        }


        CommunityPostDTO communityPostDTO = communityDAO.getPost(Long.parseLong(communityPostId));
        communityPostDTO.setTitle(title);
        communityPostDTO.setContent(content);
        communityDAO.updatePost(communityPostDTO);

        response.sendRedirect("/community/view?id=" + communityPostId);

    }
}
