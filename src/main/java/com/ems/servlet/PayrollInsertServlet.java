package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.PayrollDAO;
import com.ems.dao.EmployeeDAO;

@WebServlet("/PayrollInsertServlet")
public class PayrollInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		try {
			// Retrieve form data
			int emp_id = Integer.parseInt(request.getParameter("emp_id"));
			double basic = Double.parseDouble(request.getParameter("basic"));
			double ot = Double.parseDouble(request.getParameter("ot"));
			double allowance = Double.parseDouble(request.getParameter("allowance"));
			Date created_date = Date.valueOf(request.getParameter("created_date"));

			// Validate emp_id
			if (emp_id <= 0 || !EmployeeDAO.exists(emp_id)) {
				// Redirect to error page or show message
				response.sendRedirect("EmployeeInfoServlet?status=error&message=Payroll record already exists for this employee and month");
				return;
			}
			
			// Check if salary already exists for the month
			if (PayrollDAO.existsForMonth(emp_id, created_date)) {
			    response.sendRedirect("EmployeeInfoServlet?status=error&message=Payroll record already exists for this employee and month");
			    return;
			}

			// Business logic: calculate total salary
			double total_salary = basic + ot + allowance;

			// Call DAO to insert
			boolean success = PayrollDAO.insertdata(emp_id, basic, ot, allowance, total_salary, created_date);

			if (success) {
				response.sendRedirect("PayrollGetAllServlet?status=add_success");
			} else {
				response.sendRedirect("PayrollGetAllServlet?status=error");
			}
		} catch (NumberFormatException e) {
			response.sendRedirect("EmployeeInfoServlet?status=error&message=Payroll record already exists for this employee and month");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("EmployeeInfoServlet?status=error&message=Payroll record already exists for this employee and month");
		}
	}
}



/*package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.PayrollDAO;

@WebServlet("/PayrollInsertServlet")
public class PayrollInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
	
			
			// Retrieve form data
			int emp_id = Integer.parseInt(request.getParameter("emp_id"));
			double basic = Double.parseDouble(request.getParameter("basic"));
			double ot = Double.parseDouble(request.getParameter("ot"));
			double allowance = Double.parseDouble(request.getParameter("allowance"));
			Date created_date = Date.valueOf(request.getParameter("created_date"));

			// Business logic: calculate total salary
			double total_salary = basic + ot + allowance;

			// Call DAO to insert
			boolean success = PayrollDAO.insertdata(emp_id, basic, ot, allowance, total_salary, created_date);
           
			if (success) {
				response.sendRedirect("PayrollGetAllServlet?status=add_success");
				//String alertMessage = "Data Insert Successful";
				//response.getWriter().println("<script> alert('" + alertMessage + "'); window.location.href='PayrollGetAllServlet'</script>");
			} else {
				response.sendRedirect("PayrollGetAllServlet?status=error");
			}
	}
}*/



