package com.ems.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.dao.EmployeeDAO;

@WebServlet("/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

        	HttpSession session = request.getSession();
        	int empId = (int) session.getAttribute("empId");
        	
        	String password = request.getParameter("pswd1");
        	
        	EmployeeDAO dao = new EmployeeDAO();

            if (dao.updatePassword(empId, password)) {
            	response.sendRedirect("EmployeeProfileServlet?status=password_success"); 
            } else {
            	response.sendRedirect("EmployeeProfileServlet?status=error"); 
            }
        }catch(Exception e) {
        	e.printStackTrace();
        	response.sendRedirect("EmployeeProfileServlet?status=error");
        }
    }
}