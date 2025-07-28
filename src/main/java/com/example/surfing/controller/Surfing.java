package com.example.surfing.controller;


import com.example.surfing.dao.RegionDAO;
import com.example.surfing.dao.SurfingAPI;
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

        try {

            RegionDAO regionDAO = new RegionDAO();
            List<RegionDTO> regionDTOList = regionDAO.getRegion();

            List<String> names = regionDTOList.stream().map(RegionDTO::getName).collect(Collectors.toList());


            SurfingAPI api = new SurfingAPI();
            List<SurfingAPI.Item> surfingDatabefore = api.surfing();

            List<SurfingAPI.Item> filteredsurfingData = surfingDatabefore.stream()
                    .filter(item -> names.contains(item.surfPlcNm))
                    .collect(Collectors.toList());

            List<SurfingAPI.Item> sortedsurfingData = filteredsurfingData.stream()
                    .sorted(Comparator.comparing(SurfingAPI.Item::getSurfPlcNm)).collect(Collectors.toList());

            Map<String, List<SurfingAPI.Item>> grouped = sortedsurfingData.stream()
                    .collect(Collectors.groupingBy(SurfingAPI.Item::getSurfPlcNm));

            request.setAttribute("groupedData", grouped);

            request.getRequestDispatcher("surfing.jsp").forward(request, response);
        }catch (Exception e){
            e.printStackTrace();
            JSFunction.alertBack(response , "에러가 발생했습니다.");
        };

    }


}
