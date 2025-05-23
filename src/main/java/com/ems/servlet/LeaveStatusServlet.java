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
import com.ems.dao.LeaveDAO;
import com.ems.model.Employee;
import com.ems.model.Leave;

@WebServlet("/LeaveStatusServlet")
public class LeaveStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {   
        	
            int empId =  Integer.parseInt(request.getParameter("empId"));
        	int id =  Integer.parseInt(request.getParameter("leaveId"));
        	int totalDays =  Integer.parseInt(request.getParameter("totalDays"));
        	String action = (String) request.getParameter("action");
        	
        	LeaveDAO dao = new LeaveDAO();
        	String status = null;
        	
            EmployeeDAO empdao = new EmployeeDAO();
            Employee emp = empdao.getEmployeeById(empId);
            int leaveCount = emp.getLeaveCount();
        	
        	if(action.equals("accept")) {
        		 dao.updateLeaveCount(empId, leaveCount - totalDays);
        		 status = dao.updateStatus(id, "Approved") ? "update_success" : "error";
        	}
        	else if(action.equals("reject")) {
        		status = dao.updateStatus(id, "Rejected") ? "update_success" : "error";
        	}
        	else {
        		dao.updateStatus(id, "Pending");
        	}
            
        	response.sendRedirect("LeaveManageServlet?status=" + status);
            

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("LeaveManageServlet?status=error");
        }
    }
}



