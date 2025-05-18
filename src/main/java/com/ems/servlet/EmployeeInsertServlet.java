package com.ems.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;


@WebServlet("/EmployeeInsertServlet")
public class EmployeeInsertServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		try {

	    	String name = request.getParameter("name");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String phone = request.getParameter("phone");
	        String department = request.getParameter("department");
	        String gender = request.getParameter("gender");
	        String role = request.getParameter("role");
	        int leaveCount = Integer.parseInt(request.getParameter("leaveCount"));
	        double basicSalary = Double.parseDouble(request.getParameter("basicSalary"));

	        String dobStr = request.getParameter("dob");    
	        Date dob = Date.valueOf(dobStr);
	        
	        String profilePhoto = "default.jpg";
	                   
	        Employee employee = new Employee(name, email, password, phone, department, dob, gender, role, leaveCount, basicSalary, profilePhoto);
	        EmployeeDAO dao = new EmployeeDAO();
	        
	        if(dao.insertEmployee(employee)) {
	            response.sendRedirect("EmployeeServlet");
	        } else {
	            System.out.println("unsuccessfull");
	        }
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("Excepton got");
		}
	}
}

