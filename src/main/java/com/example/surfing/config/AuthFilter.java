package com.example.surfing.config;

import com.example.surfing.utill.JSFunction;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter({"/profile" , "/logout.jsp","/community/write"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);  // 세션이 없으면 null 반환

        boolean isLoggedIn = (session != null && session.getAttribute("email") != null);

        if(isLoggedIn) {
            filterChain.doFilter(req, response);
        }else {
            response.setContentType("text/html;charset=utf-8");
            JSFunction.alertLocation((HttpServletResponse) response,"로그인 후 이용 가능합니다." , "/login");
        }
    }
}
