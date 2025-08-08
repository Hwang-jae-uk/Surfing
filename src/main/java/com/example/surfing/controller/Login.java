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

@WebServlet("/login")
public class Login extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        request.setAttribute("email",email);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        String email = request.getParameter("email");


        UserDAO userDAO = new UserDAO();
        if(userDAO.getUserByemail(email).getEmail()==null){
            JSFunction.alertBack(response,"없는 email입니다.");
            return;
        }

        int result = userDAO.loginUser(email, password);
        if(result == 1){
            HttpSession session = request.getSession();
            session.setAttribute("email",email);
            response.sendRedirect("/main");
        }else{
            JSFunction.alertBack(response , "패스워드가 틀렸습니다.");
        }

    }
}