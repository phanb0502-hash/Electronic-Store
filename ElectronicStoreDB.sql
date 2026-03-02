USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'ElectronicStoreDB')
BEGIN
    ALTER DATABASE ElectronicStoreDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ElectronicStoreDB;
END
GO
CREATE DATABASE ElectronicStoreDB;
GO
USE ElectronicStoreDB;
GO

-- ===============================
-- Roles
-- ===============================
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(200)
);

INSERT INTO Roles (RoleName, Description) VALUES
(N'Admin', N'Quản trị hệ thống'),
(N'Customer', N'Khách hàng mua sản phẩm');
GO

-- ===============================
-- Users
-- ===============================
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    [Password] NVARCHAR(100) NOT NULL,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    RoleID INT NOT NULL,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

INSERT INTO Users (Username, [Password], FullName, Email, RoleID) VALUES
('admin01', '123', N'Nguyễn Văn A', 'admin@gmail.com', 1),
('user01',  '126', N'Lê Thị D', 'user01@gmail.com', 2),
('user02',  '127', N'Hoàng Văn E', 'user02@gmail.com', 2);
GO

-- ===============================
-- Categories
-- ===============================
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(200)
);

INSERT INTO Categories (CategoryName, Description) VALUES
(N'Điện thoại', N'Smartphone các hãng'),
(N'Laptop', N'Máy tính xách tay'),
(N'Tai nghe', N'Thiết bị âm thanh'),
(N'Phụ kiện', N'Phụ kiện điện tử');
GO

-- ===============================
-- Products
-- ===============================
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    Description NVARCHAR(300),
    CategoryID INT NOT NULL,
    UserID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Products (ProductName, Price, Quantity, Description, CategoryID, UserID) VALUES
(N'iPhone 15 Pro', 29990000, 10, N'Điện thoại cao cấp của Apple', 1, 2),
(N'Samsung Galaxy S24', 23990000, 15, N'Flagship mới của Samsung', 1, 3),
(N'Dell XPS 13', 32990000, 5, N'Laptop mỏng nhẹ cao cấp', 2, 2),
(N'AirPods Pro 2', 5990000, 25, N'Tai nghe chống ồn của Apple', 3, 2),
(N'Cáp sạc Type-C', 199000, 100, N'Phụ kiện sạc nhanh', 4, 3),
-- Category 1: Điện thoại (thêm)
(N'iPhone 15 Plus', 26990000, 8, N'Phiên bản lớn hơn của iPhone 15', 1, 2),
(N'Xiaomi 14 Ultra', 19990000, 12, N'Flagship của Xiaomi với camera Leica', 1, 3),
(N'OPPO Find X7', 17990000, 20, N'Điện thoại chụp ảnh đẹp, hiệu năng mạnh', 1, 3),

-- Category 2: Laptop (thêm)
(N'MacBook Air M3', 28990000, 7, N'Laptop Apple chip M3 mới nhất', 2, 2),
(N'ASUS ZenBook 14 OLED', 23990000, 9, N'Màn hình OLED 14 inch, thiết kế mỏng nhẹ', 2, 3),
(N'HP Spectre x360', 25990000, 6, N'Laptop xoay gập cảm ứng cao cấp', 2, 2),

-- Category 3: Tai nghe (thêm)
(N'Sony WH-1000XM5', 8990000, 18, N'Tai nghe chống ồn cao cấp của Sony', 3, 3),
(N'JBL Tune 760NC', 2990000, 25, N'Tai nghe không dây chống ồn, pin lâu', 3, 2),
(N'Beats Studio Pro', 7490000, 10, N'Tai nghe âm thanh mạnh mẽ, thiết kế thời trang', 3, 2),

-- Category 4: Phụ kiện (thêm)
(N'Sạc nhanh Anker 65W', 990000, 30, N'Sạc nhanh hỗ trợ PD và QC 3.0', 4, 2),
(N'Chuột Logitech MX Master 3S', 2490000, 15, N'Chuột không dây cao cấp cho dân văn phòng', 4, 3),
(N'Bàn phím cơ Keychron K6', 1890000, 20, N'Bàn phím cơ nhỏ gọn, Bluetooth, pin lâu', 4, 3);
GO
GO

-- ===============================
-- Ratings
-- ===============================
CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(300),
    RatingDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Ratings (ProductID, Rating, Comment) VALUES
(1, 5, N'Sản phẩm rất tốt, đúng mô tả'),
(2, 4, N'Hiệu năng ổn nhưng hơi nóng'),
(3, 5, N'Màn hình sắc nét, cảm ứng mượt mà'),
(4, 5, N'Âm thanh tuyệt vời, pin lâu, đáng tiền'),
(5, 3, N'Giá hơi cao so với chất lượng'),
(6, 4, N'Máy chạy mượt, pin ổn định'),
(7, 5, N'Camera Leica chất lượng, rất hài lòng'),
(8, 4, N'Thiết kế đẹp, hiệu năng mạnh, nhưng pin hơi yếu'),
(9, 5, N'Laptop mỏng nhẹ, hiệu năng tốt'),
(10, 4, N'Màn OLED đẹp, bàn phím dễ gõ'),
(11, 5, N'Xoay gập tiện lợi, cảm ứng nhạy'),
(12, 5, N'Chống ồn cực tốt, pin khỏe'),
(13, 4, N'Chống ồn tốt nhưng hơi nặng'),
(14, 5, N'Âm thanh mạnh mẽ, nghe nhạc rất sướng'),
(15, 4, N'Sạc nhanh đúng như quảng cáo, thiết kế đẹp'),
(16, 5, N'Chuột dùng êm, cảm giác lướt rất mượt'),
(17, 4, N'Bàn phím gõ sướng tay, pin khá tốt')

GO


-- ===============================
-- Orders
-- ===============================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(12,2),
    Status NVARCHAR(50) DEFAULT N'Pending',
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Orders (UserID, TotalAmount, Status) VALUES
(2, 30589000, N'Completed'),
(3, 23990000, N'Pending'),
(3, 6199000, N'Completed');
GO

-- ===============================
-- OrderDetails
-- ===============================
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 29990000),
(1, 5, 3, 199000),
(2, 2, 1, 23990000),
(3, 4, 1, 5990000),
(3, 5, 1, 199000);
GO
