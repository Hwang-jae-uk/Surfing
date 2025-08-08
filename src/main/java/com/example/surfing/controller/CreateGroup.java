package com.example.surfing.controller;

import com.example.surfing.dao.GroupDAO;
import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.GroupDTO;
import com.example.surfing.dto.GroupDTO;
import com.example.surfing.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;

@WebServlet("/creategroup")
public class CreateGroup extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/createGroup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String from = req.getParameter("fromLocation");
        String to = req.getParameter("toLocation");
        String date = req.getParameter("meetingDate");
        LocalDate meetingDate = LocalDate.parse(date);

        int maxMembers = Integer.parseInt(req.getParameter("maxMembers"));

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");
        UserDAO userDAO = new UserDAO();
        UserDTO userDTO = userDAO.getUserByemail(email);


        GroupDTO groupDTO = new GroupDTO();
        
        groupDTO.setUserName(userDTO.getUserName());
        groupDTO.setUserId(userDTO.getUserId());
        groupDTO.setTitle(title);
        groupDTO.setDescription(description);
        groupDTO.setFromLocation(from);
        groupDTO.setToLocation(to);
        groupDTO.setMeetingDate(meetingDate);
        groupDTO.setMaxMembers(maxMembers);


        GroupDAO groupDAO = new GroupDAO();
        groupDAO.insertGroup(groupDTO);


        resp.sendRedirect("/groups");
    }
}
