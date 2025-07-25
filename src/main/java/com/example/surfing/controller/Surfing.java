package com.example.surfing.controller;


import com.example.surfing.dao.SurfingAPI;
import com.example.surfing.utill.JSFunction;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/surfing")
public class Surfing extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {




        try {
            SurfingAPI api = new SurfingAPI();
            List<SurfingAPI.Item> surfingData = api.surfing();

            request.setAttribute("surfingDataList", surfingData);
            request.getRequestDispatcher("surfing.jsp").forward(request, response);
        }catch (Exception e){
            e.printStackTrace();
            JSFunction.alertBack(response , "에러가 발생했습니다.");
        }
    }


}
