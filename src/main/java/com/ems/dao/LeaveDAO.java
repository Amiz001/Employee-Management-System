package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Leave;
import com.ems.util.DBConnection;

public class LeaveDAO {
	
	public boolean insertLeave(Leave leave) throws SQLException {
		
		Connection conn = DBConnection.getConnection();
		
		String sql = "INSERT INTO leave_request (emp_id, leave_type, start_date, end_date, reason) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, leave.getEmpId());
        ps.setString(2, leave.getLeaveType());
        ps.setDate(3, leave.getStartDate());
        ps.setDate(4, leave.getEndDate());
        ps.setString(5, leave.getReason());
        
        return ps.executeUpdate() > 0;
    }

	
    public boolean updateLeave(Leave leave) throws SQLException {
    	
        Connection conn = DBConnection.getConnection();
        
        String sql = "UPDATE leave_request SET leave_type=?, start_date=?, end_date=?, reason=? WHERE leave_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setString(1, leave.getLeaveType());
        ps.setDate(2, leave.getStartDate());
        ps.setDate(3, leave.getEndDate());
        ps.setString(4, leave.getReason());
        ps.setInt(5, leave.getLeaveId());
        
        return ps.executeUpdate() > 0;
    }

    
    public boolean deleteLeave(int leaveId) throws SQLException {
    	
        Connection conn = DBConnection.getConnection();
        
        String sql = "DELETE FROM leave_request WHERE leave_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, leaveId);
        return ps.executeUpdate() > 0;
    }

    
    public Leave getLeaveById(int leaveId) throws SQLException {
    	
    	Connection conn = DBConnection.getConnection();
    	
    	String sql = "SELECT * FROM leave_request WHERE leave_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, leaveId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
        	
            return new Leave(
                rs.getInt("leave_id"),
                rs.getInt("leave_count"),
                rs.getInt("emp_id"),
                rs.getString("leave_type"),
                rs.getDate("start_date"),
                rs.getDate("end_date"),
                rs.getInt("total_days"),
                rs.getString("reason"),
                rs.getString("status")
            );
        }
        return null;
    }
	
    
	public List<Leave> getLeaves(String email) throws SQLException  {
	    List<Leave> leaves = new ArrayList<>();
	
	    Connection conn = DBConnection.getConnection();
	    
	    String sql = "SELECT * FROM leave_request ls, employee em WHERE email=? AND ls.emp_id = em.emp_id";
	    PreparedStatement ps = conn.prepareStatement(sql);
	    
	    ps.setString(1, email);
	    ResultSet rs = ps.executeQuery();
	
	    while (rs.next()) {
	    	int leaveId = rs.getInt("leave_id");
	    	int leaveCount = rs.getInt("leave_count");
	        int empId = rs.getInt("emp_id");
	        String leaveType = rs.getString("leave_type");
	        java.sql.Date startDate = rs.getDate("start_date");
	        java.sql.Date endDate = rs.getDate("end_date");
	        int totalDays = rs.getInt("total_days");
	        String reason = rs.getString("reason");
	        String status = rs.getString("status");

	        Leave leave = new Leave(leaveId, leaveCount, empId, leaveType, startDate, endDate, totalDays, reason, status);
	        leaves.add(leave);
	    }
	    return leaves;
	}
}
