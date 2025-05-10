package com.ems.servlet;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ems.dao.PayrollDAO;
import com.ems.model.Payroll;

@WebServlet("/PayrollUpdateServlet")
public class PayrollUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        try {
            // Get form parameters
            int pay_id = Integer.parseInt(request.getParameter("pay_id"));
            int emp_id = Integer.parseInt(request.getParameter("emp_id"));
            double basic = Double.parseDouble(request.getParameter("basic"));
            double ot = Double.parseDouble(request.getParameter("ot"));
            double allowance = Double.parseDouble(request.getParameter("allowance"));
            Date created_date = Date.valueOf(request.getParameter("created_date"));

            // Calculate total salary
            double total_salary = basic + ot + allowance;

            // Create Payroll object
            Payroll payroll = new Payroll();
            payroll.setPay_id(pay_id);
            payroll.setEmp_id(emp_id);
            payroll.setBasic(basic);
            payroll.setOt(ot);
            payroll.setAllowance(allowance);
            payroll.setTotal_salary(total_salary);
            payroll.setCreated_date(created_date);

            // Update payroll in DB
            boolean isUpdated = PayrollDAO.updatedata(pay_id,emp_id,basic,ot,allowance,total_salary,created_date);


            if (isUpdated) {
            	response.sendRedirect("PayrollGetAllServlet?status=update_success"); 
            } else {
            	response.sendRedirect("PayrollGetAllServlet?status=error"); 
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred. Check server logs.'); window.history.back();</script>");
        }
    }
}


