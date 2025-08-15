package com.example.surfing.dao;

import com.example.surfing.dto.UserDTO;
import com.example.surfing.utill.DBManager;
import com.example.surfing.utill.JSFunction;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class UserDAO {

    public int signupUser(UserDTO userDTO){

        String hashed = BCrypt.hashpw(userDTO.getPassword(), BCrypt.gensalt());
        userDTO.setPassword(hashed);

        String sql = "insert into user(user_name ,password,phone,email,origin_file_name ,unique_file_name) values (?,?,?,?,?,?)";

        Connection con = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try{
            con = DBManager.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,userDTO.getUserName());
            pstmt.setString(2,userDTO.getPassword());
            pstmt.setString(3,userDTO.getPhone());
            pstmt.setString(4,userDTO.getEmail());
            pstmt.setString(5,userDTO.getOriginFileName());
            pstmt.setString(6,userDTO.getUniqueFileName());
            result = pstmt.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            DBManager.close(con,pstmt);
        }

        return result;
    }

    public int loginUser(String email, String password){
        String sql = "select * from user where email=?";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;
        try{

            con = DBManager.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,email);
            rs = pstmt.executeQuery();
            if(rs.next()){
                String hashed = rs.getString("password");
                if(BCrypt.checkpw(password,hashed)){
                    result = 1;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally{
            DBManager.close(con,pstmt,rs);
        }
        return result;
    }
    public UserDTO getUserByemail(String email){
        String sql = "select * from user where email=?";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        UserDTO userDTO = new UserDTO();
        try{
            con=DBManager.getConnection();
            pstmt=con.prepareStatement(sql);
            pstmt.setString(1,email);
            rs=pstmt.executeQuery();
            if(rs.next()){
                userDTO.setUserId(rs.getInt("user_id"));
                userDTO.setUserName(rs.getString("user_name"));
                userDTO.setPassword(rs.getString("password"));
                userDTO.setPhone(rs.getString("phone"));
                userDTO.setEmail(rs.getString("email"));
                userDTO.setUniqueFileName(rs.getString("unique_file_name"));
                userDTO.setOriginFileName(rs.getString("origin_file_name"));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{
            DBManager.close(con,pstmt,rs);
        }
        return userDTO;
    }

    public UserDTO getUserById(long userId){
        String sql = "select * from user where user_id=?";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        UserDTO userDTO = new UserDTO();
        try{
            con = DBManager.getConnection();
            pstmt=con.prepareStatement(sql);
            pstmt.setLong(1,userId);
            rs=pstmt.executeQuery();
            if(rs.next()){
                userDTO.setUserId(rs.getInt("user_id"));
                userDTO.setUserName(rs.getString("user_name"));
                userDTO.setUniqueFileName(rs.getString("unique_file_name"));
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally{
            DBManager.close(con,pstmt,rs);
        }
        return userDTO;
    }


    // 해쉬드해서 알아내기
    public void updateUser(UserDTO userDTO){
//        String hashed = BCrypt.hashpw(userDTO.getPassword(), BCrypt.gensalt());
//        userDTO.setPassword(hashed);
        String sql = "update user set user_name=?,password=?,phone=?,origin_file_name=?,unique_file_name=? where email=?";
        

        Connection con = null;
        PreparedStatement pstmt = null;
        try{
            con=DBManager.getConnection();
            pstmt = con.prepareStatement(sql);

            // 비밀번호 변경 시에만 해싱
            String passwordToSave = userDTO.getPassword();
            if (passwordToSave != null && !passwordToSave.isEmpty() && !passwordToSave.startsWith("$2a$")) {
                passwordToSave = BCrypt.hashpw(passwordToSave, BCrypt.gensalt());
                userDTO.setPassword(passwordToSave);
            }

            pstmt.setString(1,userDTO.getUserName());
            pstmt.setString(2,userDTO.getPassword());
            pstmt.setString(3,userDTO.getPhone());
            pstmt.setString(4,userDTO.getOriginFileName());
            pstmt.setString(5,userDTO.getUniqueFileName());
            pstmt.setString(6,userDTO.getEmail());
            pstmt.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            DBManager.close(con,pstmt);
        }

    }

    public void deleteUserByEmail(String email) {
        String sql = "delete from user where email=?";
        Connection con = null;
        PreparedStatement pstmt = null;
        int result = 0;

        try {
            con = DBManager.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1,email);
            result = pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally{
            DBManager.close(con,pstmt);
        }


    }
}