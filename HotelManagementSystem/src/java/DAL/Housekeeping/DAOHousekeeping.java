package DAL.Housekeeping;

import DAL.DAO;
import Model.HousekeepingTask;
import Model.HousekeepingTask.TaskStatus;
import Model.HousekeepingTask.TaskType;
import Model.Room;
import Model.StaffAssignment;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DAOHousekeeping extends DAO {

    public static final DAOHousekeeping INSTANCE = new DAOHousekeeping();

    private DAOHousekeeping() {
    }

    // Enum dùng cho báo sự cố (mapping sang bảng issue_reports)
    public enum IssueType {
        SUPPLY,
        EQUIPMENT,
        OTHER
    }

    // ======================================================
    // Dashboard: phòng cần dọn
    // ======================================================
    public List<Room> getRoomsNeedingCleaning() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE status IN ('DIRTY', 'CLEANING')";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setRoomTypeId(rs.getInt("room_type_id"));
                r.setFloor((Integer) rs.getInt("floor"));
                r.setStatus(rs.getString("status"));
                r.setImageUrl(rs.getString("image_url"));
                r.setDescription(rs.getString("description"));
                r.setActive(rs.getBoolean("is_active"));
                list.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ======================================================
    // Task list theo nhân viên + ngày + status
    // ======================================================
    public List<HousekeepingTask> getTasks(int staffId, LocalDate date, String statusStr) {
        List<HousekeepingTask> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM housekeeping_tasks WHERE assigned_to = ?"
        );
        if (date != null) {
            sql.append(" AND task_date = ?");
        }
        if (statusStr != null && !statusStr.isBlank()) {
            sql.append(" AND status = ?");
        }
        sql.append(" ORDER BY task_date, task_id");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            ps.setInt(idx++, staffId);
            if (date != null) {
                ps.setDate(idx++, Date.valueOf(date));
            }
            if (statusStr != null && !statusStr.isBlank()) {
                ps.setString(idx++, statusStr);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapTask(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<HousekeepingTask> getTasksForStaffOnDate(int staffId, LocalDate date) {
        return getTasks(staffId, date, null);
    }

    public HousekeepingTask getTaskById(int taskId) {
        String sql = "SELECT * FROM housekeeping_tasks WHERE task_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapTask(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private HousekeepingTask mapTask(ResultSet rs) throws SQLException {
        HousekeepingTask t = new HousekeepingTask();
        t.setTaskId(rs.getInt("task_id"));
        t.setRoomId(rs.getInt("room_id"));
        t.setAssignedTo(rs.getInt("assigned_to"));
        t.setTaskDate(rs.getDate("task_date").toLocalDate());

        String typeStr = rs.getString("task_type");
        try {
            t.setTaskType(TaskType.valueOf(typeStr));
        } catch (IllegalArgumentException | NullPointerException e) {
            t.setTaskType(TaskType.CLEANING);
        }

        String statusStr = rs.getString("status");
        try {
            t.setStatus(TaskStatus.valueOf(statusStr));
        } catch (IllegalArgumentException | NullPointerException e) {
            t.setStatus(TaskStatus.NEW);
        }

        t.setNote(rs.getString("note"));
        t.setCreatedBy((Integer) rs.getInt("created_by"));
        Timestamp cAt = rs.getTimestamp("created_at");
        Timestamp uAt = rs.getTimestamp("updated_at");
        if (cAt != null) t.setCreatedAt(cAt.toLocalDateTime());
        if (uAt != null) t.setUpdatedAt(uAt.toLocalDateTime());

        return t;
    }

    // ======================================================
    // Cập nhật task + đồng bộ trạng thái phòng
    // ======================================================
    public boolean updateTaskStatusAndNote(int taskId, TaskStatus newStatus, String note) {
        String selectSql = "SELECT room_id FROM housekeeping_tasks WHERE task_id = ?";
        String updateTaskSql = "UPDATE housekeeping_tasks "
                + "SET status = ?, note = ?, updated_at = NOW() "
                + "WHERE task_id = ?";
        String updateRoomSql = "UPDATE rooms SET status = ? WHERE room_id = ?";

        try {
            connection.setAutoCommit(false);

            int roomId = -1;
            try (PreparedStatement ps = connection.prepareStatement(selectSql)) {
                ps.setInt(1, taskId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        roomId = rs.getInt("room_id");
                    } else {
                        connection.rollback();
                        return false;
                    }
                }
            }

            try (PreparedStatement ps = connection.prepareStatement(updateTaskSql)) {
                ps.setString(1, newStatus.name());
                ps.setString(2, note);
                ps.setInt(3, taskId);
                ps.executeUpdate();
            }

            // Map trạng thái task -> trạng thái phòng
            Room.Status roomStatus = null;
            if (newStatus == TaskStatus.IN_PROGRESS) {
                roomStatus = Room.Status.CLEANING;
            } else if (newStatus == TaskStatus.DONE) {
                // Sau khi dọn xong, coi là AVAILABLE (Clean & Ready)
                roomStatus = Room.Status.AVAILABLE;
            }

            if (roomStatus != null) {
                try (PreparedStatement ps = connection.prepareStatement(updateRoomSql)) {
                    ps.setString(1, roomStatus.name());
                    ps.setInt(2, roomId);
                    ps.executeUpdate();
                }
            }

            connection.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    // ======================================================
    // Room
    // ======================================================
    public Room getRoomById(int roomId) {
        String sql = "SELECT * FROM rooms WHERE room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Room r = new Room();
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomNumber(rs.getString("room_number"));
                    r.setRoomTypeId(rs.getInt("room_type_id"));
                    r.setFloor((Integer) rs.getInt("floor"));
                    r.setStatus(rs.getString("status"));
                    r.setImageUrl(rs.getString("image_url"));
                    r.setDescription(rs.getString("description"));
                    r.setActive(rs.getBoolean("is_active"));
                    return r;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateRoomStatus(int roomId, Room.Status newStatus) {
        String sql = "UPDATE rooms SET status = ? WHERE room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus.name());
            ps.setInt(2, roomId);
            int n = ps.executeUpdate();
            return n > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ======================================================
    // StaffAssignment – phân ca làm việc
    // ======================================================
    public List<StaffAssignment> getAssignmentsForStaffOnDate(int staffId, LocalDate date) {
        List<StaffAssignment> list = new ArrayList<>();
        String sql = "SELECT * FROM staff_assignments WHERE employee_id = ? AND work_date = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setDate(2, Date.valueOf(date));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StaffAssignment sa = new StaffAssignment();
                    sa.setAssignmentId(rs.getInt("assignment_id"));
                    sa.setEmployeeId(rs.getInt("employee_id"));
                    sa.setWorkDate(rs.getDate("work_date").toLocalDate());
                    String shiftTypeStr = rs.getString("shift_type");
                    try {
                        sa.setShiftType(StaffAssignment.ShiftType.valueOf(shiftTypeStr));
                    } catch (IllegalArgumentException | NullPointerException e) {
                        sa.setShiftType(StaffAssignment.ShiftType.MORNING);
                    }
                    String statusStr = rs.getString("status");
                    try {
                        sa.setStatus(StaffAssignment.StaffStatus.valueOf(statusStr));
                    } catch (IllegalArgumentException | NullPointerException e) {
                        sa.setStatus(StaffAssignment.StaffStatus.ON_SHIFT);
                    }
                    Timestamp cAt = rs.getTimestamp("created_at");
                    if (cAt != null) {
                        sa.setCreatedAt(cAt.toLocalDateTime());
                    }
                    list.add(sa);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ======================================================
    // Issue Report – SUPPLY / EQUIPMENT
    // ======================================================
    public boolean createIssueReport(int roomId,
                                     int reportedBy,
                                     IssueType issueType,
                                     String description) {
        String sql = "INSERT INTO issue_reports "
                + "(room_id, booking_id, reported_by, issue_type, description, status, created_at, updated_at) "
                + "VALUES (?, NULL, ?, ?, ?, 'NEW', NOW(), NOW())";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setInt(2, reportedBy);
            ps.setString(3, issueType.name());
            ps.setString(4, description);

            int n = ps.executeUpdate();
            return n > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
