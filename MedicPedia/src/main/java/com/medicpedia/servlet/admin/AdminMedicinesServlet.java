package com.medicpedia.servlet.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medicpedia.model.Medicine;
import com.medicpedia.util.DBConnection;

@WebServlet("/admin/MedicinesServlet")
public class AdminMedicinesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Medicine> medicineList = new ArrayList<>();
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM medicines ORDER BY medicine_id DESC");
             ResultSet rs = ps.executeQuery()) {
             
            while(rs.next()) {
                // Initialize model object mapping core fields needed for table
                Medicine med = new Medicine(
                    rs.getInt("medicine_id"),
                    rs.getString("name"),
                    rs.getString("image_path"),
                    rs.getString("uses"),
                    "", "", 0, 0, false, 
                    rs.getString("risk_level")
                );
                medicineList.add(med);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("medicineList", medicineList);
        request.getRequestDispatcher("/WEB-INF/admin/medicines.jsp").forward(request, response);
    }
}
