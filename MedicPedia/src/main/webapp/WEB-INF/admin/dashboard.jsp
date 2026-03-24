<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - MedicPedia</title>
</head>
<body>

    <jsp:include page="admin-header.jsp" />

    <div class="main-content">
        <h2 class="mb-4 text-dark fw-bold">Dashboard Overview</h2>
        
        <div class="row">
            <!-- Medicines Card -->
            <div class="col-md-4">
                <div class="card shadow-sm border-0 rounded-3 mb-4">
                    <div class="card-body p-4 d-flex align-items-center">
                        <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 60px; height: 60px; font-size: 24px;">
                            <i class="bi bi-capsule"></i>
                        </div>
                        <div>
                            <h6 class="text-muted mb-1 text-uppercase fw-bold">Total Medicines</h6>
                            <h3 class="mb-0 fw-bold"><%= request.getAttribute("totalMedicines") != null ? request.getAttribute("totalMedicines") : "0" %></h3>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Admins Card -->
            <div class="col-md-4">
                <div class="card shadow-sm border-0 rounded-3 mb-4">
                    <div class="card-body p-4 d-flex align-items-center">
                        <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 60px; height: 60px; font-size: 24px;">
                            <i class="bi bi-shield-lock"></i>
                        </div>
                        <div>
                            <h6 class="text-muted mb-1 text-uppercase fw-bold">Active Admins</h6>
                            <h3 class="mb-0 fw-bold"><%= request.getAttribute("totalAdmins") != null ? request.getAttribute("totalAdmins") : "0" %></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
