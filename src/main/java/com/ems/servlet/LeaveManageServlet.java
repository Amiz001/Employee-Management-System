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

@WebServlet("/LeaveManageServlet")
public class LeaveManageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {   	
            LeaveDAO dao = new LeaveDAO();
            List<Leave> leaves = dao.getAllLeaves();
            
            EmployeeDAO empdao = new EmployeeDAO();
            List<Employee> employees = empdao.getEmployees();
            
            String status = null;
            status = request.getParameter("status");

            request.setAttribute("leaveList", leaves);
            request.setAttribute("employeeList", employees);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("./dashboard/supervisor/leaveRequest.jsp?status=" + status);
            dispatcher.forward(request, response);
            

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./dashboard/supervisor/leaveRequest.jsp?status=error");
        }
    }
}


