package Controller.Booking.Customer;

import DAL.Booking.DAOBooking;
import DAL.Guest.DAOGuest;
import Model.Room;
import Model.RoomType;
import Model.User;
import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CustomerBookingController", urlPatterns = {"/booking", "/booking_confirm", "/my_booking"})
public class BookingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/booking" -> {
                HttpSession session = request.getSession();
                User currentUser = (User) session.getAttribute("currentUser");

                if (currentUser == null) {
                    String queryString = request.getQueryString();
                    String redirectUrl = "booking";
                    if (queryString != null) {
                        redirectUrl += "?" + queryString;
                    }
                    response.sendRedirect(request.getContextPath() + "/login?redirect="
                            + java.net.URLEncoder.encode(redirectUrl, "UTF-8"));
                    return;
                }

                // Đã đăng nhập -> lấy thông tin phòng
                String roomIdParam = request.getParameter("roomId");
                if (roomIdParam == null || roomIdParam.isBlank()) {
                    response.sendRedirect("rooms");
                    return;
                }

                try {
                    int roomId = Integer.parseInt(roomIdParam);
                    Map.Entry<Room, RoomType> entry = DAOGuest.INSTANCE.getRoomDetailWithType(roomId);
                    if (entry == null) {
                        response.sendRedirect("rooms");
                        return;
                    }
                    request.setAttribute("room", entry.getKey());
                    request.setAttribute("roomType", entry.getValue());
                    request.getRequestDispatcher("Views/Booking/Customer/Booking.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect("rooms");
                }
            }

            case "/booking_confirm" ->
                request.getRequestDispatcher("Views/Booking/Customer/BookingConfirm.jsp").forward(request, response);

            case "/my_booking" ->
                request.getRequestDispatcher("Views/Booking/Customer/MyBooking.jsp").forward(request, response);

            default ->
                response.sendError(404);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get form parameters
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String checkinDateStr = request.getParameter("checkinDate");
            String checkoutDateStr = request.getParameter("checkoutDate");
            int numGuests = Integer.parseInt(request.getParameter("numGuests"));

            // Parse dates
            java.time.LocalDate checkinDate = java.time.LocalDate.parse(checkinDateStr);
            java.time.LocalDate checkoutDate = java.time.LocalDate.parse(checkoutDateStr);

            // Validate dates
            if (!checkoutDate.isAfter(checkinDate)) {
                request.setAttribute("type", "error");
                request.setAttribute("mess", "Check-out date must be after check-in date!");
                request.getRequestDispatcher("Views/Booking/Customer/Booking.jsp").forward(request, response);
                return;
            }

            // Get room details to calculate total amount
            Map.Entry<Room, RoomType> entry = DAOGuest.INSTANCE.getRoomDetailWithType(roomId);
            if (entry == null) {
                response.sendRedirect("rooms");
                return;
            }

            RoomType roomType = entry.getValue();
            long nights = java.time.temporal.ChronoUnit.DAYS.between(checkinDate, checkoutDate);
            java.math.BigDecimal totalAmount = roomType.getBasePrice().multiply(java.math.BigDecimal.valueOf(nights));

            // Create booking object
            Model.Booking booking = new Model.Booking();
            booking.setCustomerId(currentUser.getUserId());
            booking.setRoomId(roomId);
            booking.setCheckinDate(checkinDate);
            booking.setCheckoutDate(checkoutDate);
            booking.setNumGuests(numGuests);
            booking.setStatus(Model.Booking.Status.PENDING);
            booking.setTotalAmount(totalAmount);
            booking.setCreatedBy(currentUser.getUserId());

            // Save to database
            boolean success = DAOBooking.INSTANCE.createBooking(booking);

            if (success) {
                request.setAttribute("type", "success");
                request.setAttribute("mess", "Booking successful! Your reservation has been created.");
                request.setAttribute("href", "my_booking");
                request.getRequestDispatcher("Views/Booking/Customer/Booking.jsp").forward(request, response);
            } else {
                request.setAttribute("type", "error");
                request.setAttribute("mess", "Failed to create booking. Please try again.");
                request.getRequestDispatcher("Views/Booking/Customer/Booking.jsp").forward(request, response);
            }

        } catch (NumberFormatException | java.time.DateTimeException e) {
            request.setAttribute("type", "error");
            request.setAttribute("mess", "Failed to create booking. Please try again.");
            request.getRequestDispatcher("Views/Booking/Customer/Booking.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("type", "error");
            request.setAttribute("mess", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("Views/Booking/Customer/Booking.jsp").forward(request, response);
        }
    }

}
