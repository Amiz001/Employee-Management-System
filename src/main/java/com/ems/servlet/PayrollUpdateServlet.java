package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.PayrollDAO;
import com.ems.model.Payroll;

@WebServlet("/PayrollUpdateServlet")
public class PayrollUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  
		 int pay_id= Integer.parseInt(request.getParameter("pay_id"));
		 int emp_id= Integer.parseInt(request.getParameter("emp_id"));
		 double basic= Double.parseDouble(request.getParameter("basic"));
		 double ot= Double.parseDouble(request.getParameter("ot"));
	     double allowance= Double.parseDouble(request.getParameter("allowance"));
	     Date date = Date.valueOf(request.getParameter("date"));
	     
	     try {
				// Convert String to double for calculation
				//double basicc = Double.parseDouble(basic);
				//double ott = Double.parseDouble(ot);
				//double allowancee = Double.parseDouble(allowance);

				// Calculate total salary
				double total_salary = basic + ot + allowance;

				// Convert salary back to String (if needed for database insertion)
				//String salary = String.valueOf(salaryy);
			
				// Insert data into the database
				boolean isTrue = PayrollDAO.updatedata(pay_id, emp_id, basic, ot, allowance, total_salary, date);

				// Redirect based on success or failure
				if (isTrue == true) {
					List<Payroll> salarydetails = PayrollDAO.getById(pay_id);
					request.setAttribute("salarydetails", salarydetails);
					 
					 String alertMessage = "Data Update Successful";
					 response.getWriter().println("<script> alert('"+alertMessage+"'); window.location.href='PayrollGetAllServlet'</script>");
				} else {
					RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
					dis2.forward(request, response);
				}
			} catch (NumberFormatException e) {
				// Handle invalid input (non-numeric values)
				response.getWriter().println("<script> alert('Invalid input. Please enter numeric values for salary fields.'); window.history.back(); </script>");
			}
	
	}

}

