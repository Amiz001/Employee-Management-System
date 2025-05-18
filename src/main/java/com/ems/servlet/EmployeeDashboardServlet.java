package com.ems.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.LeaveDAO;
import com.ems.model.DashboardData;

@WebServlet("/EmployeeDashboardServlet")
public class EmployeeDashboardServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        DashboardData data = new DashboardData();
        
        LeaveDAO leave_dao = new LeaveDAO();
        
        request.setAttribute("dashboardData", data);

        RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
        rd.forward(request, response);
    }
}



