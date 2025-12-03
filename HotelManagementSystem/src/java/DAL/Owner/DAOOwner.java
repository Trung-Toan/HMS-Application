package DAL.Owner;

import DAL.DBContext;
import Model.User;
import Model.StaffAssignment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOOwner extends DBContext {
    
    public static final DAOOwner INSTANCE = new DAOOwner();
    
    private DAOOwner() {
    }
    
    // ==========================================
    // DASHBOARD METRICS
    // ==========================================
    
    public int getTotalRooms() {
        String sql = "SELECT COUNT(*) FROM rooms";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOwner.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int getOccupiedRooms() {
        // Assuming 'OCCUPIED' is a status or checking bookings
        // For simplicity, let's count rooms with status 'OCCUPIED' if that exists, 
        // or join with active bookings. 
        // Based on previous context, Room status might be AVAILABLE, DIRTY, CLEANING, MAINTENANCE.
        // Let's assume we check bookings for today.
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'CHECKED_IN'";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOwner.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public double getTodayRevenue() {
        // Mock implementation or real query if payment table exists
        // SELECT SUM(amount) FROM payments WHERE payment_date = CURRENT_DATE
        return 0.0; 
    }

    // ==========================================
    // EMPLOYEE MANAGEMENT
    // ==========================================
    
    public List<User> getAllEmployees() {
        List<User> list = new ArrayList<>();
        // Assuming Role ID 1=Admin, 2=Receptionist, 3=Housekeeping, 4=Owner
        // We want to list employees (Receptionist, Housekeeping)
        String sql = "SELECT * FROM users WHERE role_id IN (2, 3)";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setRoleId(rs.getInt("role_id"));
                u.setActive(rs.getBoolean("is_active"));
                // Dates can be handled if needed
                list.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOwner.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public User getEmployeeById(int id) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setRoleId(rs.getInt("role_id"));
                    u.setActive(rs.getBoolean("is_active"));
                    return u;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOwner.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public boolean createEmployee(User user, String plainPassword) {
        // Using stored procedure or raw insert
        // Assuming we use raw insert for now as sp_create_user might not exist or we don't know it
        String sql = "INSERT INTO users (username, password_hash, full_name, email, phone, role_id, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            // Hash password here or in controller. Let's assume controller/model handles hashing
            // But wait, User model has setPlainPassword which hashes it.
            // If we receive a User object with passwordHash already set:
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setInt(6, user.getRoleId());
            ps.setBoolean(7, true);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DAOOwner.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean updateEmployee(User user) {
        String sql = "UPDATE users SET full_name=?, email=?, phone=?, role_id=?, is_active=? WHERE user_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setInt(4, user.getRoleId());
            ps.setBoolean(5, user.getActive());
            ps.setInt(6, user.getUserId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DAOOwner.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean toggleEmployeeStatus(int userId, boolean isActive) {
        String sql = "UPDATE users SET is_active=? WHERE user_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, isActive);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DAOOwner.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // ==========================================
    // JOB ASSIGNMENT
    // ==========================================
    
    // ... Implement assignment methods later or reuse DAOHousekeeping for tasks
    // For StaffAssignment (shifts):
    
    public List<StaffAssignment> getAssignmentsByDate(java.sql.Date date) {
        // Mock or implement if table exists
        return new ArrayList<>();
    }
}
