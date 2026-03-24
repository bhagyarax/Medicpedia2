<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.medicpedia.model.Medicine" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>MedicPedia - Search Results</title>

                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
                        min-height: 100vh;
                        color: #333;
                    }

                    /* ── Header ─────────────────────────────────────────── */
                    .header {
                        background: rgba(255, 255, 255, 0.95);
                        padding: 18px 30px;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
                        position: sticky;
                        top: 0;
                        z-index: 100;
                    }

                    .header h1 {
                        font-size: 22px;
                        color: #2c3e50;
                    }

                    .header h1 span {
                        color: #1abc9c;
                    }

                    .back-btn {
                        text-decoration: none;
                        background: linear-gradient(135deg, #1abc9c, #16a085);
                        color: white;
                        padding: 10px 22px;
                        border-radius: 8px;
                        font-size: 14px;
                        font-weight: 600;
                        transition: all 0.3s ease;
                        box-shadow: 0 3px 10px rgba(26, 188, 156, 0.3);
                    }

                    .back-btn:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 6px 20px rgba(26, 188, 156, 0.4);
                    }

                    /* ── Search Info ─────────────────────────────────────── */
                    .search-info {
                        text-align: center;
                        padding: 25px 20px 10px;
                        color: rgba(255, 255, 255, 0.9);
                    }

                    .search-info h2 {
                        font-size: 20px;
                        font-weight: 400;
                    }

                    .search-info .query {
                        color: #1abc9c;
                        font-weight: 700;
                    }

                    .search-info .count {
                        font-size: 14px;
                        margin-top: 5px;
                        color: rgba(255, 255, 255, 0.6);
                    }

                    /* ── Card Grid ──────────────────────────────────────── */
                    .card-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
                        gap: 24px;
                        padding: 25px 30px 40px;
                        max-width: 1400px;
                        margin: 0 auto;
                    }

                    /* ── Medicine Card ──────────────────────────────────── */
                    .med-card {
                        background: rgba(255, 255, 255, 0.97);
                        border-radius: 16px;
                        overflow: hidden;
                        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
                        transition: transform 0.3s ease, box-shadow 0.3s ease;
                    }

                    .med-card:hover {
                        transform: translateY(-6px);
                        box-shadow: 0 16px 45px rgba(0, 0, 0, 0.25);
                    }

                    .card-header {
                        padding: 20px 22px 14px;
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                    }

                    .card-header h3 {
                        font-size: 20px;
                        color: #2c3e50;
                        flex: 1;
                    }

                    .risk-badge {
                        padding: 4px 14px;
                        border-radius: 20px;
                        font-size: 12px;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        flex-shrink: 0;
                        margin-left: 10px;
                    }

                    .risk-low {
                        background: #d4edda;
                        color: #155724;
                    }

                    .risk-medium {
                        background: #fff3cd;
                        color: #856404;
                    }

                    .risk-high {
                        background: #f8d7da;
                        color: #721c24;
                    }

                    .card-body {
                        padding: 0 22px 20px;
                    }

                    .info-section {
                        margin-bottom: 14px;
                    }

                    .info-section .label {
                        font-size: 11px;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.8px;
                        color: #1abc9c;
                        margin-bottom: 4px;
                    }

                    .info-section .value {
                        font-size: 14px;
                        color: #555;
                        line-height: 1.5;
                    }

                    /* ── Tags Row ───────────────────────────────────────── */
                    .tags-row {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 8px;
                        padding: 0 22px 18px;
                        border-top: 1px solid #f0f0f0;
                        padding-top: 14px;
                    }

                    .tag {
                        display: inline-flex;
                        align-items: center;
                        gap: 4px;
                        padding: 5px 12px;
                        border-radius: 20px;
                        font-size: 12px;
                        font-weight: 600;
                    }

                    .tag-age {
                        background: #e8f4fd;
                        color: #2980b9;
                    }

                    .tag-pregnancy-safe {
                        background: #d4edda;
                        color: #155724;
                    }

                    .tag-pregnancy-warn {
                        background: #f8d7da;
                        color: #721c24;
                    }

                    /* ── No Results ─────────────────────────────────────── */
                    .no-results {
                        text-align: center;
                        padding: 80px 20px;
                        color: rgba(255, 255, 255, 0.8);
                    }

                    .no-results .icon {
                        font-size: 60px;
                        margin-bottom: 15px;
                    }

                    .no-results h2 {
                        font-size: 24px;
                        margin-bottom: 10px;
                    }

                    .no-results p {
                        font-size: 16px;
                        color: rgba(255, 255, 255, 0.5);
                    }

                    /* ── Error ──────────────────────────────────────────── */
                    .error-box {
                        max-width: 500px;
                        margin: 60px auto;
                        background: #f8d7da;
                        color: #721c24;
                        padding: 25px;
                        border-radius: 12px;
                        text-align: center;
                        font-size: 16px;
                    }

                    /* ── Responsive ─────────────────────────────────────── */
                    @media (max-width: 480px) {
                        .card-grid {
                            grid-template-columns: 1fr;
                            padding: 15px;
                        }

                        .header {
                            flex-direction: column;
                            gap: 10px;
                            text-align: center;
                        }
                    }
                </style>
            </head>

            <body>

                <!-- Header -->
                <div class="header">
                    <h1>🏥 Medic<span>Pedia</span></h1>
                    <a href="index.jsp" class="back-btn">🔍 New Search</a>
                </div>

                <% String errorMessage=(String) request.getAttribute("errorMessage"); String searchQuery=(String)
                    request.getAttribute("searchQuery"); List<Medicine> medicineList = (List<Medicine>)
                        request.getAttribute("medicineList");
                        %>

                        <% if (errorMessage !=null) { %>
                            <div class="error-box">
                                ❌ <%= errorMessage %>
                            </div>
                            <% } else if (medicineList==null || medicineList.isEmpty()) { String currentRisk=(String)
                                request.getAttribute("riskLevel"); if (currentRisk==null) currentRisk="All" ; boolean
                                hasFilter=!currentRisk.equalsIgnoreCase("All"); %>
                                <div class="no-results">
                                    <div class="icon">🔍</div>
                                    <% if (hasFilter) { %>
                                        <h2>No <%= currentRisk %> risk medicines found</h2>
                                        <p>No results for "<%= searchQuery %>" with <strong>
                                                    <%= currentRisk %>
                                                </strong> risk level.</p>
                                        <br>
                                        <div style="display: flex; gap: 10px; justify-content: center;">
                                            <a href="searchMedicine?medicineName=<%= java.net.URLEncoder.encode(searchQuery, "UTF-8") %>&riskLevel=All"
 class="back-btn" style="background:
                                                linear-gradient(135deg, #3498db, #2980b9); box-shadow: 0 3px 10px
                                                rgba(41, 128, 185, 0.3);">All Results</a>
                                            <a href="index.jsp" class="back-btn">New Search</a>
                                        </div>
                                        <% } else { %>
                                            <h2>No medicines found</h2>
                                            <p>No results for "<%= searchQuery %>". Try a different search term.</p>
                                            <br>
                                            <a href="index.jsp" class="back-btn">← Go Back</a>
                                            <% } %>
                                </div>
                                <% } else { %>

                                    <!-- Search Info -->
                                    <div class="search-info">
                                        <h2>Results for "<span class="query">
                                                <%= searchQuery %>
                                            </span>"</h2>
                                        <p class="count">
                                            <%= medicineList.size() %> medicine(s) found
                                        </p>
                                    </div>

                                    <!-- Filter Section -->
                                    <% String filterRisk=(String) request.getAttribute("riskLevel"); if
                                        (filterRisk==null) filterRisk="All" ; String
                                        encQuery=java.net.URLEncoder.encode(searchQuery, "UTF-8" ); %>
                                        <div class="filter-section">
                                            <span class="filter-label">Filter by Risk:</span>
                                            <div class="filter-options">
                                                <a href="searchMedicine?medicineName=<%= encQuery %>&riskLevel=All"
                                                    class="filter-btn <%= " All".equalsIgnoreCase(filterRisk) ? "active"
                                                    : "" %>">All</a>
                                                <a href="searchMedicine?medicineName=<%= encQuery %>&riskLevel=Low"
                                                    class="filter-btn <%= " Low".equalsIgnoreCase(filterRisk) ? "active"
                                                    : "" %>">Low</a>
                                                <a href="searchMedicine?medicineName=<%= encQuery %>&riskLevel=Medium"
                                                    class="filter-btn <%= " Medium".equalsIgnoreCase(filterRisk)
                                                    ? "active" : "" %>">Medium</a>
                                                <a href="searchMedicine?medicineName=<%= encQuery %>&riskLevel=High"
                                                    class="filter-btn <%= " High".equalsIgnoreCase(filterRisk)
                                                    ? "active" : "" %>">High</a>
                                            </div>
                                        </div>

                                        <style>
                                            .filter-section {
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                gap: 15px;
                                                margin-bottom: 30px;
                                                flex-wrap: wrap;
                                            }

                                            .filter-label {
                                                color: #fff;
                                                font-weight: 600;
                                                font-size: 16px;
                                            }

                                            .filter-options {
                                                display: flex;
                                                gap: 10px;
                                                background: rgba(255, 255, 255, 0.15);
                                                padding: 5px;
                                                border-radius: 30px;
                                            }

                                            .filter-btn {
                                                padding: 8px 20px;
                                                border-radius: 25px;
                                                text-decoration: none;
                                                color: rgba(255, 255, 255, 0.8);
                                                font-size: 14px;
                                                font-weight: 600;
                                                transition: all 0.3s ease;
                                            }

                                            .filter-btn:hover {
                                                color: #fff;
                                                background: rgba(255, 255, 255, 0.1);
                                            }

                                            .filter-btn.active {
                                                background: #1abc9c;
                                                color: #fff;
                                                box-shadow: 0 4px 15px rgba(26, 188, 156, 0.4);
                                            }
                                        </style>

                                        <!-- Cards -->
                                        <div class="card-grid">
                                            <% for (Medicine med : medicineList) { String riskClass="risk-low" ; if
                                                ("Medium".equalsIgnoreCase(med.getRiskLevel())) riskClass="risk-medium"
                                                ; else if ("High".equalsIgnoreCase(med.getRiskLevel()))
                                                riskClass="risk-high" ; %>
                                                <div class="med-card">
                                                    <div class="card-img-container"
                                                        style="height: 180px; overflow: hidden; display: flex; align-items: center; justify-content: center; background: #fff;">
                                                        <img src="<%= med.getImagePath() %>" alt="<%= med.getName() %>"
                                                            style="max-height: 100%; max-width: 100%; object-fit: contain;"
                                                            onerror="this.onerror=null;this.src='images/default.jpg';">
                                                    </div>
                                                    <div class="card-header">
                                                        <h3>💊 <%= med.getName() %>
                                                        </h3>
                                                        <span class="risk-badge <%= riskClass %>">
                                                            <%= med.getRiskLevel() %> Risk
                                                        </span>
                                                    </div>

                                                    <div class="card-body">
                                                        <div class="info-section">
                                                            <div class="label">Uses</div>
                                                            <div class="value">
                                                                <%= med.getUses() %>
                                                            </div>
                                                        </div>
                                                        <div class="info-section">
                                                            <div class="label">Side Effects</div>
                                                            <div class="value">
                                                                <%= med.getSideEffects() %>
                                                            </div>
                                                        </div>
                                                        <div class="info-section">
                                                            <div class="label">Precautions</div>
                                                            <div class="value">
                                                                <%= med.getPrecautions() %>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="tags-row">
                                                        <span class="tag tag-age">👤 Age: <%= med.getMinAge() %> – <%=
                                                                    med.getMaxAge() %> yrs</span>
                                                        <% if (med.isPregnancyWarning()) { %>
                                                            <span class="tag tag-pregnancy-warn">⚠️ Pregnancy
                                                                Warning</span>
                                                            <% } else { %>
                                                                <span class="tag tag-pregnancy-safe">✅ Pregnancy
                                                                    Safe</span>
                                                                <% } %>
                                                    </div>
                                                </div>
                                                <% } %>
                                        </div>

                                        <% /* Pagination Controls */ Integer currentPage=(Integer)
                                            request.getAttribute("currentPage"); Integer totalPages=(Integer)
                                            request.getAttribute("totalPages"); String pagRisk=(String)
                                            request.getAttribute("riskLevel"); if (pagRisk==null) pagRisk="All" ; if
                                            (currentPage==null) currentPage=1; if (totalPages==null) totalPages=1; if
                                            (totalPages> 1) {
                                            String riskParam = (pagRisk != null && !pagRisk.equalsIgnoreCase("All")) ?
                                            "&riskLevel=" + pagRisk : "";
                                            %>
                                            <div class="pagination-container"
                                                style="text-align: center; padding: 20px; margin-bottom: 40px;">
                                                <% if (currentPage> 1) { %>
                                                    <a href="searchMedicine?medicineName=<%= java.net.URLEncoder.encode(searchQuery, "UTF-8") %>&page=<%= currentPage - 1 %><%= riskParam %>" class="pagination-btn">← Previous</a>

                                                    <% } else { %>
                                                        <span class="pagination-btn disabled">← Previous</span>
                                                        <% } %>

                                                            <span class="pagination-info"
                                                                style="margin: 0 15px; font-weight: 600; color: rgba(255, 255, 255, 0.9);">
                                                                Page <%= currentPage %> of <%= totalPages %>
                                                            </span>

                                                            <% if (currentPage < totalPages) { %>
                                                               <a href="searchMedicine?medicineName=<%= java.net.URLEncoder.encode(searchQuery, "UTF-8") %>&page=<%= currentPage + 1 %><%= riskParam %>" class="pagination-btn">Next →</a>

                                                                <% } else { %>
                                                                    <span class="pagination-btn disabled">Next →</span>
                                                                    <% } %>
                                            </div>

                                            <style>
                                                .pagination-btn {
                                                    display: inline-block;
                                                    padding: 10px 20px;
                                                    background: rgba(255, 255, 255, 0.1);
                                                    color: #fff;
                                                    text-decoration: none;
                                                    border-radius: 8px;
                                                    transition: all 0.3s ease;
                                                    border: 1px solid rgba(255, 255, 255, 0.2);
                                                }

                                                .pagination-btn:hover:not(.disabled) {
                                                    background: rgba(255, 255, 255, 0.25);
                                                    transform: translateY(-2px);
                                                }

                                                .pagination-btn.disabled {
                                                    opacity: 0.5;
                                                    cursor: not-allowed;
                                                    background: rgba(0, 0, 0, 0.1);
                                                }
                                            </style>
                                            <% } %>

                                                <% } %>

            </body>

            </html>