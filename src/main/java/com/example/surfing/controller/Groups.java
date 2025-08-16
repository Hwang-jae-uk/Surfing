package com.example.surfing.controller;

import com.example.surfing.dao.GroupDAO;
import com.example.surfing.dao.UserDAO;
import com.example.surfing.dto.GroupDTO;
import com.example.surfing.dto.UserDTO;
import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.lang.reflect.Type;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/groups")
public class Groups extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GroupDAO groupDAO = new GroupDAO();
        UserDAO userDAO = new UserDAO();

        String pageStr = request.getParameter("page");

        if (pageStr != null) {
            // AJAX request for more groups
            int page = Integer.parseInt(pageStr);
            int offset = (page - 1) * 18;
            List<GroupDTO> groups = groupDAO.getGroups(offset, 18);

            for (GroupDTO groupDTO : groups) {
                UserDTO user = userDAO.getUserById(groupDTO.getUserId());
                if (user != null) {
                    String profileImagePath = getServletContext().getInitParameter("profileImage") + "/" + user.getUniqueFileName();
                    groupDTO.setProfileImagePath(profileImagePath);
                }
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Create Gson with LocalDate adapter
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDate.class, new JsonSerializer<LocalDate>() {
                        @Override
                        public JsonElement serialize(LocalDate date, Type typeOfSrc, JsonSerializationContext context) {
                            return new JsonPrimitive(date.format(DateTimeFormatter.ISO_LOCAL_DATE)); // "yyyy-MM-dd"
                        }
                    })
                    .setDateFormat("yyyy-MM-dd") // For java.util.Date fields
                    .create();

            String json = gson.toJson(groups);
            response.getWriter().write(json);
        } else {
            // Initial page load
            List<GroupDTO> groups = groupDAO.getGroups(0, 18);

            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");
            UserDTO userDTO = userDAO.getUserByemail(email);

            for (GroupDTO groupDTO : groups) {
                UserDTO user = userDAO.getUserById(groupDTO.getUserId());
                if (user != null) {
                    String profileImagePath = getServletContext().getInitParameter("profileImage") + "/" + user.getUniqueFileName();
                    groupDTO.setProfileImagePath(profileImagePath);
                }
            }

            request.setAttribute("user", userDTO);
            request.setAttribute("groups", groups);
            request.getRequestDispatcher("/groups.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long groupId = Long.parseLong(request.getParameter("groupId"));
        GroupDAO groupDAO = new GroupDAO();
        groupDAO.deleteGroup(groupId);
        response.sendRedirect("/groups");


    }
}