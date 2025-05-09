package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.TaskmanagementDAO;


@WebServlet("/TaskmanagementUpdateServlet")
public class TaskmanagementUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int task_id = Integer.parseInt(request.getParameter("task_id"));
	    String title = request.getParameter("title");
	    int emp_id = Integer.parseInt(request.getParameter("emp_id"));
	    Date deadline = Date.valueOf(request.getParameter("deadline"));
	    Date start_date = Date.valueOf(request.getParameter("start_date"));
	    String status = request.getParameter("status");

	    boolean isTrue = TaskmanagementDAO.updatedata(task_id, title, emp_id, deadline, start_date, status);

		
	    if (isTrue) {
	    	response.sendRedirect("TaskmanagementServlet?status=update_success");
	    } else {
	    	response.sendRedirect("TaskmanagementServlet?status=error");
	    }
  
	}
	

}
