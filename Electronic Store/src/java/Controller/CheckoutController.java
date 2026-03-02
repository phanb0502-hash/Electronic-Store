package Controller;

import DAO.OrderDAO;
import DAO.ProductDAO;
import model.Product;
import model.CartItem;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Product> list = new ProductDAO().getAll();
            request.setAttribute("list", list);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Không thể tải danh sách sản phẩm.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            session.setAttribute("message", "Giỏ hàng trống!");
            response.sendRedirect("Cart.jsp"); // hoặc showProducts.jsp
            return;
        }

        try {
            // Lấy user từ session
            User user = (User) session.getAttribute("user");
            if (user == null) {
                session.setAttribute("message", "Bạn chưa đăng nhập!");
                response.sendRedirect("login.jsp");
                return;
            }
            int userId = user.getUserID();
            OrderDAO orderDAO = new OrderDAO();

            // Tính tổng tiền
            double totalAmount = 0;
            for (CartItem item : cart) {
                totalAmount += item.getTotalPrice();
            }
            ProductDAO pdao = new ProductDAO();

            // 1️⃣ Tạo order mới và lấy orderID kiểu int
            int orderId = orderDAO.createOrder(userId, totalAmount, "Pending");

            List<String> errorList = new ArrayList<>();
            for (CartItem item : cart) {
                Product p = pdao.getProductById(item.getProduct().getProductID());
                if (item.getQuantity() > p.getQuantity()) {
                    errorList.add(p.getProductName());
                }
            }

            if (!errorList.isEmpty()) {
                session.setAttribute("message", "Các sản phẩm sau không đủ hàng: " + String.join(", ", errorList));
                response.sendRedirect("Cart.jsp"); // redirect sang cart
                return; // Dừng checkout
            }
            // 2️⃣ Thêm từng sản phẩm vào OrderDetail
            for (CartItem item : cart) {
                orderDAO.addOrderDetail(orderId, item.getProduct().getProductID(),
                        item.getQuantity(), item.getProduct().getPrice());
                pdao.updateQuantity(item.getProduct().getProductID(), item.getQuantity());
            }

            // 3️⃣ Xóa giỏ hàng trong session
            session.removeAttribute("cart");

            // 4️⃣ Hiển thị thông báo thành công
            session.setAttribute("message", "Đặt hàng thành công! ");
            response.sendRedirect("Cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Đặt hàng thất bại!");
            response.sendRedirect("Cart.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Checkout Controller";
    }
}
