package com.ems.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Taskmanagement;
import com.ems.util.DBConnection;

public class TaskmanagementDAO {
	
	//Connect DB
		private static boolean isSuccess;
		private static Connection conn = null;
		private static Statement stmt = null;
		private static ResultSet rs = null;
		
			
		//Insert Data Function
		public static boolean inserttask(String title, int emp_id, Date deadline, Date start_date, String status) {
			
			boolean isSuccess = false;
			
			try {
				//DB Connection Call
				conn = DBConnection.getInstance().getConnection();
				stmt=conn.createStatement();
				
				//SQL Query
				String sql = "INSERT INTO task VALUES (0,'" + title + "', " + emp_id + ", '" + deadline + "', '" + start_date + "', '" + status + "')";


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
		public static List<Taskmanagement> getById (int id) {
			
			//int convertID= Integer.parseInt(Id);
			
			ArrayList <Taskmanagement> task = new ArrayList<>();
			
			try {
				//DB Connection Call
				conn = DBConnection.getInstance().getConnection();
				stmt=conn.createStatement();
				
				//Query
				String sql = "select * from task where id = '"+id+"'";
				
				rs = stmt.executeQuery(sql);
				
				while(rs.next()) {
					int task_id = rs.getInt(1);
					String title = rs.getString(2);
					int emp_id = rs.getInt(3);
					Date deadline = rs.getDate(4);
		            Date start_date = rs.getDate(5);
		            String status = rs.getString(6);

		            Taskmanagement tasks = new Taskmanagement(task_id, title, emp_id, deadline, start_date, status);
					task.add(tasks);
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return task;
		}
			
		//GetAll Data
		public static List<Taskmanagement> getAllDetails() {
			
	        ArrayList <Taskmanagement> Tasks = new ArrayList<>();
			
			try {
				//DB Connection 
				conn = DBConnection.getInstance().getConnection();
				stmt=conn.createStatement();
				
				//Query
				String sql = "select * from task";
				
				rs = stmt.executeQuery(sql);
				
				while(rs.next()) {
					int task_id = rs.getInt(1);
					String title = rs.getString(2);
					int emp_id = rs.getInt(3);
					Date deadline = rs.getDate(4);
		            Date start_date = rs.getDate(5);
		            String status = rs.getString(6);
		            
		            Taskmanagement tasks = new Taskmanagement(task_id, title, emp_id, deadline, start_date, status);
					Tasks.add(tasks);
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			return Tasks;
		}
		
		// update data
		public static boolean updatedata(int task_id, String title, int emp_id, Date deadline, Date start_date, String status) {
		    boolean isSuccess = false;
		    try {
		    	conn = DBConnection.getInstance().getConnection();
		        stmt = conn.createStatement();

		        String sql = "UPDATE task SET title='" + title + "', emp_id=" + emp_id +
		                     ", deadline='" + deadline + "', start_date='" + start_date +
		                     "', status='" + status + "' WHERE task_id=" + task_id;

		        int rs = stmt.executeUpdate(sql);
		        if (rs > 0) {
		            isSuccess = true;
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return isSuccess;
		}

		
		
		// delete data
		public static boolean deletedata(int task_id) {
		    boolean isSuccess = false;
		    try {
		        conn = DBConnection.getInstance().getConnection();

		        stmt = conn.createStatement();

		        String sql = "DELETE FROM task WHERE task_id=" + task_id;
		        int rs = stmt.executeUpdate(sql);

		        if (rs > 0) {
		            isSuccess = true;
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return isSuccess;
		}

}
