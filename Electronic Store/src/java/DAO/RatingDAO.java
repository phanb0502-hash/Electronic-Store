/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Rating;
import java.sql.*;
/**
 *
 * @author ADM
 */
public class RatingDAO extends DBContext{
    public List<Rating> getRatingsByProductID(int productID)  {
        List<Rating> list = new ArrayList<>();
        String sql = "SELECT RatingID, ProductID, Rating, Comment FROM Ratings WHERE ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rating r = new Rating(
                    rs.getInt("RatingID"),
                    rs.getInt("ProductID"),
                    rs.getInt("Rating"),
                    rs.getString("Comment")
                );
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public void insertRating(Rating r) {
        String sql = "INSERT INTO Ratings (ProductID, Rating, Comment) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, r.getProductID());
            ps.setInt(2, r.getRating());
            ps.setString(3, r.getComment());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
