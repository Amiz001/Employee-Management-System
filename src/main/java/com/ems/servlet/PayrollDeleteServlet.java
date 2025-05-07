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

@WebServlet("/PayrollDeleteServlet")
public class PayrollDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pay_id= Integer.parseInt(request.getParameter("pay_id"));
		boolean isTrue;
		isTrue = PayrollDAO.deletedata(pay_id);
		
		if(isTrue == true) {
			 String alertMessage = "Data Delete Successful";
			 response.getWriter().println("<script> alert('"+alertMessage+"'); window.location.href='PayrollGetAllServlet'</script>");
		 }
		 else {
			 List<Payroll> salarydetails = PayrollDAO.getById(pay_id);
			 request.setAttribute("salarydetails", salarydetails);
			 
			 RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
             dis2.forward(request, response);
		 }
	}

}

