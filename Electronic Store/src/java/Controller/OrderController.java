package Controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import DAO.OrderDAO;
import model.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartItem;
import model.Product;
import model.User;

/**
 *
 * @author DPP
 */
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Order> list = new DAO.OrderDAO().getAll();
            HttpSession ses = request.getSession();
            ses.setAttribute("listoforder", list);
            request.getRequestDispatcher("OrderList.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (cart == null || cart.isEmpty()) {
            out.println("<h2>Giỏ hàng trống!</h2>");
            out.println("<a href='show.jsp'>Quay lại mua hàng</a>");
            return;
        }

        try {
            // Lấy user từ session
            User user = (User) session.getAttribute("user");
            if (user == null) {
                out.println("<h2>Bạn chưa đăng nhập!</h2>");
                out.println("<a href='login.jsp'>Đăng nhập</a>");
                return;
            }

            int userId = user.getUserID();
            OrderDAO orderDAO = new OrderDAO();

            // Tính tổng tiền
            double totalAmount = 0;
            for (CartItem item : cart) {
                totalAmount += item.getTotalPrice();
            }

            // 1️⃣ Tạo đơn hàng và lấy orderID kiểu int
            int orderId = orderDAO.createOrder(userId, totalAmount, "Pending"); // truyền double trực tiếp

            // 2️⃣ Lưu chi tiết đơn hàng
            for (CartItem item : cart) {
                orderDAO.addOrderDetail(orderId, item.getProduct().getProductID(),
                        item.getQuantity(), item.getProduct().getPrice());
            }

            // 3️⃣ Xóa giỏ hàng
            session.removeAttribute("cart");

            // 4️⃣ Hiển thị thông báo thành công
            out.println("<h2>Đặt hàng thành công! 🎉</h2>");
            out.println("<a href='show.jsp'>Quay lại mua hàng</a>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h2>Đặt hàng thất bại!</h2>");
            out.println("<a href='Cart.jsp'>Quay lại giỏ hàng</a>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
