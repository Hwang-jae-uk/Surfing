package com.example.surfing.controller;

import com.example.surfing.dao.GroupDAO;
import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.GroupDTO;
import com.example.surfing.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/groups")
public class Groups extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GroupDAO groupDAO = new GroupDAO();
        List<GroupDTO> groups = groupDAO.getGroups();
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute("email");
        UserDAO userDAO = new UserDAO();
        UserDTO userDTO = userDAO.getUserByemail(email);

        request.setAttribute("user", userDTO);
        request.setAttribute("groups", groups);
        request.getRequestDispatcher("/groups.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long groupId = Long.parseLong(request.getParameter("groupId"));
        GroupDAO groupDAO = new GroupDAO();

        groupDAO.deleteGroup(groupId);

        response.sendRedirect("/groups");
    }
}
