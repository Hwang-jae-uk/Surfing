package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.CommunityCommentDTO;
import com.example.surfing.dto.CommunityPostDTO;
import com.example.surfing.dto.PostImagePathDTO;
import com.example.surfing.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/community/view")
public class CommunityView extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long postId = Long.parseLong((req.getParameter("id")));
        CommunityDAO dao = new CommunityDAO();
        CommunityPostDTO post = dao.getPost(postId);
        List<CommunityCommentDTO> comments = dao.getComments(postId);

        List<PostImagePathDTO> postImage = dao.getPostImage(postId);

        HttpSession session = req.getSession();
        String email = (String)session.getAttribute("email");
        UserDAO userDao = new UserDAO();
        UserDTO userDTO = userDao.getUserByemail(email);

        req.setAttribute("comments", comments);
        req.setAttribute("postImage", postImage);
        req.setAttribute("user", userDTO);
        req.setAttribute("post", post);
        req.getRequestDispatcher("/communityView.jsp").forward(req, resp);
    }

}
