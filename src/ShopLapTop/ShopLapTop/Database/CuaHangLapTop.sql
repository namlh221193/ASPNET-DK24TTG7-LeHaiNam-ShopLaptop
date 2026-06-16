-- Script tao database CuaHangLapTop cho SQL Server Express
-- Chay file nay trong SQL Server Management Studio (SSMS)

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'CuaHangLapTop')
    DROP DATABASE CuaHangLapTop;
GO

CREATE DATABASE CuaHangLapTop;
GO

USE CuaHangLapTop;
GO

-- Bang loai/danh muc: LoaiDanhMuc 1 = Nhu cau, 2 = Thuong hieu
CREATE TABLE LoaiSP (
    MaLoai INT IDENTITY(1,1) PRIMARY KEY,
    TenLoai NVARCHAR(100) NOT NULL,
    LoaiDanhMuc INT NOT NULL DEFAULT 1
);

CREATE TABLE SanPham (
    MaSP INT IDENTITY(1,1) PRIMARY KEY,
    TenSP NVARCHAR(200) NOT NULL,
    MoTa NVARCHAR(MAX),
    Gia DECIMAL(18,0) NOT NULL,
    SoLuong INT NOT NULL DEFAULT 0,
    HinhAnh NVARCHAR(500),
    HangSX NVARCHAR(100)
);

-- Bang lien ket nhieu danh muc
CREATE TABLE SanPham_Loai (
    MaSP INT NOT NULL,
    MaLoai INT NOT NULL,
    PRIMARY KEY (MaSP, MaLoai),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE,
    FOREIGN KEY (MaLoai) REFERENCES LoaiSP(MaLoai)
);

CREATE TABLE NguoiDung (
    MaND INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap NVARCHAR(50) NOT NULL UNIQUE,
    MatKhau NVARCHAR(100) NOT NULL,
    HoTen NVARCHAR(100),
    Email NVARCHAR(100),
    SDT NVARCHAR(20),
    VaiTro INT NOT NULL DEFAULT 0
);

CREATE TABLE DonHang (
    MaDH INT IDENTITY(1,1) PRIMARY KEY,
    MaND INT FOREIGN KEY REFERENCES NguoiDung(MaND),
    NgayDat DATETIME NOT NULL DEFAULT GETDATE(),
    TongTien DECIMAL(18,0) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL DEFAULT N'Chờ xử lý',
    DiaChi NVARCHAR(300),
    SDT NVARCHAR(20),
    GhiChu NVARCHAR(500)
);

CREATE TABLE ChiTietDonHang (
    MaCT INT IDENTITY(1,1) PRIMARY KEY,
    MaDH INT FOREIGN KEY REFERENCES DonHang(MaDH),
    MaSP INT FOREIGN KEY REFERENCES SanPham(MaSP),
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18,0) NOT NULL
);

-- Nhu cau su dung
INSERT INTO LoaiSP (TenLoai, LoaiDanhMuc) VALUES
(N'Gaming', 1), (N'Văn phòng', 1), (N'Sinh viên', 1), (N'Đồ họa', 1);

-- Thuong hieu
INSERT INTO LoaiSP (TenLoai, LoaiDanhMuc) VALUES
(N'ASUS', 2), (N'Dell', 2), (N'HP', 2), (N'Lenovo', 2),
(N'MSI', 2), (N'Acer', 2), (N'Apple', 2), (N'Gigabyte', 2), (N'Razer', 2);

INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, SDT, VaiTro) VALUES
(N'admin', N'123456', N'Quản trị viên', N'admin@shoplaptop.vn', N'0901234567', 1),
(N'khach1', N'123456', N'Nguyễn Văn A', N'khach1@gmail.com', N'0912345678', 0);

INSERT INTO SanPham (TenSP, MoTa, Gia, SoLuong, HinhAnh, HangSX) VALUES
(N'ASUS ROG Strix G16', N'Laptop gaming mạnh mẽ, RTX 4060, Intel Core i7 gen 13, RAM 16GB, SSD 512GB', 28990000, 15,
 N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', N'ASUS'),
(N'Dell XPS 15', N'Laptop cao cấp cho doanh nhân, màn hình OLED 3.5K, Intel Core i7, RAM 16GB', 35990000, 10,
 N'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', N'Dell'),
(N'HP Pavilion 15', N'Laptop văn phòng giá rẻ, AMD Ryzen 5, RAM 8GB, SSD 256GB', 12990000, 25,
 N'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', N'HP'),
(N'Lenovo IdeaPad 3', N'Laptop sinh viên, Intel Core i5, RAM 8GB, SSD 512GB, nhẹ và bền', 10990000, 30,
 N'https://images.unsplash.com/photo-1525547719570-a1d2b4b93489?w=400', N'Lenovo'),
(N'MSI Creator Z16', N'Laptop đồ họa chuyên nghiệp, RTX 3070 Ti, màn hình 16 inch 2K', 42990000, 8,
 N'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', N'MSI'),
(N'Acer Nitro 5', N'Laptop gaming giá tốt, RTX 3050, Intel Core i5, RAM 16GB', 19990000, 20,
 N'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400', N'Acer'),
(N'MacBook Air M2', N'Apple MacBook Air chip M2, RAM 8GB, SSD 256GB, siêu mỏng nhẹ', 27990000, 12,
 N'https://images.unsplash.com/photo-1611186871348-b1ce06e07c0f?w=400', N'Apple'),
(N'ASUS VivoBook 15', N'Laptop học tập, Intel Core i3, RAM 8GB, SSD 256GB', 8990000, 35,
 N'https://images.unsplash.com/photo-1587613865765-3f3c3f5b8f0e?w=400', N'ASUS'),
(N'Lenovo Legion 5 Pro', N'Laptop gaming Lenovo, RTX 4070, AMD Ryzen 7, RAM 16GB, màn hình 165Hz', 32990000, 12,
 N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', N'Lenovo'),
(N'ASUS TUF Gaming A15', N'Laptop gaming giá rẻ, RTX 4050, Ryzen 5, RAM 16GB, SSD 512GB', 21990000, 18,
 N'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400', N'ASUS'),
(N'Dell Inspiron 14', N'Laptop văn phòng mỏng nhẹ, Intel Core i5, RAM 16GB, pin trâu', 16990000, 22,
 N'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', N'Dell'),
(N'HP Envy x360', N'Laptop 2-in-1 cao cấp, màn hình cảm ứng, AMD Ryzen 7, RAM 16GB', 24990000, 10,
 N'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', N'HP'),
(N'MSI Katana 15', N'Laptop gaming MSI, RTX 4060, Intel Core i7, RAM 16GB, bàn phím RGB', 26990000, 14,
 N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', N'MSI'),
(N'Acer Swift 3', N'Laptop sinh viên nhẹ, Intel Core i5, RAM 8GB, SSD 512GB, vỏ nhôm', 13990000, 28,
 N'https://images.unsplash.com/photo-1525547719570-a1d2b4b93489?w=400', N'Acer'),
(N'MacBook Pro 14 M3', N'MacBook Pro chip M3, RAM 18GB, SSD 512GB, màn hình Liquid Retina XDR', 45990000, 6,
 N'https://images.unsplash.com/photo-1611186871348-b1ce06e07c0f?w=400', N'Apple'),
(N'Lenovo ThinkPad E14', N'Laptop doanh nhân, Intel Core i5, RAM 16GB, bàn phím ThinkPad', 18990000, 16,
 N'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', N'Lenovo'),
(N'ASUS ZenBook 14', N'Laptop văn phòng cao cấp, OLED, Intel Core i7, RAM 16GB, siêu mỏng', 23990000, 11,
 N'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', N'ASUS'),
(N'Gigabyte Aorus 15', N'Laptop gaming cao cấp, RTX 4080, Intel Core i9, RAM 32GB', 54990000, 5,
 N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', N'Gigabyte'),
(N'Razer Blade 15', N'Laptop gaming cao cấp, RTX 4070, Intel Core i7, vỏ nhôm CNC', 49990000, 7,
 N'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400', N'Razer'),
(N'HP Victus 16', N'Laptop gaming HP, RTX 3050, AMD Ryzen 5, RAM 16GB, màn hình 144Hz', 17990000, 20,
 N'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400', N'HP');
GO

-- Gan danh muc cho san pham
DECLARE @MaSP INT, @Hang NVARCHAR(100), @TenSP NVARCHAR(200);
DECLARE cur CURSOR FOR SELECT MaSP, HangSX, TenSP FROM SanPham;
OPEN cur;
FETCH NEXT FROM cur INTO @MaSP, @Hang, @TenSP;
WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO SanPham_Loai (MaSP, MaLoai)
    SELECT @MaSP, MaLoai FROM LoaiSP WHERE LoaiDanhMuc = 2 AND TenLoai = @Hang;

    IF @TenSP LIKE N'%gaming%' OR @TenSP LIKE N'%ROG%' OR @TenSP LIKE N'%Nitro%' OR @TenSP LIKE N'%Legion%'
        OR @TenSP LIKE N'%TUF%' OR @TenSP LIKE N'%Katana%' OR @TenSP LIKE N'%Victus%' OR @TenSP LIKE N'%Aorus%'
        OR @TenSP LIKE N'%Blade%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai) SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Gaming';

    IF @TenSP LIKE N'%Creator%' OR @TenSP LIKE N'%MacBook Pro%' OR @TenSP LIKE N'%ZenBook%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai) SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Đồ họa';

    IF @TenSP LIKE N'%IdeaPad%' OR @TenSP LIKE N'%VivoBook%' OR @TenSP LIKE N'%Swift%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai) SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Sinh viên';

    IF @TenSP LIKE N'%XPS%' OR @TenSP LIKE N'%ThinkPad%' OR @TenSP LIKE N'%Pavilion%'
        OR @TenSP LIKE N'%MacBook Air%' OR @TenSP LIKE N'%Envy%' OR @TenSP LIKE N'%Inspiron%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai) SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Văn phòng';

    FETCH NEXT FROM cur INTO @MaSP, @Hang, @TenSP;
END
CLOSE cur; DEALLOCATE cur;
GO

PRINT N'Đã tạo database CuaHangLapTop thành công!';
GO
