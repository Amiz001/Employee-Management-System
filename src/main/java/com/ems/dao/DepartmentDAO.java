package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Department;
import com.ems.util.DBConnection;

public class DepartmentDAO {

	public static List<Department> getAllDepartments() {
	    List<Department> departments = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	    	con = DBConnection.getInstance().getConnection();
	        String sql = "SELECT * FROM department";
	        ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            int dep_id = rs.getInt("dep_id");
	            String name = rs.getString("name");
	            int no_of_emp = rs.getInt("no_of_emp");
	            String phone = rs.getString("phone");
	            String email = rs.getString("email");
	            String supervisor_id = rs.getString("supervisor_id");

	            departments.add(new Department(dep_id, name, no_of_emp, phone, email, supervisor_id));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (con != null) con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return departments;
	}

    
    public static boolean insertdata(int dep_id, String name, int no_of_emp, String phone, String email, String supervisor_id) {
        boolean isSuccess = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
        	con = DBConnection.getInstance().getConnection();
            String sql = "INSERT INTO department (dep_id,name, no_of_emp, phone, email, supervisor_id) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, dep_id);
            ps.setString(2, name);
            ps.setInt(3, no_of_emp);
            ps.setString(4, phone);
            ps.setString(5, email);
            ps.setString(6, supervisor_id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return isSuccess;
    }

    
    public static boolean deleteDepartment(int dep_id) {
        boolean isSuccess = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
        	con = DBConnection.getInstance().getConnection();
            String sql = "DELETE FROM department WHERE dep_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, dep_id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return isSuccess;
    }

    public static boolean updateDepartment(int dep_id, String name, int no_of_emp, String phone, String email, String supervisor_id) {
        boolean isSuccess = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
        	con = DBConnection.getInstance().getConnection();
            String sql = "UPDATE department SET name = ?, no_of_emp = ?, phone = ?, email = ?, supervisor_id = ? WHERE dep_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setInt(2, no_of_emp);
            ps.setString(3, phone);
            ps.setString(4, email);
            ps.setString(5, supervisor_id);
            ps.setInt(6, dep_id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        
        return isSuccess;
}
}