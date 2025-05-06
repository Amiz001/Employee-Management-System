package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.dao.LeaveDAO;
import com.ems.model.Leave;

@WebServlet("/leaveInsertServlet")
public class leaveInsertServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		try {
			
			HttpSession session = request.getSession(false);
	    	int empId = (int)session.getAttribute("empId");
	    	
			String leaveType = request.getParameter("leaveType");
			String startDateStr = request.getParameter("startDate");
			String  endDateStr = request.getParameter("endDate");
			String reason = request.getParameter("reason");
			
			Date startDate = Date.valueOf(startDateStr);
			Date endDate = Date.valueOf(endDateStr);

			Leave leave = new Leave(empId, leaveType, startDate, endDate, reason);
			
			LeaveDAO dao = new LeaveDAO();
			
			if(dao.insertLeave(leave)) {
				response.sendRedirect("LeaveServlet");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
