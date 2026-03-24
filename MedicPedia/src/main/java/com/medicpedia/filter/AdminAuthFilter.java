package com.medicpedia.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    public void init(FilterConfig fConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        String path = req.getRequestURI();
        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("admin_user") != null;
        
        // Let login requests pass through
        if (path.endsWith("/admin/login") || path.endsWith("/AdminLoginServlet")) {
            chain.doFilter(request, response);
            return;
        }

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/admin-login.jsp");
        }
    }

    public void destroy() {}
}
