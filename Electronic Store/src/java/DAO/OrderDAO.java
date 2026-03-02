/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.Order;
import java.sql.*;
import dal.DBContext;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DPP
 */
public class OrderDAO extends DBContext{
    public List<Order> getAll() throws SQLException{
        List<Order> list = new ArrayList<>();
        String sql = """
                     SELECT 
                         o.OrderID,
                         u.FullName,
                         o.OrderDate,
                         o.TotalAmount,
                         o.Status
                     FROM Orders o
                     JOIN Users u ON o.UserID = u.UserID
                     ORDER BY o.OrderDate DESC;
                     """;
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
        while(rs.next()){
            Order ord = new Order(rs.getInt("OrderID"),
                    rs.getString("FullName"),
                    rs.getString("OrderDate").substring(0, 10),
                    rs.getString("TotalAmount"),
                    rs.getString("Status"));
            
            list.add(ord);
        }
        
        return list;
    }
    
    public void updateStatus(int OrderID, String newStatus) throws SQLException {
    String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
    PreparedStatement stm = connection.prepareStatement(sql);
    stm.setString(1, newStatus);
    stm.setInt(2,OrderID);
    stm.executeUpdate();
}
   public int createOrder(int UserID, double totalAmount, String status) throws SQLException {
    String sql = "INSERT INTO Orders (UserID, OrderDate, TotalAmount, Status) VALUES (?, GETDATE(), ?, ?)";
    PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    stm.setInt(1, UserID);
    stm.setDouble(2, totalAmount);  // sửa từ setString -> setDouble
    stm.setString(3, status);
    stm.executeUpdate();

    ResultSet rs = stm.getGeneratedKeys();
    if (rs.next()) {
        return rs.getInt(1);  // Lấy OrderID vừa tạo
    }
    throw new SQLException("Không lấy được OrderID sau khi insert");
}


    public void addOrderDetail(int OrderID, int productID, int quantity, double price) throws SQLException {
        String sql = "INSERT INTO OrderDetails(OrderID, ProductID, Quantity, Price) VALUES(?, ?, ?, ?)";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, OrderID);
        stm.setInt(2, productID);
        stm.setInt(3, quantity);
        stm.setDouble(4, price);
        stm.executeUpdate();
    }
    public double getTotalRevenue() throws SQLException{
        double total = 0;
        String sql = """
                     SELECT SUM(TotalAmount) AS TotalRevenue
                     FROM Orders
                     WHERE Status = 'Completed'; 
                     """;
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
        if(rs.next()){
            total = rs.getDouble("TotalRevenue");
        }
        return total;
    }
    public int getTotalOrders() {
    int total = 0;
    String sql = "SELECT COUNT(*) AS TotalOrders FROM Orders";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            total = rs.getInt("TotalOrders");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return total;
}
    public List<Order> getCompletedOrders() {
    List<Order> list = new ArrayList<>();
    String sql = """
                 select o.OrderID, u.FullName, o.OrderDate, o.TotalAmount, o.Status from dbo.Orders o
                 join dbo.Users u on u.UserID = o.UserID
                 WHERE Status = 'Completed'
                 order by o.OrderDate desc
                 """;
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Order ord = new Order(rs.getInt("OrderID"),
                    rs.getString("Fullname"),
                    rs.getString("OrderDate").substring(0, 10),
                    rs.getString("TotalAmount"),
                    rs.getString("Status"));
            
            list.add(ord);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}


   

}
