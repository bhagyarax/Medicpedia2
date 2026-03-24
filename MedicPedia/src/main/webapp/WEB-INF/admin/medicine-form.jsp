<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicpedia.model.Medicine" %>
<% 
    Medicine med = (Medicine) request.getAttribute("medicine");
    boolean isEdit = (med != null);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Edit Medicine" : "Add New Medicine" %> - MedicAdmin</title>
</head>
<body>

    <jsp:include page="admin-header.jsp" />

    <div class="main-content">
        <h2 class="text-dark fw-bold mb-4"><%= isEdit ? "Edit Medicine: " + med.getName() : "Add New Medicine" %></h2>
        
        <div class="card shadow-sm border-0 rounded-3 p-4">
            <form action="<%=request.getContextPath()%>/admin/MedicineActionServlet" method="post">
                <input type="hidden" name="action" value="<%= isEdit ? "edit" : "add" %>">
                <% if(isEdit) { %>
                    <input type="hidden" name="medicine_id" value="<%= med.getId() %>">
                <% } %>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold font-sm text-secondary">Medicine Name *</label>
                        <input type="text" class="form-control bg-light" name="name" value="<%= isEdit ? med.getName() : "" %>" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold font-sm text-secondary">Image Path</label>
                        <input type="text" class="form-control bg-light" name="image_path" value="<%= isEdit && med.getImagePath() != null ? med.getImagePath() : "" %>" placeholder="images/medicines/med1.jpg">
                    </div>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold font-sm text-secondary">Primary Uses *</label>
                    <textarea class="form-control bg-light" name="uses" rows="2" required><%= isEdit ? med.getUses() : "" %></textarea>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold font-sm text-secondary">Side Effects</label>
                        <textarea class="form-control bg-light" name="side_effects" rows="2"><%= isEdit && med.getSideEffects() != null ? med.getSideEffects() : "" %></textarea>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold font-sm text-secondary">Precautions</label>
                        <textarea class="form-control bg-light" name="precautions" rows="2"><%= isEdit && med.getPrecautions() != null ? med.getPrecautions() : "" %></textarea>
                    </div>
                </div>

                <div class="row align-items-end mt-2">
                    <div class="col-md-3 mb-3">
                        <label class="form-label fw-bold font-sm text-secondary">Min Age</label>
                        <input type="number" class="form-control bg-light" name="min_age" value="<%= isEdit ? med.getMinAge() : "0" %>">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label fw-bold font-sm text-secondary">Max Age</label>
                        <input type="number" class="form-control bg-light" name="max_age" value="<%= isEdit ? med.getMaxAge() : "100" %>">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label fw-bold font-sm text-secondary">Risk Level</label>
                        <select class="form-select bg-light" name="risk_level">
                            <option value="Low" <%= isEdit && "Low".equalsIgnoreCase(med.getRiskLevel()) ? "selected" : "" %>>Low</option>
                            <option value="Medium" <%= isEdit && "Medium".equalsIgnoreCase(med.getRiskLevel()) ? "selected" : "" %>>Medium</option>
                            <option value="High" <%= isEdit && "High".equalsIgnoreCase(med.getRiskLevel()) ? "selected" : "" %>>High</option>
                        </select>
                    </div>
                    <div class="col-md-3 mb-3 pb-2 text-center">
                        <div class="form-check form-switch d-inline-block p-0">
                            <input class="form-check-input ms-0 me-2" type="checkbox" role="switch" name="pregnancy_warning" id="pregSwitch" <%= isEdit && med.isPregnancyWarning() ? "checked" : "" %>>
                            <label class="form-check-label fw-bold text-danger" for="pregSwitch">Pregnancy Warning</label>
                        </div>
                    </div>
                </div>
                
                <hr class="mt-4 mb-4 opacity-50">
                <div class="d-flex justify-content-end">
                    <a href="<%=request.getContextPath()%>/admin/MedicinesServlet" class="btn btn-light border me-2">Cancel</a>
                    <button type="submit" class="btn btn-primary shadow-sm" style="background:#10847e; border:none;"><%= isEdit ? "Save Changes" : "Create Medicine" %></button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
