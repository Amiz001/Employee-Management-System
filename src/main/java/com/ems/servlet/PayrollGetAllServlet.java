package com.ems.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.PayrollDAO;
import com.ems.model.Payroll;

@WebServlet("/PayrollGetAllServlet")
public class PayrollGetAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {	
	    	List <Payroll> allsalary = PayrollDAO.getAllDetails();
			request.setAttribute("allsalary", allsalary);
			
			 String status = null;
	         status = request.getParameter("status");
	         
			RequestDispatcher dispatcher = request.getRequestDispatcher("/dashboard/financialAnalyst/payroll.jsp?status=" + status);
			dispatcher.forward(request, response);
			response.getWriter().append("Served at: ").append(request.getContextPath());
		
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("./dashboard/financialAnalyst/payroll.jsp?error=Server error");
	    }
		
	}


}
