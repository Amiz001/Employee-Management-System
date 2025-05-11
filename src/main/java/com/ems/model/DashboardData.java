package com.ems.model;

public class DashboardData {
	
	private int remainingLeaves;
	private int leaveCount;
	private int presentCount;
	private int absentCount;
	private int holidays;
	
	private double salary;
	private int taskCount;
	
	
	public int getRemainingLeaves() {
		return remainingLeaves;
	}
	public void setRemainingLeaves(int remainingLeaves) {
		this.remainingLeaves = remainingLeaves;
	}
	public int getLeaveCount() {
		return leaveCount;
	}
	public void setLeaveCount(int leaveCount) {
		this.leaveCount = leaveCount;
	}
	public int getPresentCount() {
		return presentCount;
	}
	public void setPresentCount(int presentCount) {
		this.presentCount = presentCount;
	}
	public int getAbsentCount() {
		return absentCount;
	}
	public void setAbsentCount(int absentCount) {
		this.absentCount = absentCount;
	}
	public int getHolidays() {
		return holidays;
	}
	public void setHolidays(int holidays) {
		this.holidays = holidays;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	public int getTaskCount() {
		return taskCount;
	}
	public void setTaskCount(int taskCount) {
		this.taskCount = taskCount;
	}
 }
