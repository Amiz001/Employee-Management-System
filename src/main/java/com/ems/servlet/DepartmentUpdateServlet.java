package com.ems.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.DepartmentDAO;
import com.ems.model.Department;
import com.ems.util.DBConnection;

@WebServlet("/DepartmentUpdateServlet")
@SuppressWarnings("serial")
public class DepartmentUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	int dep_id = Integer.parseInt(request.getParameter("dep_id"));
            String name = request.getParameter("name");
            int no_of_emp = Integer.parseInt(request.getParameter("no_of_emp"));
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String supervisor_id = request.getParameter("supervisor_id");
        
            
            Department department = new Department();
            department.setDep_id(dep_id);
            department.setName(name);
            department.setNo_of_emp(no_of_emp);
            department.setPhone(phone);
            department.setEmail(email);
            department.setSupervisor_id(supervisor_id);
            
            
            boolean isTrue = DepartmentDAO.updateDepartment(dep_id, name, no_of_emp, phone, email, supervisor_id);
      
            if (isTrue) {
            	response.sendRedirect("DepartmentServlet?status=update_success"); 
            } else {
            	response.sendRedirect("DepartmentServlet?status=error"); 
            }
        }catch(Exception e) {
        	e.printStackTrace();
        	response.getWriter().println("<script>alert('An error occured. Check Server logs.'); window.history.back();</script>");
        }
    	
    	
    } 
}
