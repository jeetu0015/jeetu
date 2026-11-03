DROP DATABASE IF EXISTS Shopping_Management;

CREATE DATABASE Shopping_Management;

USE Shopping_Management;

CREATE TABLE customers (
    Customer_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone_Number CHAR(10) NOT NULL UNIQUE,
    Age INT CHECK (Age > 0),
    Gender ENUM('Male', 'Female', 'Other'),
    Country VARCHAR(50) DEFAULT 'India',
    City VARCHAR(50) NOT NULL,
    Pincode CHAR(6) DEFAULT '201301',
    Registration_Date DATE DEFAULT (CURRENT_DATE),
    Registration_Time TIME DEFAULT (CURRENT_TIME),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Address VARCHAR(250),
    Customer_Status ENUM('Active', 'Inactive', 'Blocked') DEFAULT 'Active',
    Customer_Notes TINYTEXT
); 

select * from customers

CREATE TABLE orders (
    Order_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id INT,
    Order_Date DATE DEFAULT (CURRENT_DATE),
    Order_Amount DECIMAL(10,2) NOT NULL,

    Order_Status ENUM(
        'Pending', 'Processing', 'Shipped',
        'Delivered', 'Cancelled'
    ) DEFAULT 'Pending',

    Payment_Method ENUM(
        'Cash', 'Card', 'UPI', 'Net Banking'
    ),

    Payment_Status ENUM(
        'Pending', 'Paid', 'Failed'
    ) DEFAULT 'Pending',

    Shipping_Address VARCHAR(250) NOT NULL,
    Delivery_Pincode CHAR(6),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Discount_Amount DECIMAL(10,2) DEFAULT 0.00,
    Delivery_Date DATE NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Tracking_Number VARCHAR(30) UNIQUE,

    Delivery_Status ENUM(
        'Not Dispatched', 'In Transit',
        'Delivered', 'Returned'
    ) DEFAULT 'Not Dispatched',

    Order_Notes TINYTEXT,

    CONSTRAINT fk_customer
    FOREIGN KEY (Customer_Id)
    REFERENCES customers(Customer_Id)
    ON DELETE CASCADE
    ON UPDATE CASCADE

);


select * from orders


INSERT INTO customers
(Customer_Name, Email, Phone_Number, Age, Gender, Country, City, Pincode,
Registration_Date, Registration_Time, Address, Customer_Status, Customer_Notes)
VALUES
('Rahul Sharma', 'rahul@gmail.com', '9876543210', 25, 'Male', 'India', 'Noida', '201301', '2026-01-10', '10:30:00', 'Sector 16, Noida', 'Active', 'Regular Customer'),

('Priya Verma', 'priya@gmail.com', '9876543211', 23, 'Female', 'India', 'Delhi', '110001', '2026-01-12', '11:00:00', 'Connaught Place, Delhi', 'Active', 'Premium Customer'),

('Amit Kumar', 'amit@gmail.com', '9876543212', 30, 'Male', 'India', 'Mumbai', '400001', '2026-01-15', '12:15:00', 'Andheri West, Mumbai', 'Active', 'Frequent Buyer'),

('Sneha Gupta', 'sneha@gmail.com', '9876543213', 27, 'Female', 'India', 'Lucknow', '226001', '2026-01-18', '09:45:00', 'Hazratganj, Lucknow', 'Inactive', 'Inactive for now'),

('Vikas Singh', 'vikas@gmail.com', '9876543214', 35, 'Male', 'India', 'Jaipur', '302001', '2026-01-20', '14:30:00', 'Malviya Nagar, Jaipur', 'Active', 'Regular Buyer'),

('Neha Agarwal', 'neha@gmail.com', '9876543215', 22, 'Female', 'India', 'Pune', '411001', '2026-01-22', '15:00:00', 'Shivaji Nagar, Pune', 'Active', 'New Customer'),

('Rohit Mehta', 'rohit@gmail.com', '9876543216', 29, 'Male', 'India', 'Bangalore', '560001', '2026-01-25', '16:20:00', 'MG Road, Bangalore', 'Blocked', 'Account temporarily blocked'),

('Anjali Yadav', 'anjali@gmail.com', '9876543217', 26, 'Female', 'India', 'Noida', '201301', '2026-02-01', '10:00:00', 'Sector 62, Noida', 'Active', 'Regular Customer'),

('Karan Malhotra', 'karan@gmail.com', '9876543218', 32, 'Male', 'India', 'Chandigarh', '160001', '2026-02-05', '13:45:00', 'Sector 17, Chandigarh', 'Active', 'Premium Customer'),

('Pooja Mishra', 'pooja@gmail.com', '9876543219', 24, 'Female', 'India', 'Kanpur', '208001', '2026-02-10', '17:30:00', 'Civil Lines, Kanpur', 'Inactive', 'Occasional Buyer'); 






INSERT INTO orders
(Customer_Id, Order_Date, Order_Amount, Order_Status, Payment_Method,
Payment_Status, Shipping_Address, Delivery_Pincode, Quantity,
Discount_Amount, Delivery_Date, Tracking_Number, Delivery_Status, Order_Notes)
VALUES

(1, '2026-02-12', 2500.00, 'Delivered', 'UPI', 'Paid', 'Sector 16, Noida', '201301', 2, 200.00, '2026-02-15', 'TRK1001', 'Delivered', 'Order delivered successfully'),

(2, '2026-02-13', 4500.00, 'Shipped', 'Card', 'Paid', 'Connaught Place, Delhi', '110001', 3, 300.00, NULL, 'TRK1002', 'In Transit', 'Package shipped'),

(3, '2026-02-14', 1200.00, 'Processing', 'Cash', 'Pending', 'Andheri West, Mumbai', '400001', 1, 0.00, NULL, 'TRK1003', 'Not Dispatched', 'Order processing'),

(4, '2026-02-15', 3200.00, 'Cancelled', 'UPI', 'Failed', 'Hazratganj, Lucknow', '226001', 2, 100.00, NULL, 'TRK1004', 'Not Dispatched', 'Customer cancelled order'),

(5, '2026-02-16', 5600.00, 'Delivered', 'Net Banking', 'Paid', 'Malviya Nagar, Jaipur', '302001', 4, 500.00, '2026-02-19', 'TRK1005', 'Delivered', 'Delivered on time'),

(6, '2026-02-17', 1800.00, 'Pending', 'Card', 'Pending', 'Shivaji Nagar, Pune', '411001', 1, 0.00, NULL, 'TRK1006', 'Not Dispatched', 'Waiting for confirmation'),

(7, '2026-02-18', 7500.00, 'Cancelled', 'UPI', 'Failed', 'MG Road, Bangalore', '560001', 5, 500.00, NULL, 'TRK1007', 'Returned', 'Order cancelled'),

(8, '2026-02-19', 2900.00, 'Delivered', 'Cash', 'Paid', 'Sector 62, Noida', '201301', 2, 150.00, '2026-02-22', 'TRK1008', 'Delivered', 'Successfully delivered'),

(9, '2026-02-20', 4100.00, 'Shipped', 'Card', 'Paid', 'Sector 17, Chandigarh', '160001', 3, 200.00, NULL, 'TRK1009', 'In Transit', 'Out for delivery soon'),

(10, '2026-02-21', 2200.00, 'Pending', 'Net Banking', 'Pending', 'Civil Lines, Kanpur', '208001', 2, 100.00, NULL, 'TRK1010', 'Not Dispatched', 'Payment pending'),

(1, '2026-02-22', 6500.00, 'Delivered', 'UPI', 'Paid', 'Sector 16, Noida', '201301', 4, 500.00, '2026-02-25', 'TRK1011', 'Delivered', 'Second order'),

(2, '2026-02-23', 1500.00, 'Processing', 'Card', 'Paid', 'Connaught Place, Delhi', '110001', 1, 100.00, NULL, 'TRK1012', 'Not Dispatched', 'Processing order'),

(3, '2026-02-24', 3800.00, 'Shipped', 'UPI', 'Paid', 'Andheri West, Mumbai', '400001', 3, 250.00, NULL, 'TRK1013', 'In Transit', 'Order dispatched'),

(5, '2026-02-25', 900.00, 'Delivered', 'Cash', 'Paid', 'Malviya Nagar, Jaipur', '302001', 1, 0.00, '2026-02-27', 'TRK1014', 'Delivered', 'Small order'),

(8, '2026-02-26', 5200.00, 'Processing', 'Net Banking', 'Paid', 'Sector 62, Noida', '201301', 4, 400.00, NULL, 'TRK1015', 'Not Dispatched', 'Order being prepared');