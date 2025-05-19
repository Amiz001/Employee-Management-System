package com.ems.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.EmployeeDAO;
import com.ems.dao.LeaveDAO;
import com.ems.model.Employee;
import com.ems.model.Leave;

@WebServlet("/LeaveServlet")
public class LeaveServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	String status = null;
        String message = null;

        try {
        	// Get session attributes
            HttpSession session = request.getSession(false);
            String email = (String) session.getAttribute("email");
            int empId = (int) session.getAttribute("empId");

            LeaveDAO leaveDao = new LeaveDAO();
            List<Leave> leaveList = leaveDao.getLeaves(email);

            EmployeeDAO empDao = new EmployeeDAO();
            Employee employee = empDao.getEmployeeById(empId);

            // Set attributes for the JSP
            request.setAttribute("employee", employee);
            request.setAttribute("leaveList", leaveList);

            status = request.getParameter("status");
            message = request.getParameter("message");

            RequestDispatcher dispatcher = request.getRequestDispatcher(
                    "./dashboard/employee/leave.jsp?status=" + status + "&message=" + message);
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("./dashboard/employee/leave.jsp?status=" + status + "&message=" + message);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./dashboard/employee/leave.jsp?status=" + status + "&message=" + message);
        }
    }
}
