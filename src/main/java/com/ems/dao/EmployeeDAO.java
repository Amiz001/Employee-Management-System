package com.ems.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
    
    
    public boolean insertEmployee(Employee employee) throws SQLException {
		
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO employee (name, email, password, phone, role, department, dob, gender, profile_photo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setString(1, employee.getName());
        ps.setString(2, employee.getEmail());
        ps.setString(3, employee.getPassword());
        ps.setString(4, employee.getPhone());
        ps.setString(5, employee.getRole());
        ps.setString(6, employee.getDepartment());
        ps.setDate(7, employee.getDob());
        ps.setString(8, employee.getGender());
        ps.setString(9, employee.getProfilePhoto());
        
        return ps.executeUpdate() > 0;
    }

	
    public boolean updateEmployee(Employee employee) throws SQLException {
    	
        Connection conn = DBConnection.getConnection();
        
        String sql = "UPDATE employee SET name=?, email=?, phone=?, role=?, department=?, dob=?, gender=?, profile_photo=? WHERE emp_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setString(1, employee.getName());
        ps.setString(2, employee.getEmail());
        ps.setString(3, employee.getRole());
        ps.setString(4, employee.getDepartment());
        ps.setDate(5, employee.getDob());
        ps.setString(6, employee.getGender());
        ps.setString(7, employee.getProfilePhoto());
        ps.setInt(8, employee.getEmpId());
        
        return ps.executeUpdate() > 0;
    }

    
    public boolean deleteEmployee(int empId) throws SQLException {
    	
        Connection conn = DBConnection.getConnection();
        
        String sql = "DELETE FROM employee WHERE emp_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, empId);
        return ps.executeUpdate() > 0;
    }

    
    public Employee getEmployeeById(int empId) throws SQLException {
    	
    	Connection conn = DBConnection.getConnection();
    	
    	String sql = "SELECT * FROM employee WHERE emp_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, empId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
        	
            return new Employee(
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("department"),
                rs.getDate("dob"),
                rs.getString("gender"),
                rs.getString("role"),
                rs.getString("profile_photo")
            );
        }
        return null;
    }
	
    
	public List<Employee> getEmployees() throws SQLException  {
	    List<Employee> employees = new ArrayList<>();
	
	    Connection conn = DBConnection.getConnection();
	    
	    String sql = "SELECT * FROM employee";
	    PreparedStatement ps = conn.prepareStatement(sql);

	    ResultSet rs = ps.executeQuery();
	
	    while (rs.next()) {

	    	int empId = rs.getInt("emp_id");
	    	String name = rs.getString("name");
	        String email = rs.getString("email");
	        String phone = rs.getString("phone");
	        String department = rs.getString("department");
	        Date dob = rs.getDate("dob");
	        String gender = rs.getString("gender");
	        String role = rs.getString("role");
	        String profilePhoto = rs.getString("profile_photo");

	        Employee employee = new Employee(empId, name, email, phone, department, dob, gender, role, profilePhoto);
	        employees.add(employee);
	    }
	    return employees;
	}
    
}
