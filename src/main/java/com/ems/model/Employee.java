package com.ems.model;

public class Employee {
	private int empId;
    private String name;
    private String email;
    private String role;
    private String profilePhoto;

    public Employee(int empId, String name, String email, String role, String profilePhoto) {
        this.empId = empId;
    	this.name = name;
        this.email = email;
        this.role = role;
        this.profilePhoto = profilePhoto;
    }

    public int getEmpId() {
		return empId;
	}
    
	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public String getRole() {
		return role;
	}

	public String getProfilePhoto() {
		return profilePhoto;
	}

   
}
