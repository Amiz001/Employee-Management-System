package com.ems.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Payroll;
import com.ems.util.DBConnection;

public class PayrollDAO {
	
	        //Connect DB
			private static boolean isSuccess;
			private static Connection conn = null;
			private static Statement stmt = null;
			private static ResultSet rs = null;
				
			//Insert Data Function
			public static boolean insertdata(int emp_id, double basic, double ot, double allowance, double total_salary, Date date) {
				
				boolean isSuccess = false;
				
				try {
					//DB Connection Call
					conn = DBConnection.getConnection();
					stmt=conn.createStatement();
					
					//SQL Query
					String sql = "insert into payroll values(0,'"+emp_id+"','"+basic+"','"+ot+"','"+allowance+"','"+total_salary+"','"+date+"')";
					int rs = stmt.executeUpdate(sql);
					if(rs>0) {
						isSuccess = true;
					}
					else {
						isSuccess = false;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return isSuccess;
			}
				
				
			//GetById
			public static List<Payroll> getById (int id) {
				
				//int convertID= Integer.parseInt(pay_id);
				
				ArrayList <Payroll> payment = new ArrayList<>();
				
				try {
					//DB Connection Call
					conn = DBConnection.getConnection();
					stmt=conn.createStatement();
					
					//Query
					String sql = "select * from payroll where id = '"+id+"'";
					
					rs = stmt.executeQuery(sql);
					
					while(rs.next()) {
					    int pay_id = rs.getInt(1);
						int emp_id = rs.getInt(2);
						double basic = rs.getDouble(3);
						double ot = rs.getDouble(4);
						double allowance = rs.getDouble(5);
						double total_salary = rs.getDouble(6);
						Date date = rs.getDate(7);
						
						Payroll pay = new Payroll(pay_id,emp_id,basic,ot,allowance,total_salary,date);
						payment.add(pay);
					}
				}
				catch(Exception e) {
					e.printStackTrace();
				}
				return payment;
			}
				
			//GetAll Data
			public static List<Payroll> getAllDetails() {
				
		        ArrayList <Payroll> payments = new ArrayList<>();
				
				try {
					//DB Connection 
					conn = DBConnection.getConnection();
					stmt=conn.createStatement();
					
					//Query
					String sql = "select * from payroll";
					
					rs = stmt.executeQuery(sql);
					
					while(rs.next()) {
						int pay_id = rs.getInt(1);
						int emp_id = rs.getInt(2);
						double basic = rs.getDouble(3);
						double ot = rs.getDouble(4);
						double allowance = rs.getDouble(5);
						double total_salary = rs.getDouble(6);
						Date date = rs.getDate(7);
						
						Payroll pay = new Payroll(pay_id,emp_id,basic,ot,allowance,total_salary,date);
						payments.add(pay);
					}
				}
				catch(Exception e) {
					e.printStackTrace();
				}
				return payments;
			}
			
			//Update data
			public static boolean updatedata(int pay_id, int emp_id, double basic, double ot, double allowance, double total_salary, Date date) {
				try {
					//DB Connection 
					conn = DBConnection.getConnection();
					stmt=conn.createStatement();
					
					//SQL Query
					String sql = "update payroll set emp_id ='"+emp_id+"',basic = '"+basic+"',ot = '"+ot+"',allowance = '"+allowance+"',total_salary = '"+total_salary+"',date = '"+date+"'"+"where pay_id = '"+pay_id+"'";

					int rs = stmt.executeUpdate(sql);
					  
					if(rs>0) {
						isSuccess = true;
					}
					else {
						isSuccess = false;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return isSuccess;
			}
			
			//Delete Data
			public static boolean deletedata(int pay_id) {
				
				//int convID= Integer.parseInt(Id);
				
				try {
					//DB Connection 
					conn = DBConnection.getConnection();
					stmt=conn.createStatement();
					
					//SQL Query
					String sql = "delete from payroll where pay_id='"+pay_id+"'";

					int rs = stmt.executeUpdate(sql);
					
					if(rs>0) {
						isSuccess = true;
					}
					else {
						isSuccess = false;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return isSuccess;
			}

}
