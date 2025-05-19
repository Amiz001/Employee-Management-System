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

@WebServlet("/LeaveUpdateServlet")
public class LeaveUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
        	// Get session attributes
        	HttpSession session = request.getSession(false);
            int empId = (int) session.getAttribute("empId");

            int leaveId = Integer.parseInt(request.getParameter("leaveId"));
            String leaveType = request.getParameter("leaveType");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String reason = request.getParameter("reason");

            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);

            // Validate date range
            long diffInMillis = endDate.getTime() - startDate.getTime();
            int numberOfDays = (int) (diffInMillis / (1000 * 60 * 60 * 24)) + 1;

            if (numberOfDays <= 0) {
                response.sendRedirect("LeaveServlet?status=error&message=Invalid+Date+Range");
                return;
            }

            // Get employee and leave info
            EmployeeDAO empDao = new EmployeeDAO();
            Employee emp = empDao.getEmployeeById(empId);

            if (numberOfDays > emp.getLeaveCount()) {
                response.sendRedirect("LeaveServlet?status=error&message=Insufficient+leave+balance");
                return;
            }

            LeaveDAO leaveDao = new LeaveDAO();

            Leave leave = new Leave();
            leave.setLeaveId(leaveId);
            leave.setLeaveType(leaveType);
            leave.setStartDate(startDate);
            leave.setEndDate(endDate);
            leave.setReason(reason);

            if (leaveDao.updateLeave(leave)) {
                response.sendRedirect("LeaveServlet?status=update_success");
            } else {
                response.sendRedirect("LeaveServlet?status=error&message=Failed+to+update+leave");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("LeaveServlet?status=error&message=Invalid+input+data");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("LeaveServlet?status=error&message=Database+error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("LeaveServlet?status=error&message=Unexpected+server+error");
        }
    }
}
