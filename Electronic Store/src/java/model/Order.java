/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DPP
 */
public class Order {
    
    int OrderID;
    String FullName;
    String OrderDate;
    String TotalAmount;
    String Status;

    public Order(int OrderID, String FullName, String OrderDate, String TotalAmount, String Status) {
        this.OrderID = OrderID;
        this.FullName = FullName;
        this.OrderDate = OrderDate;
        this.TotalAmount = TotalAmount;
        this.Status = Status;
    }

    public int getOrderID() {
        return OrderID;
    }

    public String getFullName() {
        return FullName;
    }

    public String getOrderDate() {
        return OrderDate;
    }

    public String getTotalAmount() {
        return TotalAmount;
    }

    public String getStatus() {
        return Status;
    }
    


   
    
}
