package com.medicpedia.servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medicpedia.dao.AdminDAO;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        AdminDAO dao = new AdminDAO();
        if (dao.validateAdmin(user, pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin_user", user);
            response.sendRedirect(request.getContextPath() + "/admin/DashboardServlet");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp?error=invalid");
        }
    }
}
