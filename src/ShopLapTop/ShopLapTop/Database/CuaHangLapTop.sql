-- =============================================================================
-- Shop Laptop - Script khoi tao database (chay 1 lan sau khi clone source)
-- SQL Server Express / SQL Server 2019+
-- Chay file nay trong SQL Server Management Studio (SSMS) hoac sqlcmd
-- =============================================================================

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'CuaHangLapTop')
    DROP DATABASE CuaHangLapTop;
GO

CREATE DATABASE CuaHangLapTop;
GO

USE CuaHangLapTop;
GO

-- =============================================================================
-- 1. TAO BANG
-- =============================================================================

-- LoaiDanhMuc: 1 = Nhu cau su dung, 2 = Thuong hieu
CREATE TABLE LoaiSP (
    MaLoai      INT IDENTITY(1,1) PRIMARY KEY,
    TenLoai     NVARCHAR(100) NOT NULL,
    LoaiDanhMuc INT NOT NULL DEFAULT 1,
    HinhAnh     NVARCHAR(200) NULL
);

CREATE TABLE SanPham (
    MaSP    INT IDENTITY(1,1) PRIMARY KEY,
    TenSP   NVARCHAR(200) NOT NULL,
    MoTa    NVARCHAR(MAX),
    Gia     DECIMAL(18,0) NOT NULL,
    SoLuong INT NOT NULL DEFAULT 0,
    HinhAnh NVARCHAR(500),
    HangSX  NVARCHAR(100)
);

-- Bang lien ket nhieu-nhieu: san pham <-> danh muc
-- ON DELETE CASCADE MaSP  : xoa san pham -> xoa lien ket
-- ON DELETE CASCADE MaLoai: xoa danh muc  -> xoa lien ket (san pham van giu)
CREATE TABLE SanPham_Loai (
    MaSP   INT NOT NULL,
    MaLoai INT NOT NULL,
    PRIMARY KEY (MaSP, MaLoai),
    CONSTRAINT FK_SanPhamLoai_MaSP
        FOREIGN KEY (MaSP)   REFERENCES SanPham(MaSP)   ON DELETE CASCADE,
    CONSTRAINT FK_SanPhamLoai_MaLoai
        FOREIGN KEY (MaLoai) REFERENCES LoaiSP(MaLoai)  ON DELETE CASCADE
);

CREATE TABLE NguoiDung (
    MaND         INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap  NVARCHAR(50)  NOT NULL UNIQUE,
    MatKhau      NVARCHAR(200) NOT NULL,
    HoTen        NVARCHAR(100),
    Email        NVARCHAR(100),
    SDT          NVARCHAR(20),
    VaiTro       INT NOT NULL DEFAULT 0  -- 0 = khach hang, 1 = admin
);

CREATE TABLE DonHang (
    MaDH      INT IDENTITY(1,1) PRIMARY KEY,
    MaND      INT FOREIGN KEY REFERENCES NguoiDung(MaND),
    NgayDat   DATETIME NOT NULL DEFAULT GETDATE(),
    TongTien  DECIMAL(18,0) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL DEFAULT N'Chờ xử lý',
    DiaChi    NVARCHAR(300),
    SDT       NVARCHAR(20),
    GhiChu    NVARCHAR(500)
);

CREATE TABLE ChiTietDonHang (
    MaCT     INT IDENTITY(1,1) PRIMARY KEY,
    MaDH     INT FOREIGN KEY REFERENCES DonHang(MaDH),
    MaSP     INT FOREIGN KEY REFERENCES SanPham(MaSP),
    SoLuong  INT NOT NULL,
    DonGia   DECIMAL(18,0) NOT NULL
);
GO

-- =============================================================================
-- 2. DU LIEU MAU - DANH MUC
-- =============================================================================

-- Nhu cau su dung (anh luu trong Images/Products/)
INSERT INTO LoaiSP (TenLoai, LoaiDanhMuc, HinhAnh) VALUES
(N'Gaming',    1, N'Images/Products/gaming-01.jpg'),
(N'Văn phòng', 1, N'Images/Products/office-01.jpg'),
(N'Sinh viên', 1, N'Images/Products/student-01.jpg'),
(N'Đồ họa',    1, N'Images/Products/creator-01.jpg');

-- Thuong hieu
INSERT INTO LoaiSP (TenLoai, LoaiDanhMuc) VALUES
(N'ASUS',     2),
(N'Dell',     2),
(N'HP',       2),
(N'Lenovo',   2),
(N'MSI',      2),
(N'Acer',     2),
(N'Apple',    2),
(N'Gigabyte', 2),
(N'Razer',    2);
GO

-- =============================================================================
-- 3. DU LIEU MAU - NGUOI DUNG
-- =============================================================================

-- Mat khau mau: 123456 (da ma hoa PBKDF2 + salt, xem MatKhauHelper.cs)
INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, SDT, VaiTro) VALUES
(N'admin',  N'qaBmAs6fprQMCvlJpwNY0ufiO61HFnd/Ifqy2lk2U3T+WzTIRdOqde7lwX+jByyf', N'Quản trị viên', N'admin@shoplaptop.vn',  N'0901234567', 1),
(N'khach1', N'qaBmAs6fprQMCvlJpwNY0ufiO61HFnd/Ifqy2lk2U3T+WzTIRdOqde7lwX+jByyf', N'Nguyễn Văn A',  N'khach1@gmail.com',   N'0912345678', 0);
GO

-- =============================================================================
-- 4. DU LIEU MAU - SAN PHAM
-- =============================================================================

INSERT INTO SanPham (TenSP, MoTa, Gia, SoLuong, HinhAnh, HangSX) VALUES
(N'ASUS ROG Strix G16',
 N'Laptop gaming mạnh mẽ, RTX 4060, Intel Core i7 Gen 13, RAM 16GB, SSD 512GB, màn hình 165Hz',
 28990000, 15, N'Images/Products/gaming-01.jpg', N'ASUS'),

(N'Dell XPS 15',
 N'Laptop cao cấp cho doanh nhân, màn hình OLED 3.5K, Intel Core i7, RAM 16GB, SSD 512GB',
 35990000, 10, N'Images/Products/office-01.jpg', N'Dell'),

(N'HP Pavilion 15',
 N'Laptop văn phòng giá rẻ, AMD Ryzen 5, RAM 8GB, SSD 256GB, thiết kế gọn nhẹ',
 12990000, 25, N'Images/Products/office-02.jpg', N'HP'),

(N'Lenovo IdeaPad 3',
 N'Laptop sinh viên lý tưởng, Intel Core i5, RAM 8GB, SSD 512GB, nhẹ và bền bỉ',
 10990000, 30, N'Images/Products/student-01.jpg', N'Lenovo'),

(N'MSI Creator Z16',
 N'Laptop đồ họa chuyên nghiệp, RTX 3070 Ti, màn hình 16 inch 2K, thiết kế sang trọng',
 42990000, 8, N'Images/Products/creator-01.jpg', N'MSI'),

(N'Acer Nitro 5',
 N'Laptop gaming giá tốt, RTX 3050, Intel Core i5, RAM 16GB, tản nhiệt hiệu quả',
 19990000, 20, N'Images/Products/gaming-02.jpg', N'Acer'),

(N'MacBook Air M2',
 N'Apple MacBook Air chip M2, RAM 8GB, SSD 256GB, siêu mỏng nhẹ, pin 18 giờ',
 27990000, 12, N'Images/Products/macbook-01.jpg', N'Apple'),

(N'ASUS VivoBook 15',
 N'Laptop học tập đa năng, Intel Core i3, RAM 8GB, SSD 256GB, phù hợp sinh viên',
 8990000, 35, N'Images/Products/thin-01.jpg', N'ASUS'),

(N'Lenovo Legion 5 Pro',
 N'Laptop gaming Lenovo, RTX 4070, AMD Ryzen 7, RAM 16GB, màn hình 165Hz, hiệu năng cao',
 32990000, 12, N'Images/Products/gaming-03.jpg', N'Lenovo'),

(N'ASUS TUF Gaming A15',
 N'Laptop gaming giá rẻ từ ASUS, RTX 4050, Ryzen 5, RAM 16GB, SSD 512GB, vỏ nhôm',
 21990000, 18, N'Images/Products/gaming-04.jpg', N'ASUS'),

(N'Dell Inspiron 14',
 N'Laptop văn phòng mỏng nhẹ, Intel Core i5, RAM 16GB, pin trâu 12 giờ',
 16990000, 22, N'Images/Products/office-03.jpg', N'Dell'),

(N'HP Envy x360',
 N'Laptop 2-in-1 cao cấp, màn hình cảm ứng, AMD Ryzen 7, RAM 16GB, xoay gập 360°',
 24990000, 10, N'Images/Products/office-01.jpg', N'HP'),

(N'MSI Katana 15',
 N'Laptop gaming MSI tầm trung, RTX 4060, Intel Core i7, RAM 16GB, bàn phím RGB đẹp',
 26990000, 14, N'Images/Products/gaming-02.jpg', N'MSI'),

(N'Acer Swift 3',
 N'Laptop sinh viên vỏ nhôm, Intel Core i5, RAM 8GB, SSD 512GB, nhẹ chỉ 1.5kg',
 13990000, 28, N'Images/Products/student-01.jpg', N'Acer'),

(N'MacBook Pro 14 M3',
 N'MacBook Pro chip M3, RAM 18GB, SSD 512GB, màn hình Liquid Retina XDR, hiệu năng đỉnh',
 45990000, 6, N'Images/Products/macbook-01.jpg', N'Apple'),

(N'Lenovo ThinkPad E14',
 N'Laptop doanh nhân bền bỉ, Intel Core i5, RAM 16GB, bàn phím ThinkPad huyền thoại',
 18990000, 16, N'Images/Products/office-02.jpg', N'Lenovo'),

(N'ASUS ZenBook 14',
 N'Laptop văn phòng cao cấp, màn hình OLED, Intel Core i7, RAM 16GB, siêu mỏng 14mm',
 23990000, 11, N'Images/Products/thin-01.jpg', N'ASUS'),

(N'Gigabyte Aorus 15',
 N'Laptop gaming cao cấp Gigabyte, RTX 4080, Intel Core i9, RAM 32GB, hiệu năng khủng',
 54990000, 5, N'Images/Products/gaming-01.jpg', N'Gigabyte'),

(N'Razer Blade 15',
 N'Laptop gaming cao cấp Razer, RTX 4070, Intel Core i7, vỏ nhôm CNC, thiết kế tối giản',
 49990000, 7, N'Images/Products/gaming-03.jpg', N'Razer'),

(N'HP Victus 16',
 N'Laptop gaming HP, RTX 3050, AMD Ryzen 5, RAM 16GB, màn hình 144Hz, giá tốt',
 17990000, 20, N'Images/Products/gaming-04.jpg', N'HP');
GO

-- =============================================================================
-- 5. GAN DANH MUC CHO SAN PHAM
-- =============================================================================

DECLARE @MaSP INT, @Hang NVARCHAR(100), @TenSP NVARCHAR(200);

DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT MaSP, HangSX, TenSP FROM SanPham;

OPEN cur;
FETCH NEXT FROM cur INTO @MaSP, @Hang, @TenSP;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Gan thuong hieu theo HangSX
    INSERT INTO SanPham_Loai (MaSP, MaLoai)
    SELECT @MaSP, MaLoai FROM LoaiSP
    WHERE LoaiDanhMuc = 2 AND TenLoai = @Hang;

    -- Gan nhu cau theo ten san pham
    IF @TenSP LIKE N'%gaming%' OR @TenSP LIKE N'%ROG%' OR @TenSP LIKE N'%Nitro%'
        OR @TenSP LIKE N'%Legion%' OR @TenSP LIKE N'%TUF%' OR @TenSP LIKE N'%Katana%'
        OR @TenSP LIKE N'%Victus%' OR @TenSP LIKE N'%Aorus%' OR @TenSP LIKE N'%Blade%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai)
        SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Gaming';

    IF @TenSP LIKE N'%Creator%' OR @TenSP LIKE N'%MacBook Pro%' OR @TenSP LIKE N'%ZenBook%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai)
        SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Đồ họa';

    IF @TenSP LIKE N'%IdeaPad%' OR @TenSP LIKE N'%VivoBook%' OR @TenSP LIKE N'%Swift%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai)
        SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Sinh viên';

    IF @TenSP LIKE N'%XPS%' OR @TenSP LIKE N'%ThinkPad%' OR @TenSP LIKE N'%Pavilion%'
        OR @TenSP LIKE N'%MacBook Air%' OR @TenSP LIKE N'%Envy%' OR @TenSP LIKE N'%Inspiron%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai)
        SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Văn phòng';

    FETCH NEXT FROM cur INTO @MaSP, @Hang, @TenSP;
END

CLOSE cur;
DEALLOCATE cur;
GO

-- =============================================================================
-- 6. DU LIEU MAU - DON HANG (de test lich su don hang & admin)
-- =============================================================================

INSERT INTO DonHang (MaND, NgayDat, TongTien, TrangThai, DiaChi, SDT, GhiChu) VALUES
(2, DATEADD(DAY, -5, GETDATE()), 28990000, N'Đã giao',    N'123 Nguyễn Huệ, Q.1, TP.HCM',  N'0912345678', N'Giao giờ hành chính'),
(2, DATEADD(DAY, -2, GETDATE()), 19990000, N'Đang giao',  N'456 Lê Lợi, Q.3, TP.HCM',     N'0912345678', NULL),
(2, DATEADD(DAY, -1, GETDATE()), 10990000, N'Chờ xử lý',  N'789 Hai Bà Trưng, Q.1, TP.HCM', N'0912345678', N'Gọi trước khi giao');
GO

INSERT INTO ChiTietDonHang (MaDH, MaSP, SoLuong, DonGia) VALUES
(1, 1, 1, 28990000),
(2, 6, 1, 19990000),
(3, 4, 1, 10990000);
GO

-- =============================================================================
-- 7. KIEM TRA KET QUA
-- =============================================================================

PRINT N'';
PRINT N'========================================';
PRINT N'  Database CuaHangLapTop da san sang!';
PRINT N'========================================';
PRINT N'';
PRINT N'Tai khoan mau:';
PRINT N'  Admin  : admin  / 123456';
PRINT N'  Khach  : khach1 / 123456';
PRINT N'';
SELECT N'Danh muc' AS [Bang], COUNT(*) AS [SoBanGhi] FROM LoaiSP
UNION ALL SELECT N'San pham',  COUNT(*) FROM SanPham
UNION ALL SELECT N'Nguoi dung', COUNT(*) FROM NguoiDung
UNION ALL SELECT N'Don hang',   COUNT(*) FROM DonHang;
GO
