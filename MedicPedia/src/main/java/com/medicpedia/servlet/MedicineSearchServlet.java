package com.medicpedia.servlet;

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

@WebServlet("/searchMedicine")
public class MedicineSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("medicineName");
        List<Medicine> medicineList = new ArrayList<>();
        String errorMessage = null;
        
        // Pagination variables
        int page = 1;
        int pageSize = 6;
        String riskLevel = request.getParameter("riskLevel");
        if (riskLevel != null) {
            riskLevel = riskLevel.trim();
        }
        
        System.out.println("DEBUG: Search Query = [" + query + "], Risk Level = [" + riskLevel + "]");

        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        if (page < 1) page = 1;

        if (query == null || query.trim().isEmpty()) {
            errorMessage = "Please enter a medicine name.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("results.jsp").forward(request, response);
            return;
        }

        int totalRecords = 0;
        int totalPages = 0;

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                errorMessage = "Database connection failed.";
            } else {
                String searchPattern = query.trim() + "%";
                boolean hasRiskFilter = riskLevel != null && !riskLevel.equalsIgnoreCase("All") && !riskLevel.isEmpty();
                
                // 1. Get Total Count
                StringBuilder countSql = new StringBuilder("SELECT COUNT(*) FROM medicines WHERE name LIKE ?");
                if (hasRiskFilter) {
                    countSql.append(" AND risk_level = ?");
                }
                
                try (PreparedStatement pstCount = con.prepareStatement(countSql.toString())) {
                    int pIndex = 1;
                    pstCount.setString(pIndex++, searchPattern);
                    if (hasRiskFilter) {
                        pstCount.setString(pIndex++, riskLevel);
                    }
                    
                    try (ResultSet rsCount = pstCount.executeQuery()) {
                        if (rsCount.next()) {
                            totalRecords = rsCount.getInt(1);
                        }
                    }
                }
                
                // Calculate total pages
                totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                
                // Ensure current page doesn't exceed total pages
                if (page > totalPages && totalPages > 0) {
                    page = totalPages;
                }
                
                int offset = (page - 1) * pageSize;

                // 2. Get Paginated Data
                StringBuilder sql = new StringBuilder("SELECT * FROM medicines WHERE name LIKE ?");
                if (hasRiskFilter) {
                    sql.append(" AND risk_level = ?");
                }
                sql.append(" ORDER BY name ASC LIMIT ? OFFSET ?");

                try (PreparedStatement pst = con.prepareStatement(sql.toString())) {
                    int paramIndex = 1;
                    pst.setString(paramIndex++, searchPattern);
                    if (hasRiskFilter) {
                        pst.setString(paramIndex++, riskLevel);
                    }
                    pst.setInt(paramIndex++, pageSize);
                    pst.setInt(paramIndex++, offset);

                    try (ResultSet rs = pst.executeQuery()) {
                        while (rs.next()) {
                            Medicine med = new Medicine(
                                rs.getInt("medicine_id"),
                                rs.getString("name"),
                                rs.getString("image_path"),
                                rs.getString("uses"),
                                rs.getString("side_effects"),
                                rs.getString("precautions"),
                                rs.getInt("min_age"),
                                rs.getInt("max_age"),
                                rs.getBoolean("pregnancy_warning"),
                                rs.getString("risk_level")
                            );
                            medicineList.add(med);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "An error occurred while searching: " + e.getMessage();
        }

        request.setAttribute("searchQuery", query);
        request.setAttribute("medicineList", medicineList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("riskLevel", riskLevel);
        
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }

        request.getRequestDispatcher("results.jsp").forward(request, response);
    }
}
