package com.example.surfing.controller;

import com.example.surfing.dao.CommunityDAO;
import com.example.surfing.dao.GroupDAO;
import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.CommunityPostDTO;
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

@WebServlet("/main")
public class Main extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GroupDAO groupDAO = new GroupDAO();
        List<GroupDTO> groups = groupDAO.getGroups();

        UserDAO userDAO = new UserDAO();

        for(GroupDTO group : groups) {
            UserDTO userDTO = userDAO.getUserById(group.getUserId());
            group.setProfileImagePath(userDTO.getUniqueFileName());
        }



        CommunityDAO communityDAO = new CommunityDAO();
        List<CommunityPostDTO> posts =  communityDAO.get5Posts();

        request.setAttribute("groups", groups);
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("Main.jsp").forward(request, response);

    }

}
