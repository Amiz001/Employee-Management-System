package com.ems.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;

@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
        try {
            EmployeeDAO dao = new EmployeeDAO();
            List<Employee> employees = dao.getEmployees();

            request.setAttribute("employeeList", employees);
            RequestDispatcher dispatcher = request.getRequestDispatcher("./dashboard/hrManager/employee.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./dashboard/hrManager/employee.jsp?error=Server error");
        }
	}
}
