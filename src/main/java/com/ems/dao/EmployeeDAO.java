package com.ems.dao;

import java.sql.*;
import com.ems.model.Employee;
import com.ems.util.DBConnection;

public class EmployeeDAO {
    public Employee validate(String email, String password) throws Exception {
    	
        Connection conn = DBConnection.getConnection();
        
        String sql = "SELECT * FROM employee WHERE email = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setString(1, email);
        ps.setString(2, password);
        
        ResultSet rs = ps.executeQuery();

        
        if (rs.next()) {
        	
        	int empId = rs.getInt("emp_id");
            String name = rs.getString("name");
            String role = rs.getString("role");
            String profilePhoto = rs.getString("profile_photo");
            
            return new Employee(empId, name, email, role, profilePhoto);
        }
        return null;
    }
}
