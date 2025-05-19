package com.ems.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;

@WebServlet("/EmployeeInfo2Servlet")
public class EmployeeInfo2Servlet extends HttpServlet {
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
        try {
            EmployeeDAO dao = new EmployeeDAO();
            List<Employee> employees = dao.getEmployees();
            
            String status = null;
            String message = null;
            
            status = (String) request.getParameter("status");
            message = (String) request.getParameter("message");

            request.setAttribute("employeeList", employees);
            RequestDispatcher dispatcher = request.getRequestDispatcher("./dashboard/supervisor/employees.jsp?status=" + status +"&"+ message);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./dashboard/supervisor/employees.jsp?error=Server error");
        }
	}
}

