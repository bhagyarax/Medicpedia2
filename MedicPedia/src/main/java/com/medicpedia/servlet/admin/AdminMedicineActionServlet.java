package com.medicpedia.servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medicpedia.dao.MedicineDAO;
import com.medicpedia.model.Medicine;

@WebServlet("/admin/MedicineActionServlet")
public class AdminMedicineActionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        MedicineDAO dao = new MedicineDAO();
        
        String idStr = request.getParameter("medicine_id");
        int id = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : 0;
        
        String name = request.getParameter("name");
        String imagePath = request.getParameter("image_path");
        String uses = request.getParameter("uses");
        String sideEffects = request.getParameter("side_effects");
        String precautions = request.getParameter("precautions");
        int minAge = request.getParameter("min_age") != null && !request.getParameter("min_age").isEmpty() ? Integer.parseInt(request.getParameter("min_age")) : 0;
        int maxAge = request.getParameter("max_age") != null && !request.getParameter("max_age").isEmpty() ? Integer.parseInt(request.getParameter("max_age")) : 0;
        boolean pregnancyWarning = request.getParameter("pregnancy_warning") != null;
        String riskLevel = request.getParameter("risk_level");
        
        Medicine med = new Medicine(id, name, imagePath, uses, sideEffects, precautions, minAge, maxAge, pregnancyWarning, riskLevel);
        
        if ("add".equals(action)) {
            dao.addMedicine(med);
        } else if ("edit".equals(action)) {
            dao.updateMedicine(med);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/MedicinesServlet");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                new MedicineDAO().deleteMedicine(Integer.parseInt(idStr));
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/MedicinesServlet");
    }
}
