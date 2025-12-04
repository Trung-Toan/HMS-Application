<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Bookings - Hotel Name</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Booking/my_booking.css">

    </head>
    <body>
        <%@ include file="../../Components/Header.jsp" %>

        <main>
            <div class="back-home">
                <a href="${pageContext.request.contextPath}/home" class="btn-back-home">← Back to Home</a>
            </div>

            <h1 class="page-title">My Bookings</h1>

            <div class="filter-section">
                <input
                    type="text"
                    id="searchInput"
                    placeholder="🔍 Search by booking ID, room name, guest name..."
                    oninput="filterBookings()"
                    class="search-input"
                    />

                <select id="statusFilter" onchange="filterBookings()">
                    <option value="all">All Statuses</option>
                    <option value="pending">⏳ Pending</option>
                    <option value="confirmed">✓ Confirmed</option>
                    <option value="checked-in">📍 Checked In</option>
                    <option value="completed">✓ Completed</option>
                    <option value="cancelled">✗ Cancelled</option>
                </select>
                <select id="dateFilter" onchange="filterBookings()">
                    <option value="all">All Time</option>
                    <option value="upcoming">Upcoming</option>
                    <option value="past">Past</option>
                </select>
            </div>

            <div class="bookings-container" id="bookingsContainer">
                <div class="booking-card" data-status="pending" data-date="upcoming">
                    <div class="booking-card-header">
                        <div>
                            <div class="booking-id">Booking ID: #BK001234</div>
                            <div style="font-size: 12px; margin-top: 5px;">Booked on: 03/12/2025</div>
                        </div>
                        <span class="booking-status status-pending">Pending</span>
                    </div>
                    <div class="booking-card-body">
                        <div class="booking-info">
                            <div class="info-box">
                                <div class="info-box-label">Room</div>
                                <div class="info-box-value">Suite Premium</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Check-in</div>
                                <div class="info-box-value">15/12/2025</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Check-out</div>
                                <div class="info-box-value">18/12/2025</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Duration</div>
                                <div class="info-box-value">3 nights</div>
                            </div>
                        </div>
                        <div class="booking-details">
                            <div class="detail-item">
                                <div class="detail-label">Guest Name</div>
                                <div class="detail-value">Nguyen Van A</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Guests</div>
                                <div class="detail-value">2 people</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Total Price</div>
                                <div class="detail-value">7.500.000 VNĐ</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Payment</div>
                                <div class="detail-value">Unpaid</div>
                            </div>
                        </div>
                    </div>
                    <div class="booking-card-footer">
                        <button class="btn btn-primary" 
                                onclick="viewDetails(this)" 
                                data-id="#BK001234"
                                data-status="pending"
                                data-name="Nguyen Van A"
                                data-room="Suite Premium"
                                data-checkin="15/12/2025"
                                data-checkout="18/12/2025"
                                data-guests="2 people"
                                data-price="7.500.000 VNĐ"
                                data-note="Quiet room requested">
                            Details
                        </button>
                        <button class="btn btn-danger" onclick="openCancelModal()">
                            Cancel Booking
                        </button>

                    </div>
                </div>

                <div class="booking-card" data-status="confirmed" data-date="upcoming">
                    <div class="booking-card-header">
                        <div>
                            <div class="booking-id">Booking ID: #BK001235</div>
                            <div style="font-size: 12px; margin-top: 5px;">Booked on: 02/12/2025</div>
                        </div>
                        <span class="booking-status status-confirmed">Confirmed</span>
                    </div>
                    <div class="booking-card-body">
                        <div class="booking-info">
                            <div class="info-box">
                                <div class="info-box-label">Room</div>
                                <div class="info-box-value">Double Room</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Check-in</div>
                                <div class="info-box-value">20/12/2025</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Check-out</div>
                                <div class="info-box-value">22/12/2025</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Duration</div>
                                <div class="info-box-value">2 nights</div>
                            </div>
                        </div>
                        <div class="booking-details">
                            <div class="detail-item">
                                <div class="detail-label">Guest Name</div>
                                <div class="detail-value">Tran Thi B</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Guests</div>
                                <div class="detail-value">2 people</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Total Price</div>
                                <div class="detail-value">4.000.000 VNĐ</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Payment</div>
                                <div class="detail-value">Paid</div>
                            </div>
                        </div>
                    </div>
                    <div class="booking-card-footer">
                        <button class="btn btn-primary"
                                onclick="viewDetails(this)"
                                data-id="#BK001235"
                                data-name="Tran Thi B"
                                data-room="Double Room"
                                data-checkin="20/12/2025"
                                data-checkout="22/12/2025"
                                data-guests="2 people"
                                data-price="4.000.000 VNĐ"
                                data-note="None"
                                data-status="confirmed">
                            Details
                        </button>
                        <button class="btn btn-secondary" 
                                onclick="openModifyModal(this)"
                                data-id="#BK001235"
                                data-checkin="2025-12-20" 
                                data-checkout="2025-12-22"
                                data-guests="2"
                                data-note="None">
                            Modify Booking
                        </button>

                        <button class="btn btn-secondary" 
                                onclick="openBookAgainModal(this)"
                                data-room="Double Room"
                                data-guests="2">
                            Book Again
                        </button>

                        <button class="btn btn-secondary" 
                                onclick="openReviewModal(this)"
                                data-id="#BK001232"
                                data-room="Luxury Room">
                            Leave Review
                        </button>
                    </div>
                </div>

                <div class="booking-card" data-status="checked-in" data-date="upcoming">
                    <div class="booking-card-header">
                        <div>
                            <div class="booking-id">Booking ID: #BK001233</div>
                            <div style="font-size: 12px; margin-top: 5px;">Booked on: 01/12/2025</div>
                        </div>
                        <span class="booking-status status-checked-in">Checked In</span>
                    </div>
                    <div class="booking-card-body">
                        <div class="booking-info">
                            <div class="info-box">
                                <div class="info-box-label">Room</div>
                                <div class="info-box-value">Deluxe Plus</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Check-in</div>
                                <div class="info-box-value">10/12/2025</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Check-out</div>
                                <div class="info-box-value">13/12/2025</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Duration</div>
                                <div class="info-box-value">3 nights</div>
                            </div>
                        </div>
                        <div class="booking-details">
                            <div class="detail-item">
                                <div class="detail-label">Guest Name</div>
                                <div class="detail-value">Le Van C</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Guests</div>
                                <div class="detail-value">3 people</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Total Price</div>
                                <div class="detail-value">6.300.000 VNĐ</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Payment</div>
                                <div class="detail-value">Paid</div>
                            </div>
                        </div>
                    </div>
                    <div class="booking-card-footer">
                        <button class="btn btn-primary" onclick="viewDetails(this)" 
                                data-id="#BK001233" 
                                data-status="checked-in"
                                data-name="Le Van C"
                                data-room="Deluxe Plus"
                                data-checkin="10/12/2025"
                                data-checkout="13/12/2025"
                                data-guests="3 people"
                                data-price="6.300.000 VNĐ">Details</button>
                        <button class="btn btn-secondary" onclick="requestService('#BK001233')">Room Service</button>
                    </div>
                </div>

                <div class="booking-card" data-status="completed" data-date="past">
                    <div class="booking-card-header">
                        <div>
                            <div class="booking-id">Booking ID: #BK001232</div>
                            <div style="font-size: 12px; margin-top: 5px;">Booked on: 25/11/2025</div>
                        </div>
                        <span class="booking-status status-completed">Completed</span>
                    </div>
                    <div class="booking-card-body">
                        <div class="booking-info">
                            <div class="info-box">
                                <div class="info-box-label">Room</div>
                                <div class="info-box-value">Luxury Room</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Check-in</div>
                                <div class="info-box-value">28/11/2025</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Check-out</div>
                                <div class="info-box-value">30/11/2025</div>
                            </div>
                            <div class="info-box">
                                <div class="info-box-label">Duration</div>
                                <div class="info-box-value">2 nights</div>
                            </div>
                        </div>
                        <div class="booking-details">
                            <div class="detail-item">
                                <div class="detail-label">Guest Name</div>
                                <div class="detail-value">Pham Thi D</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Guests</div>
                                <div class="detail-value">2 people</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Total Price</div>
                                <div class="detail-value">5.000.000 VNĐ</div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Payment</div>
                                <div class="detail-value">Paid</div>
                            </div>
                        </div>
                    </div>
                    <div class="booking-card-footer">
                        <button class="btn btn-primary" onclick="viewDetails(this)"
                                data-id="#BK001232"
                                data-status="completed"
                                data-name="Pham Thi D"
                                data-room="Luxury Room"
                                data-checkin="28/11/2025"
                                data-checkout="30/11/2025"
                                data-guests="2 people"
                                data-price="5.000.000 VNĐ">Details</button>
                        <button class="btn btn-secondary" onclick="leaveReview('#BK001232')">Leave Review</button>
                    </div>
                </div>
            </div>

            <div class="empty-state" id="emptyState" style="display: none;">
                <div class="empty-state-icon">📭</div>
                <div class="empty-state-text">
                    No matching bookings found
                </div>
                <div style="font-size:14px;">
                    Please try again with a different keyword or filter.
                </div>
            </div>


            <div class="pagination" id="pagination"></div>

            <div id="bookingDetailModal" class="modal">
                <div class="modal-content large">
                    <div class="modal-header">
                        <h2>Booking Details</h2>
                        <button class="close-btn" onclick="closeBookingDetail()">×</button>
                    </div>

                    <div class="detail-grid">
                        <div class="detail-box">
                            <span class="label">Booking ID</span>
                            <span class="value" id="modalBookingId"></span>
                        </div>
                        <div class="detail-box">
                            <span class="label">Status</span>
                            <span class="value booking-status" id="modalStatus"></span>
                        </div>
                        <div class="detail-box">
                            <span class="label">Guest Name</span>
                            <span class="value" id="modalCustomer"></span>
                        </div>
                        <div class="detail-box">
                            <span class="label">Room</span>
                            <span class="value" id="modalRoom"></span>
                        </div>
                        <div class="detail-box">
                            <span class="label">Check-in</span>
                            <span class="value" id="modalCheckIn"></span>
                        </div>
                        <div class="detail-box">
                            <span class="label">Check-out</span>
                            <span class="value" id="modalCheckOut"></span>
                        </div>
                        <div class="detail-box">
                            <span class="label">Guests</span>
                            <span class="value" id="modalGuests"></span>
                        </div>
                        <div class="detail-box">
                            <span class="label">Total Price</span>
                            <span class="value price" id="modalPrice"></span>
                        </div>
                        <div class="detail-box full">
                            <span class="label">Note</span>
                            <span class="value" id="modalNote"></span>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" onclick="closeBookingDetail()">Close</button>
                        <button class="btn btn-danger" onclick="openCancelModal()">Cancel Booking</button>
                    </div>
                </div>
            </div>

            <div id="cancelModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Cancel Booking</h2>
                        <button class="close-btn" onclick="closeCancelModal()">×</button>
                    </div>

                    <p>Are you sure you want to cancel this booking?</p>

                    <div class="form-group">
                        <label>Cancellation Reason</label>
                        <textarea id="cancelReason" rows="3"
                                  placeholder="Enter cancellation reason (optional)"></textarea>
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" onclick="closeCancelModal()">Back</button>
                        <button class="btn btn-danger" onclick="confirmCancel()">Confirm Cancellation</button>
                    </div>
                </div>
            </div>

            <div id="modifyModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Modify Booking</h2>
                        <button class="close-btn" onclick="closeModifyModal()">×</button>
                    </div>
                    <form id="modifyForm" onsubmit="event.preventDefault(); submitModify();">
                        <input type="hidden" id="modifyBookingId">

                        <div class="detail-box">
                            <span class="label">Booking ID:</span>
                            <span class="value" id="modifyIdDisplay" style="font-weight: bold;"></span>
                        </div>

                        <div class="form-group">
                            <label>New Check-in Date</label>
                            <input type="date" id="modifyCheckIn" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>New Check-out Date</label>
                            <input type="date" id="modifyCheckOut" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>Number of Guests</label>
                            <input type="number" id="modifyGuests" class="form-control" min="1" max="5" required>
                        </div>

                        <div class="form-group">
                            <label>Special Requests</label>
                            <textarea id="modifyNote" rows="2" class="form-control"></textarea>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeModifyModal()">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>

            <div id="bookAgainModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Book This Room Again</h2>
                        <button class="close-btn" onclick="closeBookAgainModal()">×</button>
                    </div>
                    <p style="margin-bottom: 15px; color: #666;">You are booking room: <strong id="rebookRoomName"></strong></p>

                    <form id="bookAgainForm" onsubmit="event.preventDefault(); submitBookAgain();">
                        <div class="form-group">
                            <label>Select Check-in Date</label>
                            <input type="date" id="rebookCheckIn" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>Select Check-out Date</label>
                            <input type="date" id="rebookCheckOut" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>Guests</label>
                            <input type="number" id="rebookGuests" class="form-control" value="2" required>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeBookAgainModal()">Close</button>
                            <button type="submit" class="btn btn-primary">Confirm New Booking</button>
                        </div>
                    </form>
                </div>
            </div>

            <div id="reviewModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Write a Review</h2>
                        <button class="close-btn" onclick="closeReviewModal()">×</button>
                    </div>

                    <div class="review-context">
                        <p>Booking ID: <strong id="reviewBookingIdDisplay"></strong></p>
                        <p>Room: <span id="reviewRoomName"></span></p>
                    </div>

                    <form id="reviewForm" onsubmit="event.preventDefault(); submitReview();">
                        <input type="hidden" id="reviewBookingId">
                        <input type="hidden" id="reviewRating" value="0">

                        <div class="form-group" style="text-align: center; margin: 20px 0;">
                            <label style="margin-bottom: 10px;">Your Rating</label>
                            <div class="star-rating">
                                <span class="star" onclick="setRating(1)" data-value="1">★</span>
                                <span class="star" onclick="setRating(2)" data-value="2">★</span>
                                <span class="star" onclick="setRating(3)" data-value="3">★</span>
                                <span class="star" onclick="setRating(4)" data-value="4">★</span>
                                <span class="star" onclick="setRating(5)" data-value="5">★</span>
                            </div>
                            <div id="ratingText" style="font-size: 14px; color: #666; margin-top: 5px;">Tap a star to rate</div>
                        </div>

                        <div class="form-group">
                            <label>Your Review</label>
                            <textarea id="reviewComment" rows="4" class="form-control" 
                                      placeholder="Share your experience with us..."></textarea>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="closeReviewModal()">Cancel</button>
                            <button type="submit" class="btn btn-primary">Submit Review</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <%@ include file="../../Components/Footer.jsp" %>

        <script>
            /* --- PAGINATION CONFIG --- */
            const ITEMS_PER_PAGE = 2;
            let currentPage = 1;

            // Variable to store current booking ID for actions (Cancel, etc.)
            let currentActionId = null;

            /* --- FILTER & PAGINATION LOGIC --- */
            function getFilteredBookings() {
                const statusFilter = document.getElementById('statusFilter').value;
                const dateFilter = document.getElementById('dateFilter').value;
                const searchKeyword = document.getElementById('searchInput').value.toLowerCase().trim();

                return Array.from(document.querySelectorAll('.booking-card')).filter(card => {
                    // Filter by status
                    if (statusFilter !== 'all' && card.dataset.status !== statusFilter)
                        return false;
                    // Filter by date
                    if (dateFilter !== 'all' && card.dataset.date !== dateFilter)
                        return false;
                    // Filter by search keyword
                    if (searchKeyword) {
                        const cardText = card.innerText.toLowerCase();
                        if (!cardText.includes(searchKeyword))
                            return false;
                    }
                    return true;
                });
            }

            function showPage(page) {
                const bookings = getFilteredBookings();
                const start = (page - 1) * ITEMS_PER_PAGE;
                const end = start + ITEMS_PER_PAGE;

                const emptyState = document.getElementById('emptyState');
                const pagination = document.getElementById('pagination');

                // Hide all first
                document.querySelectorAll('.booking-card').forEach(card => card.style.display = 'none');

                // Handle no data
                if (bookings.length === 0) {
                    emptyState.style.display = 'block';
                    pagination.style.display = 'none';
                    return;
                }

                // Show data for current page
                emptyState.style.display = 'none';
                pagination.style.display = 'flex';

                bookings.forEach((card, index) => {
                    if (index >= start && index < end) {
                        card.style.display = 'block';
                    }
                });
            }

            function renderPagination() {
                const bookings = getFilteredBookings();
                const totalPages = Math.ceil(bookings.length / ITEMS_PER_PAGE);
                const pagination = document.getElementById('pagination');
                pagination.innerHTML = '';

                if (totalPages <= 1)
                    return;

                // Prev Button
                const prevBtn = document.createElement('button');
                prevBtn.innerHTML = '«';
                prevBtn.className = 'page-btn' + (currentPage === 1 ? ' disabled' : '');
                prevBtn.onclick = () => changePage(currentPage - 1);
                pagination.appendChild(prevBtn);

                // Page Number Buttons
                for (let i = 1; i <= totalPages; i++) {
                    const btn = document.createElement('button');
                    btn.textContent = i;
                    btn.className = 'page-btn' + (i === currentPage ? ' active' : '');
                    btn.onclick = () => changePage(i);
                    pagination.appendChild(btn);
                }

                // Next Button
                const nextBtn = document.createElement('button');
                nextBtn.innerHTML = '»';
                nextBtn.className = 'page-btn' + (currentPage === totalPages ? ' disabled' : '');
                nextBtn.onclick = () => changePage(currentPage + 1);
                pagination.appendChild(nextBtn);
            }

            function changePage(page) {
                const bookings = getFilteredBookings();
                const totalPages = Math.ceil(bookings.length / ITEMS_PER_PAGE);
                if (page < 1 || page > totalPages)
                    return;
                currentPage = page;
                showPage(currentPage);
                renderPagination();
            }

            function filterBookings() {
                currentPage = 1; // Reset to page 1 when filtering
                showPage(currentPage);
                renderPagination();
            }

            // Run on load
            document.addEventListener('DOMContentLoaded', () => {
                filterBookings();
            });

            /* --- DETAILS MODAL LOGIC --- */
            function viewDetails(button) {
                // 1. Get data from clicked button (dataset)
                const data = button.dataset;

                // 2. Fill data into Modal tags
                document.getElementById('modalBookingId').innerText = data.id;
                document.getElementById('modalCustomer').innerText = data.name;
                document.getElementById('modalRoom').innerText = data.room;
                document.getElementById('modalCheckIn').innerText = data.checkin;
                document.getElementById('modalCheckOut').innerText = data.checkout;
                document.getElementById('modalGuests').innerText = data.guests;
                document.getElementById('modalPrice').innerText = data.price;
                document.getElementById('modalNote').innerText = data.note || "None";

                // 3. Handle status color
                const statusSpan = document.getElementById('modalStatus');
                statusSpan.className = `value booking-status status-${data.status}`; // Reset class

                // Map status to English (for display)
                const statusMap = {
                    'pending': 'Pending',
                    'confirmed': 'Confirmed',
                    'checked-in': 'Checked In',
                    'completed': 'Completed',
                    'cancelled': 'Cancelled'
                };
                statusSpan.innerText = statusMap[data.status] || data.status;

                // Save booking ID in case Cancel is clicked inside Detail Modal
                currentActionId = data.id;

                // 4. Show Modal
                document.getElementById('bookingDetailModal').classList.add('show');
            }

            function closeBookingDetail() {
                document.getElementById('bookingDetailModal').classList.remove('show');
            }

            /* --- CANCEL MODAL LOGIC --- */
            function openCancelModal(bookingId) {
                // If called directly from button outside list
                if (bookingId) {
                    currentActionId = bookingId;
                }
                // Close detail modal if open
                closeBookingDetail();

                // Show cancel modal
                document.getElementById('cancelModal').classList.add('show');
            }

            function closeCancelModal() {
                document.getElementById('cancelModal').classList.remove('show');
                // Reset reason
                document.getElementById('cancelReason').value = '';
            }

            function confirmCancel() {
                const reason = document.getElementById('cancelReason').value;

                if (!currentActionId) {
                    alert("Error: Booking ID not found!");
                    return;
                }

                // Call API or Submit Form to Server here
                // Simulation:
                alert(`Cancellation request sent for booking: ${currentActionId}\nReason: ${reason}`);

                closeCancelModal();
                // Reload page or update UI after success
            }

            /* --- MODIFY BOOKING LOGIC --- */
            function openModifyModal(button) {
                const data = button.dataset;

                // 1. Fill old data into form
                document.getElementById('modifyBookingId').value = data.id;
                document.getElementById('modifyIdDisplay').innerText = data.id;

                // Handle dates: Input date needs YYYY-MM-DD format
                document.getElementById('modifyCheckIn').value = formatDateForInput(data.checkin);
                document.getElementById('modifyCheckOut').value = formatDateForInput(data.checkout);

                // Fill guests count
                const guestNum = parseInt(data.guests) || 2;
                document.getElementById('modifyGuests').value = guestNum;

                document.getElementById('modifyNote').value = data.note || "";

                // 2. Open Modal
                document.getElementById('modifyModal').classList.add('show');
            }

            function closeModifyModal() {
                document.getElementById('modifyModal').classList.remove('show');
            }

            function submitModify() {
                const id = document.getElementById('modifyBookingId').value;
                const newCheckIn = document.getElementById('modifyCheckIn').value;
                const newCheckOut = document.getElementById('modifyCheckOut').value;
                const newGuests = document.getElementById('modifyGuests').value;
                const newNote = document.getElementById('modifyNote').value;

                // Basic Validation
                if (newCheckIn >= newCheckOut) {
                    alert("Check-out date must be after check-in date!");
                    return;
                }

                // Call Update API (Simulation)
                console.log("Updating booking:", {id, newCheckIn, newCheckOut, newGuests, newNote});
                alert(`Update successful for booking ${id}!\nNew dates: ${newCheckIn} to ${newCheckOut}`);

                closeModifyModal();
                // window.location.reload(); 
            }

            /* --- BOOK AGAIN LOGIC --- */
            function openBookAgainModal(button) {
                const roomName = button.dataset.room || "Default Room";
                const guests = parseInt(button.dataset.guests) || 2;

                document.getElementById('rebookRoomName').innerText = roomName;
                document.getElementById('rebookGuests').value = guests;

                // Reset dates
                document.getElementById('rebookCheckIn').value = '';
                document.getElementById('rebookCheckOut').value = '';

                document.getElementById('bookAgainModal').classList.add('show');
            }

            function closeBookAgainModal() {
                document.getElementById('bookAgainModal').classList.remove('show');
            }

            function submitBookAgain() {
                const room = document.getElementById('rebookRoomName').innerText;
                const checkIn = document.getElementById('rebookCheckIn').value;
                const checkOut = document.getElementById('rebookCheckOut').value;

                if (!checkIn || !checkOut) {
                    alert("Please select dates!");
                    return;
                }
                if (checkIn >= checkOut) {
                    alert("Check-out date must be after check-in date!");
                    return;
                }

                // Redirect to booking page or call API
                alert(`New booking created for room: ${room}\nDates: ${checkIn} - ${checkOut}`);
                closeBookAgainModal();
            }

            // HELPER: Convert dd/mm/yyyy -> yyyy-mm-dd for input type="date"
            function formatDateForInput(dateString) {
                if (!dateString)
                    return '';
                // If already yyyy-mm-dd
                if (dateString.includes('-'))
                    return dateString;

                // If dd/mm/yyyy
                const parts = dateString.split('/');
                if (parts.length === 3) {
                    return `${parts[2]}-${parts[1]}-${parts[0]}`;
                            }
                            return '';
                        }

                        // Other functions
                        function leaveReview(id) {
                            alert("Leave review function for booking " + id);
                        }
                        function requestService(id) {
                            alert("Room service function for booking " + id);
                        }

                        /* --- LOGIC ĐÁNH GIÁ (REVIEW) --- */

                        // 1. Mở Modal và lấy thông tin
                        function openReviewModal(button) {
                            const bookingId = button.dataset.id;
                            const roomName = button.dataset.room;

                            document.getElementById('reviewBookingId').value = bookingId;
                            document.getElementById('reviewBookingIdDisplay').innerText = bookingId;
                            document.getElementById('reviewRoomName').innerText = roomName;

                            // Reset form về trạng thái ban đầu
                            document.getElementById('reviewComment').value = '';
                            setRating(0); // Reset sao về 0
                            document.getElementById('ratingText').innerText = "Tap a star to rate";

                            document.getElementById('reviewModal').classList.add('show');
                        }

                        function closeReviewModal() {
                            document.getElementById('reviewModal').classList.remove('show');
                        }

                        // 2. Xử lý chọn sao (Hiệu ứng màu vàng)
                        function setRating(rating) {
                            // Lưu giá trị vào input hidden
                            document.getElementById('reviewRating').value = rating;

                            const stars = document.querySelectorAll('.star-rating .star');
                            const ratingTexts = ["Tap a star to rate", "Poor", "Fair", "Good", "Very Good", "Excellent"];

                            stars.forEach(star => {
                                const starValue = parseInt(star.dataset.value);
                                if (starValue <= rating) {
                                    star.classList.add('selected'); // Thêm màu vàng
                                } else {
                                    star.classList.remove('selected'); // Bỏ màu vàng
                                }
                            });

                            // Cập nhật chữ hiển thị (VD: Excellent)
                            document.getElementById('ratingText').innerText = ratingTexts[rating] || "";
                        }

                        // 3. Gửi đánh giá
                        function submitReview() {
                            const bookingId = document.getElementById('reviewBookingId').value;
                            const rating = document.getElementById('reviewRating').value;
                            const comment = document.getElementById('reviewComment').value;

                            // Validation: Bắt buộc phải chọn sao
                            if (rating == 0) {
                                alert("Please select a star rating!");
                                return;
                            }

                            // Giả lập gửi API
                            console.log("Submitting Review:", {bookingId, rating, comment});

                            alert(`Thank you! Your review for ${bookingId} has been submitted.\nRating: ${rating} Stars`);

                            closeReviewModal();
                            // Disable nút đánh giá sau khi gửi xong (tùy chọn UI)
                        }
        </script>
    </body>
</html>