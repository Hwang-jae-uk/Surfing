package com.example.surfing.dao;

import com.example.surfing.dto.GroupDTO;
import com.example.surfing.utill.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class GroupDAO {

    public void insertGroup(GroupDTO groupDTO) {
        String sql = "insert into group_meeting(user_id , title , description , meeting_date , max_participants , username , `from` , `to`) values(?,?,?,?,?,?,?,?)";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try{
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setLong(1, groupDTO.getUserId());
            pstmt.setString(2, groupDTO.getTitle());
            pstmt.setString(3, groupDTO.getDescription());
            pstmt.setDate(4, Date.valueOf(groupDTO.getMeetingDate()));
            pstmt.setInt(5, groupDTO.getMaxMembers());
            pstmt.setString(6, groupDTO.getUserName());
            pstmt.setString(7,groupDTO.getFromLocation());
            pstmt.setString(8,groupDTO.getToLocation());
            int result = pstmt.executeUpdate();
            System.out.println("result : " + result);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBManager.close(conn, pstmt);
        }


    }

    public List<GroupDTO> getGroups() {
        String sql = "select * from group_meeting as g join user as u on u.user_id = g.user_id order by created_at desc";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<GroupDTO> groups = new ArrayList<GroupDTO>();

        try{

            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                GroupDTO groupDTO = new GroupDTO();
                groupDTO.setUserId(rs.getLong("user_id"));
                groupDTO.setGroupMeetingId(rs.getLong("group_meeting_id"));
                groupDTO.setPhone(rs.getString("phone"));
                groupDTO.setUserName(rs.getString("username"));
                groupDTO.setTitle(rs.getString("title"));
                groupDTO.setFromLocation(rs.getString("from"));
                groupDTO.setToLocation(rs.getString("to"));
                groupDTO.setMaxMembers(rs.getInt("max_participants"));
                groupDTO.setMeetingDate(LocalDate.parse(rs.getString("meeting_date")));
                groupDTO.setCreatedAt((rs.getTimestamp("created_at")));
                groupDTO.setDescription(rs.getString("description"));
                groups.add(groupDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            DBManager.close(conn, pstmt, rs);
        }
        return groups;
    }

    public List<GroupDTO> getGroups(int offset, int limit) {
        String sql = "select * from group_meeting as g join user as u on u.user_id = g.user_id order by created_at desc LIMIT ? OFFSET ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<GroupDTO> groups = new ArrayList<GroupDTO>();

        try{

            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                GroupDTO groupDTO = new GroupDTO();
                groupDTO.setUserId(rs.getLong("user_id"));
                groupDTO.setGroupMeetingId(rs.getLong("group_meeting_id"));
                groupDTO.setPhone(rs.getString("phone"));
                groupDTO.setUserName(rs.getString("username"));
                groupDTO.setTitle(rs.getString("title"));
                groupDTO.setFromLocation(rs.getString("from"));
                groupDTO.setToLocation(rs.getString("to"));
                groupDTO.setMaxMembers(rs.getInt("max_participants"));
                groupDTO.setMeetingDate(LocalDate.parse(rs.getString("meeting_date")));
                groupDTO.setCreatedAt((rs.getTimestamp("created_at")));
                groupDTO.setDescription(rs.getString("description"));
                groups.add(groupDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            DBManager.close(conn, pstmt, rs);
        }
        return groups;
    }

    public void deleteGroup(long groupId) {
        String sql = "delete from group_meeting where group_meeting_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, groupId);
            pstmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBManager.close(conn, pstmt);
        }

    }

    public List<GroupDTO> get5Groups() {
        String sql = "select * from group_meeting as g join user as u on u.user_id = g.user_id order by created_at desc limit 4";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<GroupDTO> groups = new ArrayList<GroupDTO>();

        try{

            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                GroupDTO groupDTO = new GroupDTO();
                groupDTO.setUserId(rs.getLong("user_id"));
                groupDTO.setGroupMeetingId(rs.getLong("group_meeting_id"));
                groupDTO.setPhone(rs.getString("phone"));
                groupDTO.setUserName(rs.getString("username"));
                groupDTO.setTitle(rs.getString("title"));
                groupDTO.setFromLocation(rs.getString("from"));
                groupDTO.setToLocation(rs.getString("to"));
                groupDTO.setMaxMembers(rs.getInt("max_participants"));
                groupDTO.setMeetingDate(LocalDate.parse(rs.getString("meeting_date")));
                groupDTO.setCreatedAt((rs.getTimestamp("created_at")));
                groupDTO.setDescription(rs.getString("description"));
                groups.add(groupDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            DBManager.close(conn, pstmt, rs);
        }
        return groups;
    }
}
