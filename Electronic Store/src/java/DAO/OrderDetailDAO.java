/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import model.OrderDetail;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DPP
 */
public class OrderDetailDAO extends DBContext{
    public List<OrderDetail> getByOrderID (String subID) throws SQLException{
        List<OrderDetail> listofdetail = new ArrayList<>();
        String sql = """
                   SELECT 
                       p.ProductName, 
                       d.Quantity, 
                       d.Price, 
                       d.Quantity * d.Price AS SubTotal
                   FROM OrderDetails d
                   JOIN Products p ON d.ProductID = p.ProductID
                   WHERE d.OrderID = ?;
                   """;
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, subID);
        
        ResultSet rs = stm.executeQuery();
        while(rs.next()){
            OrderDetail od = new OrderDetail(rs.getString("ProductName"),
                    rs.getString("Quantity"),
                    rs.getString("Price"),
                    rs.getString("SubTotal"))
                    ;
            listofdetail.add(od);
        }
        
        return listofdetail;
    } 
}

