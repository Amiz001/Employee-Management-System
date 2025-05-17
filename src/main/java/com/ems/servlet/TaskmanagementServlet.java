package com.ems.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.model.Leave;
import com.ems.model.Taskmanagement;
import com.ems.dao.LeaveDAO;
import com.ems.dao.TaskmanagementDAO;

@WebServlet("/TaskmanagementServlet")
public class TaskmanagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Taskmanagement> taskDetails = TaskmanagementDAO.getAllDetails();
        
        request.setAttribute("taskDetails", taskDetails);
        
        String status = null;
        status = request.getParameter("status");
        
        request.getRequestDispatcher("./dashboard/supervisor/task.jsp?status=" + status).forward(request, response);
       
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

