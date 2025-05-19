package com.ems.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Employee;
import com.ems.util.DBConnection;

public class EmployeeDAO {
	
    public Employee validate(String email, String password) throws Exception {
    	
        Connection conn = DBConnection.getInstance().getConnection();
        
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
		
    	Connection conn = DBConnection.getInstance().getConnection();
    										
		String sql = "INSERT INTO employee (name, email, password, phone, department, dob, gender, role, leave_count, basic_salary, profile_photo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql); 
        
        ps.setString(1, employee.getName());
        ps.setString(2, employee.getEmail());
        ps.setString(3, employee.getPassword());
        ps.setString(4, employee.getPhone());
        ps.setString(5, employee.getDepartment());
        ps.setDate(6, employee.getDob());
        ps.setString(7, employee.getGender());
        ps.setString(8, employee.getRole());
        ps.setInt(9, employee.getLeaveCount());
        ps.setDouble(10, employee.getBasicSalary());
        ps.setString(11, employee.getProfilePhoto());
        
        return ps.executeUpdate() > 0;
    }

	
    public boolean updateEmployee(Employee employee) throws SQLException {
    	
    	Connection conn = DBConnection.getInstance().getConnection();
        
        String sql = "UPDATE employee SET name=?, email=?, phone=?, role=?, department=?, dob=?, gender=?, leave_count=?, basic_salary=? WHERE emp_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setString(1, employee.getName());
        ps.setString(2, employee.getEmail());
        ps.setString(3, employee.getPhone());
        ps.setString(4, employee.getRole());
        ps.setString(5, employee.getDepartment());
        ps.setDate(6, employee.getDob());
        ps.setString(7, employee.getGender());
        ps.setInt(8, employee.getLeaveCount());
        ps.setDouble(9, employee.getBasicSalary());
        ps.setInt(10, employee.getEmpId());
        
        return ps.executeUpdate() > 0;
    }
    
    public boolean updateProfile(Employee emp) {
        String sql = "UPDATE employee SET name = ?, email = ?, phone = ?, gender = ?, dob = ? WHERE emp_id = ?";
        
        try {
            
        	Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, emp.getName());
            ps.setString(2, emp.getEmail());
            ps.setString(3, emp.getPhone());
            ps.setString(4, emp.getGender());
            ps.setDate(5, emp.getDob());
            ps.setInt(6, emp.getEmpId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    
    public boolean deleteEmployee(int empId) throws SQLException {
    	
    	Connection conn = DBConnection.getInstance().getConnection();
        
        String sql = "DELETE FROM employee WHERE emp_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, empId);
        return ps.executeUpdate() > 0;
    }
    
    public boolean updatePassword(int empId, String password) throws SQLException {
    	
    	Connection conn = DBConnection.getInstance().getConnection();
        
        String sql = "UPDATE employee SET password = ? WHERE emp_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setString(1, password);
        ps.setInt(2, empId);
        
        return ps.executeUpdate() > 0;
    }

    
    public Employee getEmployeeById(int empId) throws SQLException {
    	
    	Connection conn = DBConnection.getInstance().getConnection();
    	
    	String sql = "SELECT * FROM employee WHERE emp_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, empId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
        	
            return new Employee(
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("phone"),
                rs.getString("department"),
                rs.getDate("dob"),
                rs.getString("gender"),
                rs.getString("role"),
                rs.getInt("leave_count"),
                rs.getDouble("basic_salary"),
                rs.getString("profile_photo")
            );
        }
        return null;
    }
	
    
	public List<Employee> getEmployees() throws SQLException  {
	    List<Employee> employees = new ArrayList<>();
	
	    Connection conn = DBConnection.getInstance().getConnection();
	    
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
            int leaveCount = rs.getInt("leave_count");
            double basicSalary = rs.getDouble("basic_salary");
	        String profilePhoto = rs.getString("profile_photo");

	        Employee employee = new Employee(empId, name, email, phone, department, dob, gender, role, leaveCount, basicSalary, profilePhoto);
	        employees.add(employee);
	    }
	    return employees;
	}
	
	
	//Employee ID Validate
	public static boolean exists(int emp_id) {
		boolean found = false;
		
		try (Connection conn = DBConnection.getInstance().getConnection();) {

			String sql = "SELECT 1 FROM employee WHERE emp_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, emp_id);
			ResultSet rs = stmt.executeQuery();
			found = rs.next();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return found;
	}
}
