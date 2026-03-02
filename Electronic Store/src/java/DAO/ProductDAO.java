/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import java.sql.*;

/**
 *
 * @author DELL
 */
public class ProductDAO extends DBContext {

    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products where quantity>0 ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getString("Description"),
                        rs.getInt("CategoryID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> search(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE ProductName LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getString("Description"),
                        rs.getInt("CategoryID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> filterByCategory(int categoryID) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE CategoryID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getString("Description"),
                        rs.getInt("CategoryID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(Product p) {
        String sql = "INSERT INTO Products (ProductName, Price, Quantity, Description, CategoryID) VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, p.getProductName());
            ps.setDouble(2, p.getPrice());
            ps.setInt(3, p.getQuantity());
            ps.setString(4, p.getDescription());
            ps.setInt(5, p.getCategoryID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Product p) {
        String sql = "UPDATE Products SET ProductName=?, Price=?, Quantity=?, Description=?, CategoryID=? WHERE ProductID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, p.getProductName());
            ps.setDouble(2, p.getPrice());
            ps.setInt(3, p.getQuantity());
            ps.setString(4, p.getDescription());
            ps.setInt(5, p.getCategoryID());
            ps.setInt(6, p.getProductID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        // Câu lệnh xóa tuần tự theo quan hệ khóa ngoại
        String sqlDeleteRatings = """
                              DELETE r
                              FROM Ratings r
                              JOIN Products p ON r.ProductID = p.ProductID
                              JOIN Categories c ON p.CategoryID = c.CategoryID
                              WHERE p.ProductID = ?;
                              """;
        String sqlDeleteOrderDetails = """
                                   DELETE od
                                   FROM OrderDetails od
                                   JOIN Products p ON od.ProductID = p.ProductID
                                   JOIN Categories c ON p.CategoryID = c.CategoryID
                                   WHERE p.ProductID = ?;
                                   """;
        String sqlDeleteProduct = """
                              DELETE FROM Products WHERE ProductID = ?;
                              """;

        try {

            // 1️⃣ Xóa dữ liệu trong Ratings (vì tham chiếu ProductID)
            try (PreparedStatement ps1 = connection.prepareStatement(sqlDeleteRatings)) {
                ps1.setInt(1, id);
                ps1.executeUpdate();
            }

            // 2️⃣ Xóa dữ liệu trong OrderDetails (cũng tham chiếu ProductID)
            try (PreparedStatement ps2 = connection.prepareStatement(sqlDeleteOrderDetails)) {
                ps2.setInt(1, id);
                ps2.executeUpdate();
            }

            // 3️⃣ Cuối cùng xóa sản phẩm trong Products
            try (PreparedStatement ps3 = connection.prepareStatement(sqlDeleteProduct)) {
                ps3.setInt(1, id);
                ps3.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getString("Description"),
                        rs.getInt("CategoryID")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateQuantity(int productID, int quantitySold) {
        String sql = """
                     UPDATE dbo.Products
                     SET quantity = quantity - ? WHERE productID = ?
                     """;
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quantitySold);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addStock(int productID, int quantityAdded) {
        String sql = "UPDATE Products SET quantity = quantity + ? WHERE productID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quantityAdded);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean exists(int productID) {
    String sql = "SELECT COUNT(*) FROM Products WHERE productID = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, productID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
}
