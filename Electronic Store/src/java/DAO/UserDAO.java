/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.User;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADM
 */
public class UserDAO extends DBContext {

    public List<User> getAllUser() throws SQLException {
        List<User> listofUser = new ArrayList<>();
        String sql = """
                    select * from dbo.Users
                     """;
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            User u = new User(rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("FullName"),
                    rs.getString("Email"),
                    rs.getInt("RoleID"));
            listofUser.add(u);
        }
        return listofUser;
    }

    public User login(String username, String password) throws SQLException {
        String sql = """
                SELECT * FROM Users 
                WHERE Username = ? AND Password = ?
                """;
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, username);
        stm.setString(2, password);
        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            User u = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("FullName"),
                    rs.getString("Email"),
                    rs.getInt("RoleID")
            );
            return u;
        }
        return null;  // không tìm thấy user
    }

    public boolean checkUsernameExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Users WHERE Username = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, username);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; // true nếu trùng
        }
        return false;
    }
    public void insertUser(User u) throws SQLException {
    String sql = "INSERT INTO Users (Username, Password, FullName, Email, RoleID) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement stm = connection.prepareStatement(sql);
    stm.setString(1, u.getUsername());
    stm.setString(2, u.getPassword());
    stm.setString(3, u.getFullName());
    stm.setString(4, u.getEmail());
    stm.setInt(5, u.getRoleID()); // có thể là 1 (admin) hoặc 2 (user)
    stm.executeUpdate();
}

}
