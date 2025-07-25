package com.example.surfing.controller;


import com.example.surfing.dao.RegionDAO;
import com.example.surfing.dto.RegionDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchRegion")
public class SearchRegion {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String region = request.getParameter("region");
        RegionDAO regionDAO = new RegionDAO();
        List<RegionDTO> regionDTOList = regionDAO.getRegionByType(region);
        request.setAttribute("regionList", regionDTOList);
    }
}
