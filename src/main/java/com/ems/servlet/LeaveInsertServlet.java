package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;

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

@WebServlet("/LeaveInsertServlet")
public class LeaveInsertServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get session and employee ID
            HttpSession session = request.getSession(false);
            int empId = (int) session.getAttribute("empId");

            // Get form values
            String leaveType = request.getParameter("leaveType");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String reason = request.getParameter("reason");

            // Convert to SQL Date
            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);

            // Calculate number of days
            long diffInMillis = endDate.getTime() - startDate.getTime();
            int numberOfDays = (int) (diffInMillis / (1000 * 60 * 60 * 24)) + 1;

            // Get employee info and leave count
            EmployeeDAO empdao = new EmployeeDAO();
            Employee emp = empdao.getEmployeeById(empId);
            int leaveCount = emp.getLeaveCount();

            // Check if leave count is enough
            if (numberOfDays > leaveCount) {
                response.sendRedirect("LeaveServlet?status=error&message=Insufficient+leave+balance");
                return;
            }

            // Check for overlapping leave requests
            LeaveDAO dao = new LeaveDAO();
            if (dao.hasOverlappingFutureLeave(empId, startDate, endDate)) {
                response.sendRedirect("LeaveServlet?status=error&message=Leave+overlaps+with+existing+future+request");
                return;
            }

            // Proceed to insert leave
            leaveCount -= numberOfDays;
            Leave leave = new Leave(empId, leaveType, startDate, endDate, reason);
            boolean isTrue = dao.insertLeave(leave, leaveCount);

            if (isTrue) {
                response.sendRedirect("LeaveServlet?status=add_success");
            } else {
                response.sendRedirect("LeaveServlet?status=error&message=Failed+to+add+leave+request");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("LeaveServlet?status=error&message=Internal+server+error");
        }
    }
}
