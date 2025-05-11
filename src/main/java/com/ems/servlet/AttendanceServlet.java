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

import com.ems.dao.AttendanceDAO;
import com.ems.model.Attendance;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

        	HttpSession session = request.getSession(false);
        	int empId = (int) session.getAttribute("empId");
        	
        	AttendanceDAO dao = new AttendanceDAO();
            List<Attendance> attendances = dao.getAttendances(empId);
            
            String status = null;
            status = request.getParameter("status");

            request.setAttribute("attendanceList", attendances);
            RequestDispatcher dispatcher = request.getRequestDispatcher("./dashboard/employee/attendance.jsp?status=" + status);
            dispatcher.forward(request, response);
            

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./dashboard/employee/attendance.jsp?error=Server error");
        }
    }
}


