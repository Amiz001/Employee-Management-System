package com.ems.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Attendance;
import com.ems.model.Leave;
import com.ems.util.DBConnection;

public class AttendanceDAO {
	
	public List<Attendance> getAttendances(int empid) throws SQLException  {
	    List<Attendance> attendances = new ArrayList<>();
	
	    Connection conn = DBConnection.getConnection();
	    
	    String sql = "SELECT * FROM attendance att, employee em WHERE em.emp_id=? AND att.emp_id = em.emp_id";
	    PreparedStatement ps = conn.prepareStatement(sql);
	    
	    ps.setInt(1, empid);
	    ResultSet rs = ps.executeQuery();
	
	    while (rs.next()) {
	    	int attendanceId = rs.getInt("attendance_id"); 
	        Date date = rs.getDate("date");
	        Time checkInTime = rs.getTime("check_in_time");
	        Time checkOutTime = rs.getTime("check_out_time");
	        String status = rs.getString("status");

	        Attendance attendance = new Attendance(attendanceId, date, checkInTime, checkOutTime, status);
	        attendances.add(attendance);
	    }
	    return attendances;
	}
}
