<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MedicPedia – Your Trusted Online Pharmacy</title>
    <style>
        :root {
            --primary-teal: #10847e;
            --primary-hover: #0c6b66;
            --bg-gray: #f4f7fb;
            --text-dark: #4f585e;
            --text-light: #8e9ca7;
            --white: #ffffff;
            --border-color: #e2eaf1;
            --font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: var(--font-family);
        }

        body {
            background-color: var(--bg-gray);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* ── Navbar ─────────────────────────────────────────── */
        .navbar {
            background-color: var(--white);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .logo a {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-dark);
            letter-spacing: -0.5px;
        }

        .logo span {
            color: var(--primary-teal);
        }

        /* ── Search Bar ─────────────────────────────────────── */
        .search-container {
            flex: 1;
            max-width: 600px;
            position: relative;
        }

        .search-container form {
            display: flex;
            align-items: center;
            width: 100%;
            background: var(--white);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            transition: box-shadow 0.3s ease, border-color 0.3s ease;
        }

        .search-container form:focus-within {
            box-shadow: 0 4px 12px rgba(16, 132, 126, 0.15);
            border-color: var(--primary-teal);
        }

        .search-container input {
            flex: 1;
            border: none;
            padding: 14px 20px;
            font-size: 15px;
            outline: none;
            color: var(--text-dark);
        }

        .search-container input::placeholder {
            color: #b0bec5;
        }

        .search-container button {
            background: var(--primary-teal);
            color: var(--white);
            border: none;
            padding: 0 24px;
            height: 100%;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
            display: flex;
            align-items: center;
        }

        .search-container button::before {
            content: "\1F50D"; /* Unicode for magnifying glass */
            margin-right: 6px;
        }

        .search-container button:hover {
            background: var(--primary-hover);
        }

        /* ── Nav Links ──────────────────────────────────────── */
        .nav-links {
            display: flex;
            gap: 24px;
            align-items: center;
        }

        .nav-links a {
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: color 0.2s ease;
        }

        .nav-links a:hover {
            color: var(--primary-teal);
        }

        /* ── Main Content ────────────────────────────────────── */
        .main-content {
            flex: 1;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
            padding: 30px 20px;
        }

        /* ── Hero Banner ─────────────────────────────────────── */
        .hero-banner {
            background: linear-gradient(100deg, #e0f2f1 0%, #b2dfdb 100%);
            border-radius: 12px;
            padding: 40px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .hero-banner-content {
            position: relative;
            z-index: 2;
        }

        .hero-banner h1 {
            font-size: 32px;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        .hero-banner p {
            font-size: 18px;
            color: #546e7a;
            margin-bottom: 24px;
        }

        .btn-primary {
            display: inline-block;
            background-color: var(--primary-teal);
            color: var(--white);
            padding: 12px 28px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            transition: transform 0.2s ease, background 0.2s ease;
            box-shadow: 0 4px 10px rgba(16, 132, 126, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            background-color: var(--primary-hover);
            color: white;
        }

        /* Banner decorative shape */
        .hero-banner::after {
            content: "💊";
            font-size: 120px;
            position: absolute;
            right: 40px;
            top: 50%;
            transform: translateY(-50%) rotate(-15deg);
            opacity: 0.8;
            z-index: 1;
        }

        /* ── Section Titles ──────────────────────────────────── */
        .section-header {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--text-dark);
        }

        /* ── Service Categories ──────────────────────────────── */
        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 50px;
        }

        .category-card {
            background: var(--white);
            border-radius: 12px;
            padding: 24px;
            display: flex;
            align-items: flex-start;
            gap: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            border: 1px solid var(--border-color);
            transition: box-shadow 0.3s ease, border-color 0.3s ease, transform 0.3s ease;
            cursor: pointer;
        }

        .category-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            border-color: rgba(16, 132, 126, 0.3);
            transform: translateY(-3px);
        }

        .category-icon {
            width: 60px;
            height: 60px;
            min-width: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }

        .cat-1 .category-icon { background: #ffebee; color: #e53935; }
        .cat-2 .category-icon { background: #e8f5e9; color: #43a047; }
        .cat-3 .category-icon { background: #e3f2fd; color: #1e88e5; }

        .category-content h3 {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 6px;
        }

        .category-content p {
            font-size: 13px;
            color: var(--text-light);
            line-height: 1.4;
            margin-bottom: 12px;
        }

        .category-content span {
            font-size: 13px;
            font-weight: 600;
            color: var(--primary-teal);
        }

        /* ── Trust Banners ───────────────────────────────────── */
        .trust-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            background: var(--white);
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            border: 1px solid var(--border-color);
        }

        .trust-item h4 {
            font-size: 28px;
            font-weight: 800;
            color: var(--primary-teal);
            margin-bottom: 8px;
        }

        .trust-item p {
            font-size: 14px;
            color: var(--text-light);
            font-weight: 500;
        }

        /* ── Footer ──────────────────────────────────────────── */
        .footer {
            background-color: var(--white);
            border-top: 1px solid var(--border-color);
            padding: 40px 20px 20px;
            margin-top: 40px;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .footer-logo {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 15px;
        }

        .footer p {
            font-size: 13px;
            color: var(--text-light);
            margin-bottom: 10px;
        }

        /* ── Responsiveness ──────────────────────────────────── */
        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 15px;
                padding: 15px;
            }
            .search-container {
                width: 100%;
                max-width: none;
                order: 3;
            }
            .nav-links {
                width: 100%;
                justify-content: center;
                order: 2;
            }
            .hero-banner {
                padding: 30px 20px;
            }
            .hero-banner h1 { font-size: 26px; }
            .hero-banner::after { display: none; }
        }
    </style>
</head>
<body>

    <!-- Header & Navbar -->
    <header class="navbar">
        <div class="nav-container">
            <div class="logo">
                <a href="#">🏥 Medic<span>Pedia</span></a>
            </div>
            
            <div class="search-container">
                <form action="searchMedicine" method="get">
                    <input type="text" name="medicineName" placeholder="Search for Medicines, Health Products and more" required autocomplete="off">
                    <button type="submit">Search</button>
                </form>
            </div>
            
            <div class="nav-links">
                <a href="#">Offers</a>
                <a href="#">👤 Login</a>
                <a href="#">🛒 Cart</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        
        <!-- Promotional Banner -->
        <section class="hero-banner">
            <div class="hero-banner-content">
                <h1>Flat 25% OFF</h1>
                <p>on your first medicine order. Use code <strong>HEALTH25</strong></p>
                <a href="#" class="btn-primary">Order Medicines Now</a>
            </div>
        </section>

        <!-- Shop by Category -->
        <h2 class="section-header">Shop by Categories</h2>
        <div class="categories-grid">
            <!-- Card 1 -->
            <div class="category-card cat-1">
                <div class="category-icon">💊</div>
                <div class="category-content">
                    <h3>Order Medicines</h3>
                    <p>Get your prescribed medicines delivered directly to your doorstep with amazing discounts.</p>
                    <span>Order Now &rarr;</span>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="category-card cat-2">
                <div class="category-icon">🛡️</div>
                <div class="category-content">
                    <h3>Healthcare Products</h3>
                    <p>Shop for personal care, nutrition, wellness products, and medical devices.</p>
                    <span>Explore Products &rarr;</span>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="category-card cat-3">
                <div class="category-icon">🧪</div>
                <div class="category-content">
                    <h3>Lab Tests</h3>
                    <p>Book health checkups and lab tests from trusted labs with free home sample collection.</p>
                    <span>Book Test &rarr;</span>
                </div>
            </div>
        </div>

        <!-- Trust Badges -->
        <section class="trust-section">
            <div class="trust-item">
                <h4>25 Million+</h4>
                <p>Registered Users</p>
            </div>
            <div class="trust-item">
                <h4>1 Lakh+</h4>
                <p>Medicines Available</p>
            </div>
            <div class="trust-item">
                <h4>100% Genuine</h4>
                <p>Quality Guaranteed</p>
            </div>
             <div class="trust-item">
                <h4>19,000+</h4>
                <p>Pin Codes Served</p>
            </div>
        </section>

    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-logo">🏥 MedicPedia</div>
            <p>Your trusted online pharmacy partner. Delivering health and happiness right to your doorstep.</p>
            <p>&copy; 2026 MedicPedia. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>