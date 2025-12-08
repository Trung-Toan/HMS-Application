package DAL.Receptionist;

import DAL.DAO;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DAOReceptionist extends DAO {

    public static final DAOReceptionist INSTANCE = new DAOReceptionist();

    private DAOReceptionist() {
    }

    // ======================================================
    // Get Pending Bookings
    // ======================================================
    public List<Map<String, Object>> getPendingBookings() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, b.customer_id, b.room_id, b.checkin_date, b.checkout_date, "
                + "b.num_guests, b.status, b.total_amount, b.created_at, "
                + "u.full_name as customer_name, u.email as customer_email, u.phone as customer_phone, "
                + "r.room_number, r.floor, rt.type_name, rt.base_price "
                + "FROM bookings b "
                + "JOIN users u ON b.customer_id = u.user_id "
                + "JOIN rooms r ON b.room_id = r.room_id "
                + "JOIN room_types rt ON r.room_type_id = rt.room_type_id "
                + "WHERE b.status = 'PENDING' "
                + "ORDER BY b.created_at ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("bookingId", rs.getInt("booking_id"));
                booking.put("customerId", rs.getInt("customer_id"));
                booking.put("customerName", rs.getString("customer_name"));
                booking.put("customerEmail", rs.getString("customer_email"));
                booking.put("customerPhone", rs.getString("customer_phone"));
                booking.put("roomId", rs.getInt("room_id"));
                booking.put("roomNumber", rs.getString("room_number"));
                booking.put("floor", rs.getInt("floor"));
                booking.put("typeName", rs.getString("type_name"));
                booking.put("basePrice", rs.getBigDecimal("base_price"));
                booking.put("checkinDate", rs.getDate("checkin_date").toLocalDate());
                booking.put("checkoutDate", rs.getDate("checkout_date").toLocalDate());
                booking.put("numGuests", rs.getInt("num_guests"));
                booking.put("status", rs.getString("status"));
                booking.put("totalAmount", rs.getBigDecimal("total_amount"));
                booking.put("createdAt", rs.getTimestamp("created_at").toLocalDateTime());

                list.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ======================================================
    // Get Booking with Full Details
    // ======================================================
    public Map<String, Object> getBookingWithDetails(int bookingId) {
        String sql = "SELECT b.*, "
                + "u.full_name as customer_name, u.email as customer_email, u.phone as customer_phone, "
                + "r.room_number, r.floor, r.status as room_status, "
                + "rt.type_name, rt.base_price, rt.max_occupancy, rt.description as room_description "
                + "FROM bookings b "
                + "JOIN users u ON b.customer_id = u.user_id "
                + "JOIN rooms r ON b.room_id = r.room_id "
                + "JOIN room_types rt ON r.room_type_id = rt.room_type_id "
                + "WHERE b.booking_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> result = new HashMap<>();

                    // Booking info
                    result.put("bookingId", rs.getInt("booking_id"));
                    result.put("customerId", rs.getInt("customer_id"));
                    result.put("roomId", rs.getInt("room_id"));
                    result.put("checkinDate", rs.getDate("checkin_date").toLocalDate());
                    result.put("checkoutDate", rs.getDate("checkout_date").toLocalDate());
                    result.put("numGuests", rs.getInt("num_guests"));
                    result.put("status", rs.getString("status"));
                    result.put("totalAmount", rs.getBigDecimal("total_amount"));
                    result.put("createdAt", rs.getTimestamp("created_at").toLocalDateTime());
                    Timestamp updatedAt = rs.getTimestamp("updated_at");
                    if (updatedAt != null) {
                        result.put("updatedAt", updatedAt.toLocalDateTime());
                    }

                    // Customer info
                    result.put("customerName", rs.getString("customer_name"));
                    result.put("customerEmail", rs.getString("customer_email"));
                    result.put("customerPhone", rs.getString("customer_phone"));

                    // Room info
                    result.put("roomNumber", rs.getString("room_number"));
                    result.put("floor", rs.getInt("floor"));
                    result.put("roomStatus", rs.getString("room_status"));
                    result.put("typeName", rs.getString("type_name"));
                    result.put("basePrice", rs.getBigDecimal("base_price"));
                    result.put("maxOccupancy", rs.getInt("max_occupancy"));
                    result.put("roomDescription", rs.getString("room_description"));

                    return result;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ======================================================
    // Approve Booking
    // ======================================================
    public boolean approveBooking(int bookingId, int receptionistId) {
        String sql = "UPDATE bookings SET status = 'CONFIRMED', updated_at = NOW() WHERE booking_id = ? AND status = 'PENDING'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ======================================================
    // Reject Booking
    // Note: Currently no rejection_reason column in database
    // If needed, you can add it later
    // ======================================================
    public boolean rejectBooking(int bookingId, int receptionistId, String reason) {
        String sql = "UPDATE bookings SET status = 'CANCELLED', updated_at = NOW() WHERE booking_id = ? AND status = 'PENDING'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ======================================================
    // Get All Bookings with Filters
    // ======================================================
    public List<Map<String, Object>> getAllBookingsWithFilters(
            String status, String search, LocalDate dateFrom, LocalDate dateTo,
            String sortBy, String sortOrder, int page, int pageSize) {

        List<Map<String, Object>> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT b.booking_id, b.customer_id, b.room_id, b.checkin_date, b.checkout_date, ");
        sql.append("b.num_guests, b.status, b.total_amount, b.created_at, ");
        sql.append("u.full_name as customer_name, u.email as customer_email, u.phone as customer_phone, ");
        sql.append("r.room_number, rt.type_name ");
        sql.append("FROM bookings b ");
        sql.append("JOIN users u ON b.customer_id = u.user_id ");
        sql.append("JOIN rooms r ON b.room_id = r.room_id ");
        sql.append("JOIN room_types rt ON r.room_type_id = rt.room_type_id ");
        sql.append("WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        // Filter by status
        if (status != null && !status.isBlank() && !"ALL".equalsIgnoreCase(status)) {
            sql.append("AND b.status = ? ");
            params.add(status);
        }

        // Search filter
        if (search != null && !search.isBlank()) {
            sql.append(
                    "AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ? OR CAST(b.booking_id AS CHAR) LIKE ?) ");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Date range filter
        if (dateFrom != null) {
            sql.append("AND b.checkin_date >= ? ");
            params.add(Date.valueOf(dateFrom));
        }
        if (dateTo != null) {
            sql.append("AND b.checkin_date <= ? ");
            params.add(Date.valueOf(dateTo));
        }

        // Sorting
        if (sortBy != null && !sortBy.isBlank()) {
            sql.append("ORDER BY ");
            switch (sortBy) {
                case "bookingId" -> sql.append("b.booking_id");
                case "customerName" -> sql.append("u.full_name");
                case "roomNumber" -> sql.append("r.room_number");
                case "checkinDate" -> sql.append("b.checkin_date");
                case "status" -> sql.append("b.status");
                default -> sql.append("b.created_at");
            }
            sql.append(" ").append("DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC");
        } else {
            sql.append("ORDER BY b.created_at DESC");
        }

        // Pagination
        sql.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> booking = new HashMap<>();
                    booking.put("bookingId", rs.getInt("booking_id"));
                    booking.put("customerId", rs.getInt("customer_id"));
                    booking.put("customerName", rs.getString("customer_name"));
                    booking.put("customerEmail", rs.getString("customer_email"));
                    booking.put("customerPhone", rs.getString("customer_phone"));
                    booking.put("roomId", rs.getInt("room_id"));
                    booking.put("roomNumber", rs.getString("room_number"));
                    booking.put("typeName", rs.getString("type_name"));
                    booking.put("checkinDate", rs.getDate("checkin_date").toLocalDate());
                    booking.put("checkoutDate", rs.getDate("checkout_date").toLocalDate());
                    booking.put("numGuests", rs.getInt("num_guests"));
                    booking.put("status", rs.getString("status"));
                    booking.put("totalAmount", rs.getBigDecimal("total_amount"));
                    booking.put("createdAt", rs.getTimestamp("created_at").toLocalDateTime());

                    list.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ======================================================
    // Count Bookings (for pagination)
    // ======================================================
    public int countBookings(String status, String search, LocalDate dateFrom, LocalDate dateTo) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM bookings b ");
        sql.append("JOIN users u ON b.customer_id = u.user_id ");
        sql.append("WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (status != null && !status.isBlank() && !"ALL".equalsIgnoreCase(status)) {
            sql.append("AND b.status = ? ");
            params.add(status);
        }

        if (search != null && !search.isBlank()) {
            sql.append(
                    "AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ? OR CAST(b.booking_id AS CHAR) LIKE ?) ");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (dateFrom != null) {
            sql.append("AND b.checkin_date >= ? ");
            params.add(Date.valueOf(dateFrom));
        }
        if (dateTo != null) {
            sql.append("AND b.checkin_date <= ? ");
            params.add(Date.valueOf(dateTo));
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ======================================================
    // Get Dashboard Statistics
    // ======================================================
    public Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT "
                + "SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) as pending_count, "
                + "SUM(CASE WHEN status = 'CONFIRMED' THEN 1 ELSE 0 END) as confirmed_count, "
                + "SUM(CASE WHEN status = 'CHECKED_IN' THEN 1 ELSE 0 END) as checkedin_count, "
                + "SUM(CASE WHEN checkin_date = CURDATE() AND (status = 'CONFIRMED' OR status = 'PENDING') THEN 1 ELSE 0 END) as today_arrivals "
                + "FROM bookings";

        try (PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("pending", rs.getInt("pending_count"));
                stats.put("confirmed", rs.getInt("confirmed_count"));
                stats.put("checkedIn", rs.getInt("checkedin_count"));
                stats.put("todayArrivals", rs.getInt("today_arrivals"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    // ======================================================
    // Get Today's Arrivals
    // ======================================================
    public List<Map<String, Object>> getTodayArrivals() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, b.checkin_date, b.num_guests, b.status, "
                + "u.full_name as customer_name, u.phone as customer_phone, "
                + "r.room_number, rt.type_name "
                + "FROM bookings b "
                + "JOIN users u ON b.customer_id = u.user_id "
                + "JOIN rooms r ON b.room_id = r.room_id "
                + "JOIN room_types rt ON r.room_type_id = rt.room_type_id "
                + "WHERE b.checkin_date = CURDATE() "
                + "AND (b.status = 'CONFIRMED' OR b.status = 'PENDING') "
                + "ORDER BY r.room_number";

        try (PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> arrival = new HashMap<>();
                arrival.put("bookingId", rs.getInt("booking_id"));
                arrival.put("customerName", rs.getString("customer_name"));
                arrival.put("customerPhone", rs.getString("customer_phone"));
                arrival.put("roomNumber", rs.getString("room_number"));
                arrival.put("typeName", rs.getString("type_name"));
                arrival.put("numGuests", rs.getInt("num_guests"));
                arrival.put("status", rs.getString("status"));
                arrival.put("checkinDate", rs.getDate("checkin_date").toLocalDate());

                list.add(arrival);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ======================================================
    // Get Recent Bookings
    // ======================================================
    public List<Map<String, Object>> getRecentBookings(int limit) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, b.status, b.created_at, "
                + "u.full_name as customer_name, r.room_number "
                + "FROM bookings b "
                + "JOIN users u ON b.customer_id = u.user_id "
                + "JOIN rooms r ON b.room_id = r.room_id "
                + "ORDER BY b.created_at DESC LIMIT ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> booking = new HashMap<>();
                    booking.put("bookingId", rs.getInt("booking_id"));
                    booking.put("customerName", rs.getString("customer_name"));
                    booking.put("roomNumber", rs.getString("room_number"));
                    booking.put("status", rs.getString("status"));
                    booking.put("createdAt", rs.getTimestamp("created_at").toLocalDateTime());

                    list.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
