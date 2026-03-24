package com.medicpedia.servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medicpedia.dao.MedicineDAO;
import com.medicpedia.model.Medicine;

@WebServlet("/admin/MedicineFormServlet")
public class AdminMedicineFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            MedicineDAO dao = new MedicineDAO();
            Medicine med = dao.getMedicineById(id);
            request.setAttribute("medicine", med);
        }
        request.getRequestDispatcher("/WEB-INF/admin/medicine-form.jsp").forward(request, response);
    }
}
