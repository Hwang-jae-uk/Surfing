package com.example.surfing.controller;

import com.example.surfing.dao.RegionDAO;
import com.example.surfing.dao.SurfingAPI;
import com.example.surfing.dto.CustomGroup;
import com.example.surfing.dto.RegionDTO;
import com.example.surfing.utill.JSFunction;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/surfing")
public class Surfing extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            // JSP로 포워딩
            request.getRequestDispatcher("surfing.jsp").forward(request, response);


    }
}
