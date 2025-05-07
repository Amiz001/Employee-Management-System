package com.ems.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.LeaveDAO;

import java.sql.*;

@WebServlet("/LeaveDeleteServlet")
public class LeaveDeleteServlet extends HttpServlet {
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
		
        int leaveId = Integer.parseInt(request.getParameter("leaveId"));

        try {
            LeaveDAO dao = new LeaveDAO(); 
            dao.deleteLeave(leaveId);
            
            response.sendRedirect("LeaveServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

