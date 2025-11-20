-- Create Database
CREATE DATABASE IF NOT EXISTS readhub_library;
USE readhub_library;

-- Members Table
CREATE TABLE IF NOT EXISTS members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    email_address VARCHAR(150) UNIQUE NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_user (user_name),
    INDEX idx_email (email_address)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Publications Table
CREATE TABLE IF NOT EXISTS publications (
    publication_id INT AUTO_INCREMENT PRIMARY KEY,
    category_type VARCHAR(30) NOT NULL,
    book_title VARCHAR(250) NOT NULL,
    author_name VARCHAR(150) NOT NULL,
    publisher_name VARCHAR(150) NOT NULL,
    book_price DECIMAL(10, 2) NOT NULL,
    isbn_number VARCHAR(25) UNIQUE,
    available_stock INT DEFAULT 0,
    user_rating DECIMAL(2, 1) DEFAULT 0.0,
    cover_image TEXT,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category_type),
    INDEX idx_title (book_title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Purchases Table
CREATE TABLE IF NOT EXISTS purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    purchase_status VARCHAR(30) DEFAULT 'Processing',
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    INDEX idx_member (member_id),
    INDEX idx_date (purchase_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Purchase Details Table
CREATE TABLE IF NOT EXISTS purchase_details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_id INT NOT NULL,
    publication_id INT NOT NULL,
    item_quantity INT NOT NULL,
    item_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id) ON DELETE CASCADE,
    FOREIGN KEY (publication_id) REFERENCES publications(publication_id) ON DELETE CASCADE,
    INDEX idx_purchase (purchase_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert Sample Books
INSERT INTO publications (publication_id, category_type, book_title, author_name, publisher_name, book_price, isbn_number, available_stock, user_rating, cover_image) VALUES
(1, 'cse', 'Data Structures and Algorithms', 'Mark Allen Weiss', 'Pearson Education', 550.00, '978-0132847377', 15, 4.5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyrS1y1CFjWMCQrEWIGqxIMlUuoFKpxdZq-ETa6RNUnP6vahqvfYjIi3IHp30f5PcgYOs&usqp=CAU'),
(2, 'cse', 'Operating System Concepts', 'Abraham Silberschatz', 'John Wiley & Sons', 600.00, '978-1118063330', 12, 4.7, 'https://www.wileyindia.com/pub/media/catalog/product/cache/20f980a1f90e8cec7a3c8f2cf40a32a8/9/7/9789357460569.png'),
(3, 'cse', 'Computer Networks', 'Andrew S. Tanenbaum', 'Pearson Education', 500.00, '978-0132126953', 20, 4.6, 'https://booksdelivery.com/image/cache/catalog/books/pearson/computer-networks-%205th-edition-550x550h.jpeg'),
(4, 'cse', 'Database System Concepts', 'Henry F. Korth', 'McGraw Hill Education', 650.00, '978-0073523323', 8, 4.8, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJRTnR1YV0iR6o8QEOiBHhXkAXJgktJTRbQw&s'),
(5, 'cse', 'Introduction to Algorithms', 'CLRS', 'MIT Press', 700.00, '978-0262033848', 10, 5.0, 'https://images.bookoutlet.com/covers/large/isbn978026/9780262033848-l.jpg'),
(6, 'ece', 'Digital Signal Processing', 'John G. Proakis', 'McGraw Hill Education', 700.00, '978-0131873742', 14, 4.4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQohApo0XfezA1flcP0T53YRSdHIyTKLySthA&s'),
(7, 'ece', 'Microelectronic Circuits', 'Sedra and Smith', 'Oxford University Press', 680.00, '978-0199476299', 11, 4.7, 'https://india.oup.com/covers/pdp/9780199476299'),
(8, 'ece', 'VLSI Design', 'Sung-Mo Kang', 'John Wiley & Sons', 800.00, '978-0073380629', 6, 4.3, 'https://m.media-amazon.com/images/I/61uVlZen4UL._UF1000,1000_QL80_.jpg'),
(9, 'ece', 'Communication Systems', 'Simon Haykin', 'John Wiley & Sons', 720.00, '978-0471697909', 9, 4.6, 'https://images-eu.ssl-images-amazon.com/images/I/812kbysLO7L._AC_UL600_SR600,600_.jpg'),
(10, 'ece', 'Electronic Devices and Circuits', 'Robert L. Boylestad', 'Pearson Education', 660.00, '978-0132622264', 13, 4.5, 'https://m.media-amazon.com/images/I/71tIs-c488L._UF1000,1000_QL80_.jpg'),
(11, 'eee', 'Power Electronics', 'Ned Mohan', 'John Wiley & Sons', 750.00, '978-1118074800', 10, 4.7, 'https://m.media-amazon.com/images/I/715FoXarqOL._UF1000,1000_QL80_.jpg'),
(12, 'eee', 'Electric Machinery Fundamentals', 'Stephen J. Chapman', 'McGraw Hill Education', 650.00, '978-0073380466', 12, 4.6, 'https://www.mheducation.com/cover-images/Webp_400-wide/0073380466.webp'),
(13, 'eee', 'Modern Control Systems', 'Katsuhiko Ogata', 'Prentice Hall', 680.00, '978-0136156734', 15, 4.8, 'https://m.media-amazon.com/images/I/71e5+rVAL5L._UF1000,1000_QL80_.jpg'),
(14, 'eee', 'Power System Analysis', 'William D. Stevenson', 'McGraw Hill Education', 700.00, '978-0070612938', 8, 4.5, 'https://pragationline.com/wp-content/uploads/2021/03/ELEMENTS-OF-POWER-SYSTEM-ANALYSIS-WILLIAM-D.-STEVENSON-JR.jpg'),
(15, 'eee', 'High Voltage Engineering', 'M.S. Naidu', 'Tata McGraw Hill', 740.00, '978-0074636343', 7, 4.4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH7I8QdWBEH6kFXztPH5m2a1IMBXJ1El10lQ&s'),
(16, 'civil', 'Structural Analysis', 'R.C. Hibbeler', 'Pearson Education', 600.00, '978-0134382593', 16, 4.6, 'https://m.media-amazon.com/images/I/51AXTSfNRfL._UF1000,1000_QL80_.jpg'),
(17, 'civil', 'Geotechnical Engineering', 'Braja M. Das', 'Cengage Learning', 620.00, '978-1305635180', 11, 4.5, 'https://d9h54mr6do0h0.cloudfront.net/bookimage/9789355738103_tn.jpg'),
(18, 'civil', 'Properties of Concrete', 'A.M. Neville', 'Pearson Education', 550.00, '978-0273755807', 14, 4.7, 'https://m.media-amazon.com/images/I/81vZPHq89+L._UF1000,1000_QL80_.jpg'),
(19, 'civil', 'Surveying and Levelling', 'B.C. Punmia', 'Laxmi Publications', 580.00, '978-8170080558', 18, 4.3, 'https://m.media-amazon.com/images/I/51tADigREHL.jpg'),
(20, 'civil', 'Highway Engineering', 'S.K. Khanna', 'Nem Chand & Bros', 640.00, '978-8121903462', 10, 4.4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG0a83iyfffk_ykV_QMBtFZIzg5qvlMiyuYg&s');

-- Insert Demo User (password: demo123)
INSERT INTO members (full_name, user_name, email_address, user_password) VALUES
('Demo User', 'demouser', 'demo@readhub.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');