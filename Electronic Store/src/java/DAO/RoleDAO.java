/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;


import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Role;

/**
 *
 * @author ADM
 */
public class RoleDAO extends DBContext {
    public List<Role> getAllRole() throws SQLException {
        List<Role> listofRole = new ArrayList<>();
        String sql = """
                    select * from Roles
                     """;
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            Role ro = new Role(rs.getInt("RoleID"),
                    rs.getString("RoleName"),
                    rs.getString("Description")
                    );
            listofRole.add(ro);
        }
        return listofRole;
    }
    // Lấy Role theo ID
    public Role getRoleByID(int roleID) throws SQLException {
        String sql = "SELECT * FROM Roles WHERE RoleID = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, roleID);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return new Role(
                    rs.getInt("RoleID"),
                    rs.getString("RoleName"),
                    rs.getString("Description")
            );
        }
        return null;
    }
    public boolean isAdmin(int roleID) throws SQLException {
        Role r = getRoleByID(roleID);
        if (r != null) {
            return "Admin".equalsIgnoreCase(r.getRoleName());
        }
        return false;
    }
    public boolean isUser(int roleID) throws SQLException {
        Role r = getRoleByID(roleID);
        if (r != null) {
            return "User".equalsIgnoreCase(r.getRoleName());
        }
        return false;
    }
}
