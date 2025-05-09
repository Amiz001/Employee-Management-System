package com.ems.model;

import java.sql.Date;

public class Taskmanagement {
    private int task_id;
    private String title;
    private int emp_id;
    private Date deadline;
    private Date start_date;
    private String status;

    public Taskmanagement(int task_id, String title, int emp_id, Date deadline, Date start_date, String status) {
        this.task_id = task_id;
        this.title = title;
        this.emp_id = emp_id;
        this.deadline = deadline;
        this.start_date = start_date;
        this.status = status;
    }

	public int getTask_id() {
		return task_id;
	}

	public void setTask_id(int task_id) {
		this.task_id = task_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(int emp_id) {
		this.emp_id = emp_id;
	}

	public Date getDeadline() {
		return deadline;
	}

	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

    
}