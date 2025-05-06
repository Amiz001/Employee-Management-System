package com.ems.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.LeaveDAO;
import com.ems.model.Leave;

import java.sql.*;

@WebServlet("/LeaveUpdateServlet")
public class LeaveUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	
		int leaveId = Integer.parseInt(request.getParameter("leaveId"));
        String leaveType = request.getParameter("leaveType");
        String startDateStr = request.getParameter("startDate");
		String endDateStr = request.getParameter("endDate");
		String reason = request.getParameter("reason");
		
		Date startDate = Date.valueOf(startDateStr);
		Date endDate = Date.valueOf(endDateStr);

        Leave leave = new Leave();
        
        leave.setLeaveId(leaveId);
        leave.setLeaveType(leaveType);
        leave.setStartDate(startDate);
        leave.setEndDate(endDate);
        leave.setReason(reason);

        try {
            LeaveDAO dao = new LeaveDAO();
            
            if(dao.updateLeave(leave)) {
            	response.sendRedirect("LeaveServlet");
            }
   
        } catch (Exception e) {
            e.printStackTrace();
        }  
    }   
}
