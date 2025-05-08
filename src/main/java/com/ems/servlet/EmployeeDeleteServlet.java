package com.ems.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.EmployeeDAO;

@WebServlet("/EmployeeDeleteServlet")
public class EmployeeDeleteServlet extends HttpServlet {
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
		
        int empId = Integer.parseInt(request.getParameter("empId"));

        try {
            EmployeeDAO dao = new EmployeeDAO(); 
            dao.deleteEmployee(empId);
            
            response.sendRedirect("EmployeeServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

