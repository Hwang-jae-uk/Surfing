package com.example.surfing.utill;

import jakarta.servlet.http.HttpServletResponse;

import java.io.PrintWriter;

public class JSFunction {
    // 메세지 알림창을 띄운 후 명시한 URL로 이동
    public static void alertLocation(HttpServletResponse response , String msg , String url) {

        try{
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            String script = " "
                    + "<script>"
                    + "     alert('"+msg+"');"
                    + "      location.href='"+url+"';"
                    + "</script>";
            out.println(script);

        }
        catch(Exception ignored){}
    }

    public static void alertBack(HttpServletResponse response , String msg){
        try {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            String script = " "
                    + "<script>"
                    + "     alert('"+msg+"');"
                    + "     history.back();"
                    + "</script>";
            out.println(script);
        }
        catch (Exception ignored) {}
    }
}