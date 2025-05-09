package com.ems.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.TaskmanagementDAO;


@WebServlet("/TaskmanagementDeleteServlet")
public class TaskmanagementDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int task_id = Integer.parseInt(request.getParameter("task_id"));

	    boolean isTrue = TaskmanagementDAO.deletedata(task_id);

	    if (isTrue) {
	    	response.sendRedirect("TaskmanagementServlet?status=delete_success");
	    } else {
	    	response.sendRedirect("TaskmanagementServlet?status=error");
	    }
	    
	   
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		doPost(request,response);
	}


}