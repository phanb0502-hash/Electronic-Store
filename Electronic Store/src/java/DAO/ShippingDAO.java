///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package DAO;
//
//import dal.DBContext;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//import model.Shipping;
//
///**
// *
// * @author ADM
// */
//public class ShippingDAO extends DBContext{
//    public List<Shipping> getShipAll() throws SQLException{
//        List<Shipping> listShipAll = new ArrayList<>();
//        String sql = """
//                     SELECT 
//                         s.ShippingID,
//                         s.OrderID,
//                         o.Status AS OrderStatus,
//                         s.ShippingAddress,
//                         s.Location,
//                         s.ShippingDate,
//                         s.DeliveryDate,
//                         s.ShippingMethod,
//                         s.ShippingStatus,
//                         s.ShippingFee
//                     FROM Shipping s
//                     JOIN Orders o ON s.OrderID = o.OrderID;
//                     """;
//        PreparedStatement stm = connection.prepareStatement(sql);
//        ResultSet rs = stm.executeQuery();
//        while(rs.next()){
//            Shipping sp = new Shipping(rs.getString("shippingAddress"),
//                          rs.getString(""),
//                          rs.getString(""),
//                          rs.getString(""),
//            );
//        }
//    }
//}
