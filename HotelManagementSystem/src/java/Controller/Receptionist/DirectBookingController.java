package Controller.Receptionist;

import DAL.Receptionist.DAOReceptionist;
import Model.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for Direct Walk-in Booking
 */
@WebServlet(name = "DirectBookingController", urlPatterns = { "/receptionist/direct-booking" })
public class DirectBookingController extends HttpServlet {

    private final DAOReceptionist daoReceptionist = DAOReceptionist.INSTANCE;

    private static final int ROLE_RECEPTIONIST = 2;

    private boolean ensureReceptionist(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        // Allow receptionist (role 2) and admin/manager (role 5,6) to access
        if (currentUser.getRoleId() != ROLE_RECEPTIONIST
                && currentUser.getRoleId() != 5
                && currentUser.getRoleId() != 6) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return false;
        }
        return true;
    }

    /**
     * Handles GET requests - Display available rooms search or booking form
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!ensureReceptionist(request, response)) {
            return;
        }

        // Forward to available rooms search page
        request.getRequestDispatcher("/Views/Receptionist/DirectBooking.jsp").forward(request, response);
    }

    /**
     * Handles POST requests - Search rooms or create booking
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!ensureReceptionist(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        if ("search".equals(action)) {
            handleSearchRooms(request, response);
        } else if ("create".equals(action)) {
            handleCreateBooking(request, response);
        } else {
            request.setAttribute("type", "error");
            request.setAttribute("mess", "Invalid action");
            request.setAttribute("href", "receptionist/direct-booking");
            request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
        }
    }

    /**
     * Handle search for available rooms
     */
    private void handleSearchRooms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");

        try {
            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);

            // Validate dates
            if (checkOut.isBefore(checkIn) || checkOut.isEqual(checkIn)) {
                request.setAttribute("error", "Check-out date must be after check-in date");
                request.getRequestDispatcher("/Views/Receptionist/DirectBooking.jsp").forward(request, response);
                return;
            }

            if (checkIn.isBefore(LocalDate.now())) {
                request.setAttribute("error", "Check-in date cannot be in the past");
                request.getRequestDispatcher("/Views/Receptionist/DirectBooking.jsp").forward(request, response);
                return;
            }

            // Get available rooms
            List<Map<String, Object>> availableRooms = daoReceptionist.getAvailableRoomsForDateRange(checkIn, checkOut);

            // Calculate nights
            long nights = ChronoUnit.DAYS.between(checkIn, checkOut);

            // Add total price for each room
            for (Map<String, Object> room : availableRooms) {
                BigDecimal basePrice = (BigDecimal) room.get("basePrice");
                BigDecimal totalPrice = basePrice.multiply(BigDecimal.valueOf(nights));
                room.put("totalPrice", totalPrice);
                room.put("nights", nights);
            }

            request.setAttribute("availableRooms", availableRooms);
            request.setAttribute("checkIn", checkInStr);
            request.setAttribute("checkOut", checkOutStr);
            request.setAttribute("nights", nights);

            request.getRequestDispatcher("/Views/Receptionist/DirectBooking.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD");
            request.getRequestDispatcher("/Views/Receptionist/DirectBooking.jsp").forward(request, response);
        }
    }

    /**
     * Handle create direct booking
     */
    private void handleCreateBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();

        try {
            // Get booking parameters
            String customerName = request.getParameter("customerName");
            String customerEmail = request.getParameter("customerEmail");
            String customerPhone = request.getParameter("customerPhone");
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            String roomIdStr = request.getParameter("roomId");
            String numGuestsStr = request.getParameter("numGuests");
            String totalAmountStr = request.getParameter("totalAmount");
            String immediateCheckIn = request.getParameter("immediateCheckIn");

            // Validate required fields
            if (customerName == null || customerName.trim().isEmpty() ||
                    customerEmail == null || customerEmail.trim().isEmpty() ||
                    customerPhone == null || customerPhone.trim().isEmpty() ||
                    checkInStr == null || checkOutStr == null ||
                    roomIdStr == null || numGuestsStr == null || totalAmountStr == null) {

                request.setAttribute("type", "error");
                request.setAttribute("mess", "All fields are required");
                request.setAttribute("href", "receptionist/direct-booking");
                request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
                return;
            }

            // Parse and validate
            int roomId = Integer.parseInt(roomIdStr);
            int numGuests = Integer.parseInt(numGuestsStr);
            BigDecimal totalAmount = new BigDecimal(totalAmountStr);
            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);
            User currentUser = (User) session.getAttribute("currentUser");
            int receptionistId = currentUser.getUserId();

            // Validate dates
            if (checkOut.isBefore(checkIn) || checkOut.isEqual(checkIn)) {
                request.setAttribute("type", "error");
                request.setAttribute("mess", "Invalid date range");
                request.setAttribute("href", "receptionist/direct-booking");
                request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
                return;
            }

            // Create or get customer
            int customerId = daoReceptionist.createOrGetCustomer(
                    customerName.trim(),
                    customerEmail.trim(),
                    customerPhone.trim());

            if (customerId == -1) {
                request.setAttribute("type", "error");
                request.setAttribute("mess", "Failed to create customer record");
                request.setAttribute("href", "receptionist/direct-booking");
                request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
                return;
            }

            // Create booking
            int bookingId = daoReceptionist.createDirectBooking(
                    customerId, roomId, checkIn, checkOut, numGuests, totalAmount, receptionistId);

            if (bookingId == -1) {
                request.setAttribute("type", "error");
                request.setAttribute("mess", "Failed to create booking");
                request.setAttribute("href", "receptionist/direct-booking");
                request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
                return;
            }

            // If immediate check-in is requested and check-in date is today
            if ("on".equals(immediateCheckIn) && checkIn.isEqual(LocalDate.now())) {
                boolean checkInSuccess = daoReceptionist.checkInBooking(bookingId, receptionistId);
                if (checkInSuccess) {
                    request.setAttribute("type", "success");
                    request.setAttribute("mess", "Booking #" + bookingId + " created and checked-in successfully!");
                    request.setAttribute("href", "receptionist/checkinout");
                    request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
                } else {
                    request.setAttribute("type", "warning");
                    request.setAttribute("mess",
                            "Booking #" + bookingId + " created successfully. Check-in failed, please try manually.");
                    request.setAttribute("href", "receptionist/checkinout");
                    request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("type", "success");
                request.setAttribute("mess", "Booking #" + bookingId + " created successfully!");
                request.setAttribute("href", "receptionist/checkinout");
                request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("type", "error");
            request.setAttribute("mess", "Invalid input format");
            request.setAttribute("href", "receptionist/direct-booking");
            request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("type", "error");
            request.setAttribute("mess", "An error occurred: " + e.getMessage());
            request.setAttribute("href", "receptionist/direct-booking");
            request.getRequestDispatcher("/Views/notify.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Direct Booking Controller for Walk-in Customers";
    }
}
