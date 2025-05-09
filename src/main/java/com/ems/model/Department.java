package com.ems.model;

public class Department {
	private int dep_id;
	private String name;
	private int no_of_emp;
	private String phone;
	private String email;
	private String supervisor_id;
	
	
	
	public Department(int did,String name,int noOfEmp,String phone,String email,String supervisorId) {
		this.dep_id=did;
		this.name=name;
		this.no_of_emp=noOfEmp;
		this.phone=phone;
		this.email=email;
		this.supervisor_id=supervisorId;
	}


	public Department() {};
	
	public int getDep_id() {
		return dep_id;
	}


	public void setDep_id(int dep_id) {
		this.dep_id = dep_id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getNo_of_emp() {
		return no_of_emp;
	}


	public void setNo_of_emp(int no_of_emp) {
		this.no_of_emp = no_of_emp;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getSupervisor_id() {
		return supervisor_id;
	}


	public void setSupervisor_id(String supervisor_id) {
		this.supervisor_id = supervisor_id;
	}


}