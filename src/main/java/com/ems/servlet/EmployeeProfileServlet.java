package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.dao.EmployeeDAO;
import com.ems.dao.PayrollDAO;
import com.ems.model.Employee;
import com.ems.model.Payroll;

@WebServlet("/EmployeeProfileServlet")
public class EmployeeProfileServlet extends HttpServlet {
	
	private static final String UPLOAD_DIR = "assets/uploads";
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		
		HttpSession session = request.getSession(false);
		int empId = (int) session.getAttribute("empId");
		
        try {
            EmployeeDAO dao = new EmployeeDAO();
            Employee employee = dao.getEmployeeById(empId);
            
            Payroll pay = PayrollDAO.getByEmpId(empId);

            request.setAttribute("payroll", pay);
            request.setAttribute("employee", employee);
            
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("./dashboard/employee/profile.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./dashboard/employee/profile.jsp?error=Server error");
        }
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		    	
		        try {
		        	HttpSession session = request.getSession();
		        	int empId = (int) session.getAttribute("empId");
		        	
		    		String name = request.getParameter("name");
		            String email = request.getParameter("email");
		            String phone = request.getParameter("phone");
		            String gender = request.getParameter("gender");           

		            String dobStr = request.getParameter("dob");    
		            Date dob = Date.valueOf(dobStr);

		            Employee employee = new Employee();
		            
		            employee.setEmpId(empId);
		            employee.setName(name);
		            employee.setEmail(email);
		            employee.setPhone(phone);
		            employee.setGender(gender);
		            employee.setDob(dob);
		            
		            EmployeeDAO dao = new EmployeeDAO();
		            System.out.print("DAO called");
		            
		            if(dao.updateProfile(employee)) {
		            	response.sendRedirect("EmployeeProfileServlet");
		            } else {
		                System.out.println("Update failed");
		            }
		   
		        } catch (Exception e) {
		        	System.out.print("Exception");
		            e.printStackTrace();
		        }  
		    }
}
