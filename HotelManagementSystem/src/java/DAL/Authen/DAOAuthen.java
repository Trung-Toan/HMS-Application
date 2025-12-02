/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL.Authen;

import DAL.DAO;
import Model.User;
import java.sql.*;

/**
 *
 * @author PC
 */
public class DAOAuthen extends DAO {

    public static DAOAuthen INSTANCE = new DAOAuthen();

    private DAOAuthen() {
    }

    //create new customer
    public int registerCustomer(User u) {
        int n = 0;
        String sql = "INSERT INTO users (username, password_hash, full_name, email, phone, role_id, is_active) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPasswordHash());
            ps.setString(3, u.getFullName());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPhone());
            ps.setInt(6, u.getRoleId());
            ps.setBoolean(7, u.getActive());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("User created successfully!");
            } else {
                System.out.println("User creation failed!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
}
