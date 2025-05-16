package com.ems.model;

import java.sql.Date;

public class Leave {
	
	private int leaveId;
	private int leaveCount;
    private int empId;
    private String leaveType;
    private java.sql.Date startDate;
    private java.sql.Date endDate;
    private int totalDays;
    private String reason;
    private String status;

    public Leave() {}
   
    public Leave(int empId, String leaveType, Date startDate, Date endDate, String reason) {
		this.empId = empId;
		this.leaveType = leaveType;
		this.startDate = startDate;
		this.endDate = endDate;
		this.reason = reason;
	}
    
    public Leave(int leaveId,int empId,String leaveType, Date startDate, Date endDate, String reason) {
    	this.leaveId= leaveId;    	
    	this.empId = empId;
		this.leaveType = leaveType;
		this.startDate = startDate;
		this.endDate = endDate;
		this.reason = reason;
    }

	public Leave(int leaveId, int leaveCount, int empId, String leaveType, java.sql.Date startDate, java.sql.Date endDate, int totalDays, String reason, String status) {
        this.leaveId = leaveId;
        this.leaveCount = leaveCount;
    	this.empId = empId;
        this.leaveType = leaveType;
        this.startDate = startDate;
        this.totalDays = totalDays;
        this.endDate = endDate;
        this.reason = reason;
        this.status = status;
    }

	public int getLeaveId() {
		return leaveId;
	}

	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public String getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}

	public java.sql.Date getStartDate() {
		return startDate;
	}

	public void setStartDate(java.sql.Date startDate) {
		this.startDate = startDate;
	}

	public java.sql.Date getEndDate() {
		return endDate;
	}

	public void setEndDate(java.sql.Date endDate) {
		this.endDate = endDate;
	}

	public int getTotalDays() {
		return totalDays;
	}

	public void setTotalDays(int totalDays) {
		this.totalDays = totalDays;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}