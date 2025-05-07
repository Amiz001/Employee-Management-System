package com.ems.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver"); // or com.mysql.cj.jdbc.Driver if newer version
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee", "root", "2002");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
