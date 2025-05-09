package com.ems.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.PayrollDAO;

@WebServlet("/PayrollDeleteServlet")
public class PayrollDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        try {
            int pay_id = Integer.parseInt(request.getParameter("pay_id"));
            
            boolean isDeleted = PayrollDAO.deletedata(pay_id);
            
            if (isDeleted) {
            	response.sendRedirect("PayrollGetAllServlet?status=delete_success"); 
            } else {
            	response.sendRedirect("PayrollGetAllServlet?status=error"); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error occurred while deleting payroll.'); window.history.back();</script>");
        }
    }
}



