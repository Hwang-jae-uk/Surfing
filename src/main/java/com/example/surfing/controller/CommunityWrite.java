package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.CommunityPostDTO;
import com.example.surfing.dto.PostImagePathDTO;
import com.example.surfing.dto.UserDTO;
import com.example.surfing.utill.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

@WebServlet("/community/write")
@MultipartConfig
public class CommunityWrite extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/communityWrite.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 폼에서 데이터 받아오기
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        UserDAO userDAO = new UserDAO();
        UserDTO userDTO = userDAO.getUserByemail(email);

        // DTO 생성
        CommunityPostDTO post = new CommunityPostDTO();
        post.setUserId(userDTO.getUserId());
        post.setTitle(title);
        post.setContent(content);
        post.setUserName(userDTO.getUserName());

        // DAO를 통해 데이터베이스에 저장
        CommunityDAO communityDAO = new CommunityDAO();
        CommunityPostDTO communityPostDTO = communityDAO.insertPost(post);

        // 이미지 업로드
        Collection<Part> fileParts = request.getParts();
//        List<Part> fileParts = new ArrayList<>();
//        fileParts = (List<Part>) request.getPart("file");
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
                        postImagePathDTO.setCommunitypostId(communityPostDTO.getCommunityPostId());
                        postImagePathDTO.setPostImagePath(uniqueFileName);

                        communityDAO.inserPostImage(postImagePathDTO);

                    }catch (Exception e) {
                        e.printStackTrace();
                    }

                }
            }
        }



        if (communityPostDTO !=null) {
            // 글쓰기 성공
            response.sendRedirect("../community");
        } else {
            // 글쓰기 실패
            JSFunction.alertBack(response, "글쓰기에 실패했습니다.");
        }
    }
}
