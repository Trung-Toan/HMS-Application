package Controller.Owner;

import DAL.Owner.DAOOwner;
import Model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "OwnerController", urlPatterns = {
    "/owner/dashboard",
    "/owner/employees",
    "/owner/employee-create",
    "/owner/employee-detail",
    "/owner/assignments",
    "/owner/staff-status",
    "/owner/reports",
    "/owner/rooms"
})
public class OwnerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Authorization check (Role ID 4 = Owner)
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || currentUser.getRoleId() != 4) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        
        switch (path) {
            case "/owner/dashboard":
                showDashboard(request, response);
                break;
            case "/owner/employees":
                showEmployeeList(request, response);
                break;
            case "/owner/employee-create":
                request.getRequestDispatcher("/Views/Owner/CreateEmployee.jsp").forward(request, response);
                break;
            case "/owner/employee-detail":
                showEmployeeDetail(request, response);
                break;
            case "/owner/assignments":
                request.getRequestDispatcher("/Views/Owner/JobAssignment.jsp").forward(request, response);
                break;
            case "/owner/staff-status":
                request.getRequestDispatcher("/Views/Owner/StaffStatus.jsp").forward(request, response);
                break;
            case "/owner/reports":
                request.getRequestDispatcher("/Views/Owner/Reports.jsp").forward(request, response);
                break;
            case "/owner/rooms":
                request.getRequestDispatcher("/Views/Owner/RoomManagement.jsp").forward(request, response);
                break;
            default:
                response.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Authorization check
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || currentUser.getRoleId() != 4) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "createEmployee":
                handleCreateEmployee(request, response);
                break;
            case "updateEmployee":
                handleUpdateEmployee(request, response);
                break;
            case "toggleStatus":
                handleToggleStatus(request, response);
                break;
            default:
                doGet(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Fetch KPIs
        int totalRooms = DAOOwner.INSTANCE.getTotalRooms();
        int occupiedRooms = DAOOwner.INSTANCE.getOccupiedRooms();
        double revenue = DAOOwner.INSTANCE.getTodayRevenue();
        
        request.setAttribute("totalRooms", totalRooms);
        request.setAttribute("occupiedRooms", occupiedRooms);
        request.setAttribute("revenue", revenue);
        
        request.getRequestDispatcher("/Views/Owner/Dashboard.jsp").forward(request, response);
    }

    private void showEmployeeList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<User> employees = DAOOwner.INSTANCE.getAllEmployees();
        request.setAttribute("employees", employees);
        request.getRequestDispatcher("/Views/Owner/EmployeeList.jsp").forward(request, response);
    }

    private void showEmployeeDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            User employee = DAOOwner.INSTANCE.getEmployeeById(id);
            if (employee == null) {
                response.sendRedirect("employees");
                return;
            }
            request.setAttribute("employee", employee);
            request.getRequestDispatcher("/Views/Owner/EmployeeDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("employees");
        }
    }

    private void handleCreateEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        String password = request.getParameter("password");
        
        User u = new User();
        u.setUsername(username);
        u.setFullName(fullName);
        u.setEmail(email);
        u.setPhone(phone);
        u.setRoleId(roleId);
        u.setPlainPassword(password); // Hashes the password
        
        boolean success = DAOOwner.INSTANCE.createEmployee(u, password);
        if (success) {
            response.sendRedirect("employees?msg=created");
        } else {
            request.setAttribute("error", "Failed to create employee");
            request.getRequestDispatcher("/Views/Owner/CreateEmployee.jsp").forward(request, response);
        }
    }

    private void handleUpdateEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        boolean isActive = request.getParameter("isActive") != null;
        
        User u = new User();
        u.setUserId(id);
        u.setFullName(fullName);
        u.setEmail(email);
        u.setPhone(phone);
        u.setRoleId(roleId);
        u.setActive(isActive);
        
        boolean success = DAOOwner.INSTANCE.updateEmployee(u);
        if (success) {
            response.sendRedirect("employees?msg=updated");
        } else {
            response.sendRedirect("employee-detail?id=" + id + "&error=failed");
        }
    }
    
    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("userId"));
        boolean currentStatus = Boolean.parseBoolean(request.getParameter("currentStatus"));
        
        boolean success = DAOOwner.INSTANCE.toggleEmployeeStatus(id, !currentStatus);
        response.sendRedirect("employees");
    }
}
