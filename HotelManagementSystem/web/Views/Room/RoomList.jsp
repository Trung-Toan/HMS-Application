<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Room List</title>
        <link rel="stylesheet" href="CSS/Authen/login.css" />
        <link rel="stylesheet" href="CSS/Pages/room-list.css" />
    </head>
    <body>
        <%@ include file="./../Components/Header.jsp" %>

        <div class="room-container">
            <div class="breadcrumb">
                <a href="home">Home</a>
                <span>/</span>
                <span class="current">Room List</span>
            </div>

            <div class="room-header">
                <h1>Room List</h1>
                <p>Find and view available rooms</p>
            </div>

            <!-- Search & Filter Section -->
            <div class="search-section">
                <form class="search-form" method="GET" action="rooms">
                    <div class="search-group">
                        <label for="check-in">Check-in Date</label>
                        <input type="date" id="check-in" name="checkIn" class="search-input">
                    </div>
                    <div class="search-group">
                        <label for="check-out">Check-out Date</label>
                        <input type="date" id="check-out" name="checkOut" class="search-input">
                    </div>
                    <div class="search-group">
                        <label for="guests">Number of Guests</label>
                        <select id="guests" name="guests" class="search-input">
                            <option value="">-- Select number of guests --</option>
                            <option value="1">1 Guest</option>
                            <option value="2">2 Guests</option>
                            <option value="3">3 Guests</option>
                            <option value="4">4+ Guests</option>
                        </select>
                    </div>
                    <div class="search-group">
                        <label for="room-type">Room Type</label>
                        <select id="room-type" name="roomType" class="search-input">
                            <option value="">-- All Types --</option>
                            <option value="single">Single Room</option>
                            <option value="double">Double Room</option>
                            <option value="suite">Suite</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary search-btn">Search</button>
                </form>
            </div>

            <!-- Room List -->
            <div class="room-list">
                <!-- Sample Room Card 1 -->
                <div class="room-card">
                    <div class="room-image">
                        <img src="/placeholder.svg?height=250&width=350" alt="Single Room">
                        <span class="room-type-badge">Single Room</span>
                    </div>
                    <div class="room-info">
                        <h3>Standard Single Room</h3>
                        <p class="room-description">
                            Comfortable room with a single bed, private bathroom, and open view.
                        </p>
                        <div class="room-amenities">
                            <span class="amenity">🛏️ Single Bed</span>
                            <span class="amenity">🌡️ Air Conditioning</span>
                            <span class="amenity">📺 TV</span>
                            <span class="amenity">🚿 Bathroom</span>
                        </div>
                        <div class="room-footer">
                            <div class="room-price">
                                <span class="price">500,000₫</span>
                                <span class="per-night">/Night</span>
                            </div>
                            <a href="room-detail?id=1" class="btn btn-secondary">View Details</a>
                        </div>
                    </div>
                </div>

                <!-- Sample Room Card 2 -->
                <div class="room-card">
                    <div class="room-image">
                        <img src="/placeholder.svg?height=250&width=350" alt="Double Room">
                        <span class="room-type-badge">Double Room</span>
                    </div>
                    <div class="room-info">
                        <h3>Standard Double Room</h3>
                        <p class="room-description">
                            Elegant room with a double bed, bathtub, and modern amenities.
                        </p>
                        <div class="room-amenities">
                            <span class="amenity">🛏️ Double Bed</span>
                            <span class="amenity">🌡️ Air Conditioning</span>
                            <span class="amenity">📺 TV</span>
                            <span class="amenity">🛁 Bathtub</span>
                        </div>
                        <div class="room-footer">
                            <div class="room-price">
                                <span class="price">750,000₫</span>
                                <span class="per-night">/Night</span>
                            </div>
                            <a href="room-detail?id=2" class="btn btn-secondary">View Details</a>
                        </div>
                    </div>
                </div>

                <!-- Sample Room Card 3 -->
                <div class="room-card">
                    <div class="room-image">
                        <img src="/placeholder.svg?height=250&width=350" alt="Suite">
                        <span class="room-type-badge">Suite</span>
                    </div>
                    <div class="room-info">
                        <h3>Luxury Suite</h3>
                        <p class="room-description">
                            Luxurious suite with a separate living room, spacious bedroom,
                            and premium amenities.
                        </p>
                        <div class="room-amenities">
                            <span class="amenity">🛏️ King Bed</span>
                            <span class="amenity">🌡️ Air Conditioning</span>
                            <span class="amenity">📺 TV</span>
                            <span class="amenity">🏊 Spa Bathtub</span>
                        </div>
                        <div class="room-footer">
                            <div class="room-price">
                                <span class="price">1,500,000₫</span>
                                <span class="per-night">/Night</span>
                            </div>
                            <a href="room-detail?id=3" class="btn btn-secondary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <a href="#" class="page-link" id="prevPage">&laquo; Prev</a>

                <a href="#" class="page-link active" data-page="1">1</a>
                <a href="#" class="page-link" data-page="2">2</a>
                <a href="#" class="page-link" data-page="3">3</a>

                <a href="#" class="page-link" id="nextPage">Next &raquo;</a>
            </div>

            <!-- No Results Message (Hidden by default) -->
            <div class="no-results" style="display: none;">
                <p>No suitable rooms found. Please try again with different criteria.</p>
            </div>
        </div>

        <%@ include file="./../Components/Footer.jsp" %>
        <%@ include file="./../public/notify.jsp" %>
    </body>
    <script>
        const roomsPerPage = 3; // number of rooms per page
        const rooms = document.querySelectorAll('.room-card');
        const pageLinks = document.querySelectorAll('.page-link[data-page]');
        const prevBtn = document.getElementById('prevPage');
        const nextBtn = document.getElementById('nextPage');

        let currentPage = 1;
        const totalPages = Math.ceil(rooms.length / roomsPerPage);

        function showPage(page) {
            if (page < 1 || page > totalPages)
                return;

            currentPage = page;

            rooms.forEach((room, index) => {
                room.style.display =
                        index >= (page - 1) * roomsPerPage &&
                        index < page * roomsPerPage
                        ? 'block'
                        : 'none';
            });

            pageLinks.forEach(link => {
                link.classList.toggle(
                        'active',
                        Number(link.dataset.page) === page
                        );
            });
        }

        pageLinks.forEach(link => {
            link.addEventListener('click', e => {
                e.preventDefault();
                showPage(Number(link.dataset.page));
            });
        });

        prevBtn.addEventListener('click', e => {
            e.preventDefault();
            showPage(currentPage - 1);
        });

        nextBtn.addEventListener('click', e => {
            e.preventDefault();
            showPage(currentPage + 1);
        });

        showPage(1); // initialize
    </script>
</html>
