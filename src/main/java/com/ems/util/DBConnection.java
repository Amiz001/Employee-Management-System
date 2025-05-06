package com.ems.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "@emmawatson");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
