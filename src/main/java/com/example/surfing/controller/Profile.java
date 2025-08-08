package com.example.surfing.controller;

import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.UserDTO;
import com.example.surfing.utill.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/profile")
public class Profile extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUserByemail(email);

        request.setAttribute("user", user);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentpassword");
        String newPassword = request.getParameter("newpassword");
        String confirmNewPassword = request.getParameter("confirmnewpassword");
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUserByemail(email);
        String password = user.getPassword();
        System.out.println(user.getPhone());

        if(!BCrypt.checkpw(currentPassword,password)){
            JSFunction.alertBack(response,"현재 비밀번호가 일치하지 않습니다.");
            return;
        }
        if(!newPassword.equals(confirmNewPassword)){
            JSFunction.alertBack(response,"새 비밀번호가 일치하지 않습니다.");
            return;
        }
        if(!(newPassword ==null || newPassword.isEmpty())){
            user.setPassword(newPassword);
        }
        if(!user.getUserName().equals(username)){
            user.setUserName(username);
        }
        if(!user.getPhone().equals(phone)){
            user.setPhone(phone);
        }


        userDAO.updateUser(user);
        JSFunction.alertLocation(response , "수정 완료 되었습니다." , "/main");
    }

}
