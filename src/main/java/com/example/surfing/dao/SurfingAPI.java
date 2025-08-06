package com.example.surfing.dao;


import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;



public class SurfingAPI {

    public class Body{
        public Items items;
        public int pageNo;
        public int numOfRows;
        public int totalCount;
        public String type;
    }

    public class Header{
        public String resultCode;
        public String resultMsg;
    }

    public class Item{
        public String surfPlcNm;          // 서핑 장소명
        public double lat;                // 위도
        public double lot;                // 경도
        public String predcYmd;           // 예보 날짜
        public String predcNoonSeCd;      // 예보 시간대
        public String avgWvhgt;           // 파도 평균 높이(m단위)
        public String avgWvpd;            // 파도 주기
        public String avgWspd;            // 평균 풍속
        public String avgWtem;            // 평균 수온
        public String totalIndex;         // 서핑 지수 등급
        public double lastScr;            // 서핑 지수 점수 59.36보통

        public String getSurfPlcNm() {
            return surfPlcNm;
        }

        public void setSurfPlcNm(String surfPlcNm) {
            this.surfPlcNm = surfPlcNm;
        }

        public double getLat() {
            return lat;
        }

        public void setLat(double lat) {
            this.lat = lat;
        }

        public double getLot() {
            return lot;
        }

        public void setLot(double lot) {
            this.lot = lot;
        }

        public String getPredcYmd() {
            return predcYmd;
        }

        public void setPredcYmd(String predcYmd) {
            this.predcYmd = predcYmd;
        }

        public String getPredcNoonSeCd() {
            return predcNoonSeCd;
        }

        public void setPredcNoonSeCd(String predcNoonSeCd) {
            this.predcNoonSeCd = predcNoonSeCd;
        }

        public String getAvgWvhgt() {
            return avgWvhgt;
        }

        public void setAvgWvhgt(String avgWvhgt) {
            this.avgWvhgt = avgWvhgt;
        }

        public String getAvgWvpd() {
            return avgWvpd;
        }

        public void setAvgWvpd(String avgWvpd) {
            this.avgWvpd = avgWvpd;
        }

        public String getAvgWspd() {
            return avgWspd;
        }

        public void setAvgWspd(String avgWspd) {
            this.avgWspd = avgWspd;
        }

        public String getAvgWtem() {
            return avgWtem;
        }

        public void setAvgWtem(String avgWtem) {
            this.avgWtem = avgWtem;
        }

        public String getTotalIndex() {
            return totalIndex;
        }

        public void setTotalIndex(String totalIndex) {
            this.totalIndex = totalIndex;
        }

        public double getLastScr() {
            return lastScr;
        }

        public void setLastScr(double lastScr) {
            this.lastScr = lastScr;
        }


    }

    public class Items{
        public ArrayList<Item> item;
    }

    public class Response{
        public Header header;
        public Body body;
    }

    public class Root{
        public Response response;
    }

    public List<Item> surfing() throws IOException {

        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyyMMdd");

        String currentDate = (LocalDate.now().format(dateFormat))+"00";

        StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/1192136/fcstSurfing/GetFcstSurfingApiService");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=7A%2Fkol6QOz7jdmu7b3D2DE3mAV3KtguRlCUtSzJua%2FSaDYgzopHzx4NszovzTawflMpXdGtMHY6BsxFkkmgvXw%3D%3D");
        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "="+URLEncoder.encode("json" , "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("reqDate","UTF-8") + "="+URLEncoder.encode(currentDate , "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "="+URLEncoder.encode("1" , "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "="+URLEncoder.encode("300" , "UTF-8"));

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-Type", "application/json");

        BufferedReader rd;

        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
        }
        StringBuilder sb = new StringBuilder();
        String line;

        while ((line = rd.readLine()) != null) {sb.append(line);}
        rd.close();
        conn.disconnect();

        Gson gson = new Gson();
        Root root = gson.fromJson(sb.toString(), Root.class);

        List<Item> items = root.response.body.items.item;

        return items;


    }

}
