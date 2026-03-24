<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.medicpedia.model.Medicine" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Medicines - MedicPedia Admin</title>
</head>
<body>

    <jsp:include page="admin-header.jsp" />

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-dark fw-bold mb-0">Medicines Inventory</h2>
            <a href="<%=request.getContextPath()%>/admin/MedicineFormServlet" class="btn btn-primary shadow-sm" style="background:#10847e; border:none;"><i class="bi bi-plus-lg"></i> Add Medicine</a>
        </div>
        
        <div class="card shadow-sm border-0 rounded-3">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-borderless align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Name</th>
                                <th>Primary Uses</th>
                                <th>Risk Level</th>
                                <th class="text-end pe-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Medicine> meds = (List<Medicine>) request.getAttribute("medicineList");
                                if(meds != null && !meds.isEmpty()) {
                                    for(Medicine m : meds) {
                                        String riskColor = "success";
                                        if("High".equalsIgnoreCase(m.getRiskLevel())) riskColor = "danger";
                                        else if("Medium".equalsIgnoreCase(m.getRiskLevel())) riskColor = "warning";
                            %>
                            <tr>
                                <td class="ps-4 text-muted">#<%= m.getId() %></td>
                                <td class="fw-bold"><%= m.getName() %></td>
                                <td class="text-truncate" style="max-width: 250px; color:#6c757d;"><%= m.getUses() %></td>
                                <td>
                                    <span class="badge bg-<%=riskColor%>-subtle text-<%=riskColor%> border border-<%=riskColor%>-subtle rounded-pill px-3"><%= m.getRiskLevel() != null ? m.getRiskLevel() : "N/A" %></span>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="<%=request.getContextPath()%>/admin/MedicineFormServlet?id=<%= m.getId() %>" class="btn btn-sm btn-light text-primary me-2"><i class="bi bi-pencil-square"></i></a>
                                    <a href="<%=request.getContextPath()%>/admin/MedicineActionServlet?action=delete&id=<%= m.getId() %>" class="btn btn-sm btn-light text-danger" onclick="return confirm('Are you sure you want to permanently delete exactly this medicine?');"><i class="bi bi-trash"></i></a>
                                </td>
                            </tr>
                            <% 
                                    }
                                } else { 
                            %>
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">No medicines found in the database.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
