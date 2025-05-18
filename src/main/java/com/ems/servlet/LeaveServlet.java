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

@WebServlet("/LeaveServlet")
public class LeaveServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

        	HttpSession session = request.getSession(false);
        	String email =(String) session.getAttribute("email");
        	int empId =(int) session.getAttribute("empId");
        	
            LeaveDAO dao = new LeaveDAO();
            List<Leave> leaves = dao.getLeaves(email);
            
            EmployeeDAO empdao = new EmployeeDAO();
            Employee emp = empdao.getEmployeeById(empId);
            
            request.setAttribute("employee", emp);
            
            String status = null, message = null;
            status = request.getParameter("status");  
            message = request.getParameter("message");

            request.setAttribute("leaveList", leaves);
            RequestDispatcher dispatcher = request.getRequestDispatcher("./dashboard/employee/leave.jsp?status=" + status + "&message=" + message);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./dashboard/employee/leave.jsp?error=Server error");
        }
    }
}

