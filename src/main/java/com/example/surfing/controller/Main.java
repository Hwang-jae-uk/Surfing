package com.example.surfing.controller;

import com.example.surfing.dao.GroupDAO;
import com.example.surfing.dto.GroupDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/main")
public class Main extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GroupDAO groupDAO = new GroupDAO();
        List<GroupDTO> groups = groupDAO.getGroups();

        request.setAttribute("groups", groups);
        request.getRequestDispatcher("Main.jsp").forward(request, response);

    }

}
