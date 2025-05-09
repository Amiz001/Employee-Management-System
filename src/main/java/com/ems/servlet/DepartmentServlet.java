package com.ems.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.DepartmentDAO;
import com.ems.model.Department;

@WebServlet("/DepartmentServlet")
@SuppressWarnings("serial")
public class DepartmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch departments using DAO
            List<Department> departments = DepartmentDAO.getAllDepartments();

            // Optional message from request
            String message = request.getParameter("message");
            request.setAttribute("message", message);
            request.setAttribute("departments", departments);

            // Forward to JSP
            request.getRequestDispatcher("./dashboard/hrManager/department.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("unsuccess.jsp");
        }
    }
}
