/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Authen;

import DAL.Authen.DAOAuthen;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "AuthenController", urlPatterns = {"/login", "/register", "/forgotPassword"})
public class AuthenController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/login" ->
                request.getRequestDispatcher("Views/Authen/Login.jsp").forward(request, response);

            case "/register" ->
                request.getRequestDispatcher("Views/Authen/Register.jsp").forward(request, response);

            case "/forgotPassword" ->
                request.getRequestDispatcher("Views/Authen/ForgotPassword.jsp").forward(request, response);
            default ->
                response.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            request.setAttribute("type", "error");
            request.setAttribute("mess", "non-action require!");
            request.getRequestDispatcher("Views/Authen/Login.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "register" ->
                handleRegister(request, response);

            case "login" ->
                handleLogin(request, response);

            default ->
                response.sendError(400, "Unknown action: " + action);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            User user = new User();
            user.setUsername(username);
            user.setFullName(fullname);
            user.setEmail(email);
            user.setPhone(phone);
            user.setRoleId(1);
            user.setActive(true);
            user.setPlainPassword(password);

            int result = DAOAuthen.INSTANCE.registerCustomer(user);

            if (result > 0) {
                request.setAttribute("type", "success");
                request.setAttribute("mess", "Register successful!");
                request.setAttribute("href", "login");
            } else {
                request.setAttribute("type", "error");
                request.setAttribute("mess", "Register fail!");
                request.setAttribute("href", "");
            }
        } catch (Exception e) {
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String identifier = request.getParameter("identifier");
        String password = request.getParameter("password");

        if (identifier == null || identifier.isBlank() || password == null || password.isBlank()) {
            request.setAttribute("type", "error");
            request.setAttribute("mess", "Email/Phone and password not blank!");
            request.getRequestDispatcher("Views/Authen/Login.jsp").forward(request, response);
            return;
        }

        User user = DAOAuthen.INSTANCE.login(identifier, password);

        if (user != null) {
            // Đăng nhập thành công
            request.getSession().setAttribute("currentUser", user); // lưu user vào session
            request.setAttribute("type", "success");
            request.setAttribute("mess", "Login successful!");
            request.getRequestDispatcher("Views/Authen/Login.jsp").forward(request, response);
        } else {
            // Sai thông tin đăng nhập
            request.setAttribute("type", "error");
            request.setAttribute("mess", "Email/Phone or password incorrect!");
            request.getRequestDispatcher("Views/Authen/Login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
