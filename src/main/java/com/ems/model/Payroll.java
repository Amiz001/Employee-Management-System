package com.ems.model;

import java.sql.Date;

public class Payroll {
	
	private int pay_id;
	private int emp_id;
	private double basic;
	private double ot;
	private double allowance;
	private double total_salary;
	private Date created_date;
	
	 public Payroll() {}
	
	public Payroll(int pay_id, int emp_id, double basic, double ot, double allowance, double total_salary, Date created_date) {
		super();
		this.pay_id = pay_id;
		this.emp_id = emp_id;
		this.basic = basic;
		this.ot = ot;
		this.allowance = allowance;
		this.total_salary = total_salary;
		this.created_date = created_date;
	}

	public int getPay_id() {
		return pay_id;
	}

	public void setPay_id(int pay_id) {
		this.pay_id = pay_id;
	}

	public int getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(int emp_id) {
		this.emp_id = emp_id;
	}

	public double getBasic() {
		return basic;
	}

	public void setBasic(double basic) {
		this.basic = basic;
	}

	public double getOt() {
		return ot;
	}

	public void setOt(double ot) {
		this.ot = ot;
	}

	public double getAllowance() {
		return allowance;
	}

	public void setAllowance(double allowance) {
		this.allowance = allowance;
	}

	public double getTotal_salary() {
		return total_salary;
	}

	public void setTotal_salary(double total_salary) {
		this.total_salary = total_salary;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}


}
