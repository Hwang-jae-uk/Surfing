package com.example.surfing.controller;

import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.UserDTO;
import com.example.surfing.utill.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/signup")
public class SignUp extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String phone = request.getParameter("phone");

        if(!password.equals(confirmPassword)){
            request.setAttribute("error", "두 비밀번호가 일치하지 않습니다.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }

        UserDTO userDTO = new UserDTO();
        userDTO.setUserName(username);
        userDTO.setEmail(email);
        userDTO.setPassword(password);
        userDTO.setPhone(phone);

        try {
            UserDAO userDAO = new UserDAO();
            userDAO.signupUser(userDTO);
            JSFunction.alertLocation(response,"회원가입 성공하셨습니다.","/login?"+email);
        }catch(Exception e){
            e.printStackTrace();
            JSFunction.alertBack(response,"회원가입 실패하셨습니다.");
        }

    }
}
