/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author DELL
 */
public class LoadProduct extends HttpServlet {

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
            out.println("<title>Servlet LoadProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadProduct at " + request.getContextPath() + "</h1>");
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

        ProductDAO pdao = new ProductDAO();
        CategoryDAO cdao = new CategoryDAO();

        // Lấy giá trị category được chọn
        String selected = request.getParameter("selectCategory");

        // Lưu toàn bộ Category lên session (để hiển thị trong dropdown)
        HttpSession session = request.getSession();
        session.setAttribute("listOfCategories", cdao.getAll());

        // Nếu chưa chọn hoặc chọn "all"
        if (selected == null || selected.equals("all")) {
            session.setAttribute("listOfProducts", pdao.getAll());
            session.setAttribute("catId", "all");
        } else {
            // Chuyển categoryId sang số để query
            int catId = Integer.parseInt(selected);
            session.setAttribute("listOfProducts", pdao.filterByCategory(catId));

            //  Lưu lại catId dạng String để dùng trong JSP
            session.setAttribute("catId", selected);
        }
        request.getRequestDispatcher("showProducts.jsp").forward(request, response);
}

        @Override
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            doGet(request, response);
        }

        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
