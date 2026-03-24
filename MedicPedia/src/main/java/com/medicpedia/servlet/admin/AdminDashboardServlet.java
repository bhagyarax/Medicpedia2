package com.medicpedia.servlet.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medicpedia.util.DBConnection;

@WebServlet("/admin/DashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalMedicines = 0;
        int totalAdmins = 0;

        try (Connection con = DBConnection.getConnection()) {
            try(PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM medicines");
                ResultSet rs = ps.executeQuery()) {
                if(rs.next()) totalMedicines = rs.getInt(1);
            }
            
            try(PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM admin_users");
                ResultSet rs = ps.executeQuery()) {
                if(rs.next()) totalAdmins = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalMedicines", totalMedicines);
        request.setAttribute("totalAdmins", totalAdmins);
        request.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(request, response);
    }
}
