package com.ems.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.DepartmentDAO;
import com.ems.util.DBConnection;

@WebServlet("/DepartmentDeleteServlet")
@SuppressWarnings("serial")
public class DepartmentDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int dep_id = Integer.parseInt(request.getParameter("dep_id"));
            
            boolean isTrue = DepartmentDAO.deleteDepartment(dep_id);

            if (isTrue) {
                response.sendRedirect("DepartmentServlet?message=Department deleted successfully");
            } else {
                response.sendRedirect("unsuccess.jsp");
            }
        }catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}