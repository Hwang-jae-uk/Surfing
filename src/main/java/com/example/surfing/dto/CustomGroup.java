package com.example.surfing.dto;

import com.example.surfing.dao.SurfingAPI;

import java.util.List;

public class CustomGroup {
    private String address;
    private List<SurfingAPI.Item> items;


    public String getAddress() {return address;}

    public void setAddress(String address) {this.address = address;}

    public List<SurfingAPI.Item> getItems() {return items;}

    public void setItems(List<SurfingAPI.Item> items) {this.items = items;}

    public CustomGroup(String address, List<SurfingAPI.Item> items) {
        this.address = address;
        this.items = items;
    }

}
