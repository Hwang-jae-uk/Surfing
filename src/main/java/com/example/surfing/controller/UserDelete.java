package com.example.surfing.controller;

import com.example.surfing.dao.UserDAO;
import com.example.surfing.utill.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user/delete")
public class UserDelete extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        UserDAO userDAO = new UserDAO();
        userDAO.deleteUserByEmail(email);

        JSFunction.alertLocation(response,"아이디가 삭제되었습니다.","/userDelete.jsp");
    }
}
