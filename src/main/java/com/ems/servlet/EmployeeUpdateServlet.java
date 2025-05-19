package com.ems.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.EmployeeDAO;
import com.ems.dao.LeaveDAO;
import com.ems.model.Employee;
import com.ems.model.Leave;

import java.sql.*;

@WebServlet("/EmployeeUpdateServlet")
public class EmployeeUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	
        try {
        	int empId = Integer.parseInt(request.getParameter("empId"));
    		String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String department = request.getParameter("department");
            String gender = request.getParameter("gender");
            String role = request.getParameter("role");
            int leaveCount = Integer.parseInt(request.getParameter("leaveCount"));
	        double basicSalary = Double.parseDouble(request.getParameter("basicSalary"));

            String dobStr = request.getParameter("dob");    
            Date dob = Date.valueOf(dobStr);

            Employee employee = new Employee();
            
            employee.setEmpId(empId);
            employee.setName(name);
            employee.setEmail(email);
            employee.setPhone(phone);
            employee.setDepartment(department);
            employee.setGender(gender);
            employee.setRole(role);
            employee.setDob(dob);
            employee.setLeaveCount(leaveCount);
            employee.setBasicSalary(basicSalary);
            
            EmployeeDAO dao = new EmployeeDAO();
            
            if(dao.updateEmployee(employee)) {
            	response.sendRedirect("EmployeeServlet?status=update_success");
            }
   
        } catch (Exception e) {
            e.printStackTrace();
        }  
    }   
}
