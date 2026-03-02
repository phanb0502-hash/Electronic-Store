package Controller;


import DAO.UserDAO;
import java.sql.SQLException;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ADM
 */
public class Validation {
    public static String validateLogin(String username, String password) {
        if (username.isEmpty())
            return "Username không được để trống!";
        if (password.isEmpty())
            return "Password không được để trống!";
        if (password.length() < 3)
            return "Password phải có ít nhất 3 ký tự!";
        return null;
    }
    public static String validateRegister(String username, String password, String email, String fullname) throws SQLException{
      if (username.isEmpty())
            return "Username không được để trống!";
        if (password.isEmpty())
            return "Password không được để trống!";
        if (password.length() < 3)
            return "Password phải có ít nhất 3 ký tự!";
        if (email.isEmpty())
            return "Email không được để trống!";
        if (!isValidEmail(email))
            return "Email không đúng định dạng!";
        if (fullname.isEmpty())
            return "Họ tên không được để trống!";
        if (fullname.matches(".*\\d.*"))
            return "Họ tên không được chứa số!";

        // 🔹 Kiểm tra username có bị trùng không
        UserDAO dao = new UserDAO();
        if (dao.checkUsernameExists(username))
            return "Username đã tồn tại!";

        return null;
    }

    private static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
        return false;
    }
    // Regex kiểm tra định dạng email cơ bản
    String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    return email.matches(regex);
    }
    public static String validateQuantity(int quantity) {
        if (quantity <= 0) {
            return "Số lượng phải lớn hơn 0!";
        }
        return null; // hợp lệ
    }
}
