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
@WebServlet(name = "AuthenController", urlPatterns = {"/AuthenController"})
public class AuthenController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(400, "Action is required");
            return;
        }

        switch (action) {
            case "register" ->
                handleRegister(request, response);

            case "login" -> {
            }

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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
