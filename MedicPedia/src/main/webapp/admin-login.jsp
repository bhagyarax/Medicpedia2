<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MedicPedia Admin Login</title>
    <!-- Use Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7fb; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
        .login-card { width: 100%; max-width: 400px; padding: 40px; border: none; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.06); }
        .brand-text { color: #10847e; font-weight: 800; font-size: 26px; text-align: center; margin-bottom: 30px; }
        .btn-custom { background-color: #10847e; color: white; width: 100%; font-weight: 600; font-size: 16px; }
        .btn-custom:hover { background-color: #0c6b66; color: white; }
    </style>
</head>
<body>
    <div class="card login-card">
        <div class="brand-text">🏥 MedicAdmin</div>
        
        <% if ("invalid".equals(request.getParameter("error"))) { %>
            <div class="alert alert-danger" role="alert">Invalid username or password!</div>
        <% } %>
        <% if ("success".equals(request.getParameter("logout"))) { %>
            <div class="alert alert-success" role="alert">You have been securely logged out.</div>
        <% } %>

        <form action="<%=request.getContextPath()%>/AdminLoginServlet" method="post">
            <div class="mb-3">
                <label class="form-label text-muted small fw-bold">USERNAME</label>
                <input type="text" name="username" class="form-control form-control-lg bg-light" required autofocus>
            </div>
            <div class="mb-4">
                <label class="form-label text-muted small fw-bold">PASSWORD</label>
                <input type="password" name="password" class="form-control form-control-lg bg-light" required>
            </div>
            <button type="submit" class="btn btn-custom py-2">Sign In to Dashboard</button>
        </form>
    </div>
</body>
</html>
