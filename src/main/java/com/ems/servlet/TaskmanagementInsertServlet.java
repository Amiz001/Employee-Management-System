package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.EmployeeDAO;
import com.ems.dao.PayrollDAO;
import com.ems.dao.TaskmanagementDAO;

@WebServlet("/TaskmanagementInsertServlet")
public class TaskmanagementInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    try {
        String title = request.getParameter("title");
        int emp_id = Integer.parseInt(request.getParameter("emp_id"));
        Date deadline = Date.valueOf(request.getParameter("deadline"));
        Date start_date = Date.valueOf(request.getParameter("start_date"));
        String status = request.getParameter("status");
        
        // Validate emp_id
    	if (emp_id <= 0 || !EmployeeDAO.exists(emp_id)) {
    		response.sendRedirect("TaskmanagementServlet?status=error&message=Invalid+Employee+Id");
    		return;
    	}
    	
    	// Call DAO to insert
    	boolean isTrue = TaskmanagementDAO.inserttask(title, emp_id, deadline, start_date, status);
       
    	if (isTrue) {
	    	response.sendRedirect("TaskmanagementServlet?status=add_success");
	    	
	    } else {
	    	response.sendRedirect("TaskmanagementServlet?status=error");
	    }
  
    	
    } catch (NumberFormatException e) {
    	response.sendRedirect("EmployeeInfo2Servlet?status=error&message=Invalid+Employee+Id");
    } catch (Exception e) {
    	e.printStackTrace();
    	response.sendRedirect("EmployeeInfo2Servlet?status=error&message=Invalid+Employee+Id");
    }
  }  
    
}

