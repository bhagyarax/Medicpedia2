<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Admin Header & Sidebar using Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
    body { background-color: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    .sidebar {
        height: 100vh;
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        background-color: #343a40;
        padding-top: 20px;
        color: white;
    }
    .sidebar .brand { font-size: 22px; font-weight: bold; text-align: center; margin-bottom: 30px; letter-spacing: 1px;}
    .sidebar .brand span { color: #20c997; }
    .sidebar a {
        padding: 15px 25px;
        text-decoration: none;
        font-size: 16px;
        color: #adb5bd;
        display: block;
        transition: 0.3s;
    }
    .sidebar a:hover { color: white; background: #495057; border-left: 4px solid #20c997;}
    .sidebar a.active { color: white; background: #495057; border-left: 4px solid #20c997; font-weight: bold;}
    .sidebar i { margin-right: 10px; }
    
    .main-content {
        margin-left: 250px;
        padding: 30px 40px;
    }
    .topbar {
        background: white;
        padding: 15px 40px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        display: flex;
        justify-content: flex-end;
        align-items: center;
        margin-left: 250px;
    }
</style>

<!-- Sidebar -->
<div class="sidebar">
    <div class="brand">🏥 Medic<span>Admin</span></div>
    <a href="<%=request.getContextPath()%>/admin/DashboardServlet"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="<%=request.getContextPath()%>/admin/MedicinesServlet"><i class="bi bi-capsule"></i> Medicines Management</a>
    <a href="<%=request.getContextPath()%>/admin/LogoutServlet" class="mt-5 text-danger"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<!-- Topbar -->
<div class="topbar">
    <div class="dropdown">
        <span class="fw-bold">Welcome, <%= session.getAttribute("admin_user") %></span>
    </div>
</div>
