package com.ems.model;

import java.sql.Date;

public class Employee {
	private int empId;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String department;
    private Date dob;
    private String gender;
    private String role;
    private String profilePhoto;
    

    public Employee() {}

    public Employee(int empId, String name, String email, String role, String profilePhoto) {
        this.empId = empId;
    	this.name = name;
        this.email = email;
        this.role = role;
        this.profilePhoto = profilePhoto;
    }
    
	public Employee(String name, String email, String phone, String department, Date dob, String gender, String role,
			String profilePhoto) {
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.department = department;
		this.dob = dob;
		this.gender = gender;
		this.role = role;
		this.profilePhoto = profilePhoto;
	}

	public Employee(int empId, String name, String email, String phone, String department, Date dob, String gender,
			String role, String profilePhoto) {
		super();
		this.empId = empId;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.department = department;
		this.dob = dob;
		this.gender = gender;
		this.role = role;
		this.profilePhoto = profilePhoto;
	}

	public Employee(String name, String email, String password, String phone, String department, Date dob,
			String gender, String role, String profilePhoto) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.department = department;
		this.dob = dob;
		this.gender = gender;
		this.role = role;
		this.profilePhoto = profilePhoto;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(String profilePhoto) {
		this.profilePhoto = profilePhoto;
	}
}
