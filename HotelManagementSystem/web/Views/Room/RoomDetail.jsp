<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Room Details - Hotel Manager</title>
        <link rel="stylesheet" href="CSS/Authen/login.css" />
        <link rel="stylesheet" href="CSS/Pages/room-detail.css" />
    </head>
    <body>
        <%@ include file="./../Components/Header.jsp" %>

        <div class="room-detail-container">
            <div class="breadcrumb">
                <a href="home">Home</a>
                <span>/</span>
                <a href="rooms">Room List</a>
                <span>/</span>
                <span class="current">Room Details</span>
            </div>

            <div class="detail-content">
                <!-- Image Gallery -->
                <div class="image-gallery">
                    <div class="main-image">
                        <img id="mainImage" src="/placeholder.svg?height=500&width=800" alt="Room">
                    </div>
                    <div class="thumbnail-gallery">
                        <img src="/placeholder.svg?height=100&width=100" alt="Image 1" class="thumbnail active" onclick="changeImage(this)">
                        <img src="/placeholder.svg?height=100&width=100" alt="Image 2" class="thumbnail" onclick="changeImage(this)">
                        <img src="/placeholder.svg?height=100&width=100" alt="Image 3" class="thumbnail" onclick="changeImage(this)">
                        <img src="/placeholder.svg?height=100&width=100" alt="Image 4" class="thumbnail" onclick="changeImage(this)">
                    </div>
                </div>

                <!-- Room Info Section -->
                <div class="info-section">
                    <div class="room-header">
                        <h1>Luxury Suite</h1>
                        <div class="rating">
                            <span class="stars">⭐⭐⭐⭐⭐</span>
                            <span class="rating-text">(125 reviews)</span>
                        </div>
                    </div>

                    <!-- Price & Booking -->
                    <div class="price-booking">
                        <div class="price-info">
                            <span class="price-label">Price per night</span>
                            <span class="price">1,500,000₫</span>
                            <span class="per-night">/Night</span>
                        </div>
                        <a href="login" class="btn btn-primary btn-lg">Book Now</a>
                    </div>

                    <!-- Room Details -->
                    <div class="details-grid">
                        <div class="detail-item">
                            <span class="detail-label">Room Type</span>
                            <span class="detail-value">Suite</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Capacity</span>
                            <span class="detail-value">2-4 Guests</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Area</span>
                            <span class="detail-value">45m²</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Floor</span>
                            <span class="detail-value">Floors 5-10</span>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="description">
                        <h3>Room Description</h3>
                        <p>
                            Our luxury suite offers an exceptional stay experience with elegant design and modern amenities. 
                            The room features high-quality furnishings, including a comfortable king-size bed, private bedroom, spacious living room, 
                            and a luxurious bathroom with a spa bathtub. From the balcony, you can enjoy a beautiful city view.
                        </p>
                    </div>

                    <!-- Amenities -->
                    <div class="amenities-section">
                        <h3>Room Amenities</h3>
                        <div class="amenities-list">
                            <div class="amenity-item">
                                <span class="amenity-icon">🛏️</span>
                                <span class="amenity-name">King Size Bed</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">🌡️</span>
                                <span class="amenity-name">Air Conditioning</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">📺</span>
                                <span class="amenity-name">55 Inch TV</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">🛁</span>
                                <span class="amenity-name">Spa Bathtub</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">📶</span>
                                <span class="amenity-name">Free WiFi</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">☕</span>
                                <span class="amenity-name">Coffee Machine</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">🛋️</span>
                                <span class="amenity-name">Living Room Sofa</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">❄️</span>
                                <span class="amenity-name">Mini Bar</span>
                            </div>
                        </div>
                    </div>

                    <!-- Rules & Info -->
                    <div class="rules-section">
                        <h3>Rules & Information</h3>
                        <ul class="rules-list">
                            <li>✓ Check-in from 14:00, Check-out before 11:00</li>
                            <li>✓ Pets allowed with an additional fee of 200,000₫</li>
                            <li>✓ Free cancellation up to 24 hours before</li>
                            <li>✓ No smoking in the room</li>
                            <li>✓ Breakfast included with booking</li>
                        </ul>
                    </div>

                    <!-- Call to Action -->
                    <div class="cta-buttons">
                        <a href="login" class="btn btn-primary btn-lg">Book Now</a>
                        <a href="rooms" class="btn btn-secondary">Back to List</a>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="./../Components/Footer.jsp" %>
        <%@ include file="./../public/notify.jsp" %>

        <script>
            function changeImage(thumbnail) {
                const mainImage = document.getElementById('mainImage');
                mainImage.src = thumbnail.src;

                // Update active thumbnail
                document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
                thumbnail.classList.add('active');
            }
        </script>
    </body>
</html>
