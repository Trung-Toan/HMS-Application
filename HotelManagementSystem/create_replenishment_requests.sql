-- Create table replenishment_requests
CREATE TABLE IF NOT EXISTS replenishment_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    inspection_id INT NOT NULL,
    amenity_id INT NOT NULL,
    quantity_requested INT NOT NULL,
    reason TEXT,
    status VARCHAR(20) DEFAULT 'PENDING',
    requested_by INT NOT NULL,
    approved_by INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (inspection_id) REFERENCES room_inspections(inspection_id),
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id),
    FOREIGN KEY (requested_by) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id)
);

-- Create Stored Procedure sp_create_replenishment_request
DELIMITER //
CREATE PROCEDURE sp_create_replenishment_request(
    IN p_inspection_id INT,
    IN p_amenity_id INT,
    IN p_quantity INT,
    IN p_reason TEXT,
    IN p_requested_by INT,
    OUT p_request_id INT
)
BEGIN
    INSERT INTO replenishment_requests (inspection_id, amenity_id, quantity_requested, reason, requested_by, status, created_at)
    VALUES (p_inspection_id, p_amenity_id, p_quantity, p_reason, p_requested_by, 'PENDING', NOW());
    
    SET p_request_id = LAST_INSERT_ID();
END //
DELIMITER ;

-- Create Stored Procedure sp_update_replenishment_status
DELIMITER //
CREATE PROCEDURE sp_update_replenishment_status(
    IN p_request_id INT,
    IN p_status VARCHAR(20),
    IN p_approved_by INT
)
BEGIN
    UPDATE replenishment_requests
    SET status = p_status,
        approved_by = p_approved_by,
        updated_at = NOW()
    WHERE request_id = p_request_id;
END //
DELIMITER ;
