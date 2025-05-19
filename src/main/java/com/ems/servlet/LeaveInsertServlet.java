package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.EmployeeDAO;
import com.ems.dao.LeaveDAO;
import com.ems.model.Employee;
import com.ems.model.Leave;

@WebServlet("/LeaveInsertServlet")
public class LeaveInsertServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
        	// Get session attributes
        	HttpSession session = request.getSession(false);
            int empId = (int) session.getAttribute("empId");

            String leaveType = request.getParameter("leaveType");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String reason = request.getParameter("reason");

            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);

            // Calculate number of leave days
            long diffInMillis = endDate.getTime() - startDate.getTime();
            int numberOfDays = (int) (diffInMillis / (1000 * 60 * 60 * 24)) + 1;

            if (numberOfDays <= 0) {
                response.sendRedirect("LeaveServlet?status=error&message=Invalid+date+range");
                return;
            }

            // Get employee leave balance
            EmployeeDAO empDao = new EmployeeDAO();
            Employee emp = empDao.getEmployeeById(empId);
            int leaveCount = emp.getLeaveCount();

            if (numberOfDays > leaveCount) {
                response.sendRedirect("LeaveServlet?status=error&message=Insufficient+leave+balance");
                return;
            }

            // Check for overlapping leave
            LeaveDAO leaveDao = new LeaveDAO();
            if (leaveDao.hasOverlappingFutureLeave(empId, startDate, endDate)) {
                response.sendRedirect("LeaveServlet?status=error&message=Leave+overlaps+with+existing+future+request");
                return;
            }

            // Insert leave
            Leave leave = new Leave(empId, leaveType, startDate, endDate, reason);
            boolean isInserted = leaveDao.insertLeave(leave);

            if (isInserted) {
                response.sendRedirect("LeaveServlet?status=add_success");
            } else {
                response.sendRedirect("LeaveServlet?status=error&message=Failed+to+add+leave+request");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("LeaveServlet?status=error&message=Invalid+input+format");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("LeaveServlet?status=error&message=Database+error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("LeaveServlet?status=error&message=Internal+server+error");
        }
    }
}
