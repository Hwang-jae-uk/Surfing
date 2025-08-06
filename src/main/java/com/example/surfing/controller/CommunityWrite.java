package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.CommunityPostDTO;
import com.example.surfing.dto.UserDTO;
import com.example.surfing.utill.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/community/write")
public class CommunityWrite extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/communityWrite.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 폼에서 데이터 받아오기
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");

        UserDAO userDAO = new UserDAO();
        UserDTO userDTO = userDAO.getUserByemail(email);
        System.out.println(userDTO);

        // DTO 생성
        CommunityPostDTO post = new CommunityPostDTO();
        post.setUserId(userDTO.getUserId());
        post.setTitle(title);
        post.setContent(content);
        post.setUserName(userDTO.getUserName());

        // DAO를 통해 데이터베이스에 저장
        CommunityDAO communityDAO = new CommunityDAO();
        int result = communityDAO.insertPost(post);

        if (result > 0) {
            // 글쓰기 성공
            resp.sendRedirect("../community");
        } else {
            // 글쓰기 실패
            JSFunction.alertBack(resp, "글쓰기에 실패했습니다.");
        }
    }
}
