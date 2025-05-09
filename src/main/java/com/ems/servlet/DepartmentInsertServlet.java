package com.ems.servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.DepartmentDAO;

@WebServlet("/DepartmentInsertServlet")
public class DepartmentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int dep_id = Integer.parseInt(request.getParameter("dep_id"));
        String name = request.getParameter("name");
        int no_of_emp = Integer.parseInt(request.getParameter("no_of_emp"));
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String supervisor_id = request.getParameter("supervisor_id");
       
		boolean isTrue = DepartmentDAO.insertdata(dep_id, name, no_of_emp, phone, email, supervisor_id);

        if (isTrue) {
        	response.sendRedirect("DepartmentServlet?status=add_success"); 
        } else {
        	response.sendRedirect("DepartmentServlet?status=error"); 
        }
	}
}