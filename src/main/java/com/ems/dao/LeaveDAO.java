package com.ems.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Leave;
import com.ems.util.DBConnection;

public class LeaveDAO {
	
	public boolean insertLeave(Leave leave, int leaveCount) throws SQLException {
		
		Connection conn = DBConnection.getInstance().getConnection();
		
		String sql = "INSERT INTO leave_request (emp_id, leave_type, start_date, end_date, reason) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, leave.getEmpId());
        ps.setString(2, leave.getLeaveType());
        ps.setDate(3, leave.getStartDate());
        ps.setDate(4, leave.getEndDate());
        ps.setString(5, leave.getReason());
        
        if( ps.executeUpdate() > 0) {
        	
        	String update_sql = "UPDATE employee SET leave_count=? WHERE emp_id=?";
        	ps = conn.prepareStatement(update_sql);
        	
        	ps.setInt(1, leaveCount);
        	ps.setInt(2, leave.getEmpId());
        	
        	return ps.executeUpdate() > 0 ;
        }
        
        return false;
    }
	
	public boolean hasOverlappingFutureLeave(int empId, Date startDate, Date endDate) throws SQLException {
<<<<<<< HEAD
	    Connection conn = DBConnection.getInstance().getConnection();
=======
		Connection conn = DBConnection.getInstance().getConnection();
>>>>>>> branch 'master' of https://github.com/Amiz001/Employee-Management-System.git
	    String sql = "SELECT COUNT(*) FROM leave_request " +
	                 "WHERE emp_id = ? " +
	                 "AND status IN ('Pending', 'Approved') " +
	                 "AND end_date >= CURRENT_DATE " +
	                 "AND (start_date <= ? AND end_date >= ?)";
	                 
	    PreparedStatement ps = conn.prepareStatement(sql);
	    ps.setInt(1, empId);
	    ps.setDate(2, endDate);
	    ps.setDate(3, startDate);

	    ResultSet rs = ps.executeQuery();
	    return rs.next() && rs.getInt(1) > 0;
	}


	
    public boolean updateLeave(Leave leave) throws SQLException {
    	
<<<<<<< HEAD
        Connection conn = DBConnection.getInstance().getConnection();
=======
    	Connection conn = DBConnection.getInstance().getConnection();
>>>>>>> branch 'master' of https://github.com/Amiz001/Employee-Management-System.git
        
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
    	
<<<<<<< HEAD
        Connection conn = DBConnection.getInstance().getConnection();
=======
    	Connection conn = DBConnection.getInstance().getConnection();
>>>>>>> branch 'master' of https://github.com/Amiz001/Employee-Management-System.git
        
        String sql = "DELETE FROM leave_request WHERE leave_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, leaveId);
        return ps.executeUpdate() > 0;
    }

    
    public Leave getLeaveById(int leaveId) throws SQLException {
    	
    	Connection conn = DBConnection.getInstance().getConnection();
    	
    	String sql = "SELECT * FROM leave_request WHERE leave_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setInt(1, leaveId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
        	
            return new Leave(
                rs.getInt("leave_id"),	
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
	
	    Connection conn = DBConnection.getInstance().getConnection();
	    
	    String sql = "SELECT * FROM leave_request ls, employee em WHERE email=? AND ls.emp_id = em.emp_id";
	    PreparedStatement ps = conn.prepareStatement(sql);
	    
	    ps.setString(1, email);
	    ResultSet rs = ps.executeQuery();
	
	    while (rs.next()) {
	    	int leaveId = rs.getInt("leave_id");
	        int empId = rs.getInt("emp_id");
	        String leaveType = rs.getString("leave_type");
	        java.sql.Date startDate = rs.getDate("start_date");
	        java.sql.Date endDate = rs.getDate("end_date");
	        int totalDays = rs.getInt("total_days");
	        String reason = rs.getString("reason");
	        String status = rs.getString("status");

	        Leave leave = new Leave(leaveId, empId, leaveType, startDate, endDate, totalDays, reason, status);
	        leaves.add(leave);
	    }
	    return leaves;
	}
	
	
	public List<Leave> getAllLeaves() throws SQLException  {
	    
		List<Leave> leaves = new ArrayList<>();
	
<<<<<<< HEAD
	    Connection conn = DBConnection.getInstance().getConnection();
=======
		Connection conn = DBConnection.getInstance().getConnection();
>>>>>>> branch 'master' of https://github.com/Amiz001/Employee-Management-System.git
	    
	    String sql = "SELECT * FROM leave_request";
	    PreparedStatement ps = conn.prepareStatement(sql);

	    ResultSet rs = ps.executeQuery();
	
	    while (rs.next()) {
	    	int leaveId = rs.getInt("leave_id");
	        int empId = rs.getInt("emp_id");
	        String leaveType = rs.getString("leave_type");
	        java.sql.Date startDate = rs.getDate("start_date");
	        java.sql.Date endDate = rs.getDate("end_date");
	        int totalDays = rs.getInt("total_days");
	        String reason = rs.getString("reason");
	        String status = rs.getString("status");

	        Leave leave = new Leave(leaveId, empId, leaveType, startDate, endDate, totalDays, reason, status);
	        leaves.add(leave);
	    }
	    return leaves;
	}
	
	public boolean updateStatus(int leaveId, String status) throws SQLException {
    	
<<<<<<< HEAD
        Connection conn = DBConnection.getInstance().getConnection();
=======
		Connection conn = DBConnection.getInstance().getConnection();
>>>>>>> branch 'master' of https://github.com/Amiz001/Employee-Management-System.git
        
        String sql = "UPDATE leave_request SET status=? WHERE leave_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setString(1, status);
        ps.setInt(2, leaveId);
        
        return ps.executeUpdate() > 0;
    }
}
