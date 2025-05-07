package com.ems.servlet;

import com.ems.model.Employee;
import com.ems.dao.EmployeeDAO;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
        	EmployeeDAO employeeDAO = new EmployeeDAO();
            Employee user = employeeDAO.validate(email, password);

            if (user != null) {
                HttpSession session = request.getSession();
                
                session.setAttribute("empId", user.getEmpId());
                session.setAttribute("name", user.getName());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("role", user.getRole());
                session.setAttribute("profilePhoto", user.getProfilePhoto());

                switch (user.getRole().toLowerCase()) {
                    case "employee":
                        response.sendRedirect("./dashboard/employee/dashboard.jsp");
                        break;
                    case "supervisor":
                        response.sendRedirect("./dashboard/supervisor/dashboard.jsp");
                        break;
                    case "financial analyst":
                        response.sendRedirect("./dashboard/finacialAnalyst/dashboard.jsp");
                        break;
                    case "hr manager":
                        response.sendRedirect("./dashboard/hrManager/dashboard.jsp");
                        break;
                    default:
                       response.sendRedirect("index.jsp?error=Something wrong");
                        
                }
            } else {
                response.sendRedirect("index.jsp?error=Invalid credentials");
            	
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Server error");
        }
    }
}
