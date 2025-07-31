package com.example.surfing.dao;

import com.example.surfing.dto.UserDTO;
import com.example.surfing.utill.DBManager;
import com.example.surfing.utill.JSFunction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class UserDAO {

    public int signupUser(UserDTO userDTO){
        String sql = "insert into user(user_name ,password,phone,email) values (?,?,?,?)";

        Connection con = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try{
            con = DBManager.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,userDTO.getUsername());
            pstmt.setString(2,userDTO.getPassword());
            pstmt.setString(3,userDTO.getPhone());
            pstmt.setString(4,userDTO.getEmail());
            result = pstmt.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            DBManager.close(con,pstmt);
        }

        return result;
    }
}
