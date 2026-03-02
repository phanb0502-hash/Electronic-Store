/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author ADM
 */
public class Shipping {
    private int shippingID;
    private int orderID;
    private String shippingAddress;
    private String location;
    private java.sql.Timestamp shippingDate;
    private java.sql.Timestamp deliveryDate;
    private String shippingMethod;
    private String shippingStatus;
    private double shippingFee;

    public Shipping() {
    }

    public Shipping(int shippingID, int orderID, String shippingAddress, String location,
                    java.sql.Timestamp shippingDate, java.sql.Timestamp deliveryDate,
                    String shippingMethod, String shippingStatus, double shippingFee) {
        this.shippingID = shippingID;
        this.orderID = orderID;
        this.shippingAddress = shippingAddress;
        this.location = location;
        this.shippingDate = shippingDate;
        this.deliveryDate = deliveryDate;
        this.shippingMethod = shippingMethod;
        this.shippingStatus = shippingStatus;
        this.shippingFee = shippingFee;
    }

    public int getShippingID() {
        return shippingID;
    }

    public int getOrderID() {
        return orderID;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public String getLocation() {
        return location;
    }

    public Timestamp getShippingDate() {
        return shippingDate;
    }

    public Timestamp getDeliveryDate() {
        return deliveryDate;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }

    public String getShippingStatus() {
        return shippingStatus;
    }

    public double getShippingFee() {
        return shippingFee;
    }

}
