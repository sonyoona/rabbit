package com.filter;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthFilter implements Filter {
 public void init(FilterConfig filterConfig) throws ServletException {}

 public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
         throws IOException, ServletException {
     HttpServletRequest httpRequest = (HttpServletRequest) request;
     HttpSession session = httpRequest.getSession(false);

     if (session != null && session.getAttribute("userid") == null) {
         String username = httpRequest.getRemoteUser();
         if (username != null) {
             session.setAttribute("userid", username);
             session.setAttribute("isLoggedIn", true);
         }
     }

     chain.doFilter(request, response);
 }

 public void destroy() {}
}
