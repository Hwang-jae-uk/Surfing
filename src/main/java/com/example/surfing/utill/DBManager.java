package com.example.surfing.utill;

import java.sql.*;

public class DBManager {
    // DB 접속정보 설정
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection conn = null;

        // DB접속 정보
//        String url = "jdbc:mysql://10.100.105.24:3306/jspgit";
        String url = "jdbc:mysql://localhost:3306/surfingjsp";
        String user = "root";
        String password = "1234";

        // JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");

        // DB에 연결
        try {
            conn = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    // 연결 해제(자원 반납)
    // select를 수행한 후 리소스 해제를 위한 메서드
    // executeQuery() - ResultSet
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try {
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // insert, update, delete를 수행한 후 리소스 해제를 위한 메서드
    // executeUpdate() - int
    public static void close(Connection conn, Statement stmt) {
        try {
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}