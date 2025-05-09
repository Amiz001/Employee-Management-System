package com.ems.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.ems.model.Payroll;
import com.ems.util.DBConnection;

public class PayrollDAO {

    // Insert Data Function
    public static boolean insertdata(int emp_id, double basic, double ot, double allowance, double total_salary, java.sql.Date date) {
        boolean isSuccess = false;
        String sql = "INSERT INTO payroll (emp_id, basic, ot, allowance, total_salary, date) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, emp_id);
            pstmt.setDouble(2, basic);
            pstmt.setDouble(3, ot);
            pstmt.setDouble(4, allowance);
            pstmt.setDouble(5, total_salary);
            pstmt.setDate(6, date);

            int rows = pstmt.executeUpdate();
            isSuccess = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // GetById
    public static List<Payroll> getById(int id) {
        List<Payroll> payment = new ArrayList<>();
        String sql = "SELECT * FROM payroll WHERE pay_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Payroll pay = new Payroll(
                    rs.getInt("pay_id"),
                    rs.getInt("emp_id"),
                    rs.getDouble("basic"),
                    rs.getDouble("ot"),
                    rs.getDouble("allowance"),
                    rs.getDouble("total_salary"),
                    rs.getDate("date")
                );
                payment.add(pay);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return payment;
    }

    // GetAll Data
    public static List<Payroll> getAllDetails() {
        List<Payroll> payments = new ArrayList<>();
        String sql = "SELECT * FROM payroll";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Payroll pay = new Payroll(
                    rs.getInt("pay_id"),
                    rs.getInt("emp_id"),
                    rs.getDouble("basic"),
                    rs.getDouble("ot"),
                    rs.getDouble("allowance"),
                    rs.getDouble("total_salary"),
                    rs.getDate("date")
                );
                payments.add(pay);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return payments;
    }

    // Update Data
    public static boolean updatedata(int pay_id, int emp_id, double basic, double ot, double allowance, double total_salary, java.sql.Date date) {
        boolean isSuccess = false;
        String sql = "UPDATE payroll SET emp_id = ?, basic = ?, ot = ?, allowance = ?, total_salary = ?, date = ? WHERE pay_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, emp_id);
            pstmt.setDouble(2, basic);
            pstmt.setDouble(3, ot);
            pstmt.setDouble(4, allowance);
            pstmt.setDouble(5, total_salary);
            pstmt.setDate(6, date);
            pstmt.setInt(7, pay_id);

            int rows = pstmt.executeUpdate();
            isSuccess = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // Delete Data
    public static boolean deletedata(int pay_id) {
        boolean isSuccess = false;
        String sql = "DELETE FROM payroll WHERE pay_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, pay_id);
            int rows = pstmt.executeUpdate();
            isSuccess = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

}

