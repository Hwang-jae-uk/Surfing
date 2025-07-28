package com.example.surfing.dao;

import com.example.surfing.dto.RegionDTO;
import com.example.surfing.utill.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RegionDAO {

    public List<RegionDTO> getRegion() {
        String sql = "select * from region";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        List<RegionDTO> list = new ArrayList<RegionDTO>();

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RegionDTO dto = new RegionDTO();
                dto.setName(rs.getString("name"));
                list.add(dto);
            }


        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            DBManager.close(conn, pstmt, rs);
        }

        return list;
    }
    public List<RegionDTO> getRegionByType(String type) {
        String sql = "select * from region where type like ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<RegionDTO> list = new ArrayList<>();
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + type + "%");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                RegionDTO dto = new RegionDTO();
                dto.setId(rs.getLong("region_id"));
                dto.setName(rs.getString("name"));
                dto.setType(rs.getString("type"));
                list.add(dto);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            DBManager.close(conn, pstmt, rs);
        }
        return list;
    }

}
