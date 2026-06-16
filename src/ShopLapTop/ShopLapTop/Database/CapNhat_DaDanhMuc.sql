-- Script cap nhat database da co san: them da danh muc + them san pham
-- Chay file nay neu ban da tao database tu truoc

USE CuaHangLapTop;
GO

-- Them cot phan loai danh muc: 1 = Nhu cau su dung, 2 = Thuong hieu
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('LoaiSP') AND name = 'LoaiDanhMuc')
    ALTER TABLE LoaiSP ADD LoaiDanhMuc INT NOT NULL DEFAULT 1;
GO

UPDATE LoaiSP SET LoaiDanhMuc = 1;
UPDATE LoaiSP SET TenLoai = N'Văn phòng' WHERE TenLoai = N'Van phong';
UPDATE LoaiSP SET TenLoai = N'Sinh viên' WHERE TenLoai = N'Sinh vien';
UPDATE LoaiSP SET TenLoai = N'Đồ họa' WHERE TenLoai = N'Do hoa';
GO

-- Them thuong hieu neu chua co
IF NOT EXISTS (SELECT 1 FROM LoaiSP WHERE TenLoai = N'ASUS' AND LoaiDanhMuc = 2)
BEGIN
    INSERT INTO LoaiSP (TenLoai, LoaiDanhMuc) VALUES
    (N'ASUS', 2), (N'Dell', 2), (N'HP', 2), (N'Lenovo', 2),
    (N'MSI', 2), (N'Acer', 2), (N'Apple', 2), (N'Gigabyte', 2), (N'Razer', 2);
END
GO

-- Bang lien ket san pham - nhieu danh muc
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'SanPham_Loai')
BEGIN
    CREATE TABLE SanPham_Loai (
        MaSP INT NOT NULL,
        MaLoai INT NOT NULL,
        PRIMARY KEY (MaSP, MaLoai),
        FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE,
        FOREIGN KEY (MaLoai) REFERENCES LoaiSP(MaLoai)
    );
END
GO

-- Chuyen du lieu MaLoai cu sang bang lien ket
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('SanPham') AND name = 'MaLoai')
BEGIN
    INSERT INTO SanPham_Loai (MaSP, MaLoai)
    SELECT sp.MaSP, sp.MaLoai FROM SanPham sp
    WHERE sp.MaLoai IS NOT NULL
      AND NOT EXISTS (SELECT 1 FROM SanPham_Loai sl WHERE sl.MaSP = sp.MaSP AND sl.MaLoai = sp.MaLoai);

    INSERT INTO SanPham_Loai (MaSP, MaLoai)
    SELECT sp.MaSP, lo.MaLoai FROM SanPham sp
    INNER JOIN LoaiSP lo ON lo.TenLoai = sp.HangSX AND lo.LoaiDanhMuc = 2
    WHERE NOT EXISTS (SELECT 1 FROM SanPham_Loai sl WHERE sl.MaSP = sp.MaSP AND sl.MaLoai = lo.MaLoai);

    DECLARE @fk NVARCHAR(200);
    SELECT @fk = name FROM sys.foreign_keys
    WHERE parent_object_id = OBJECT_ID('SanPham') AND referenced_object_id = OBJECT_ID('LoaiSP');
    IF @fk IS NOT NULL
        EXEC('ALTER TABLE SanPham DROP CONSTRAINT ' + @fk);

    ALTER TABLE SanPham DROP COLUMN MaLoai;
END
GO

-- Cap nhat ten nguoi dung co dau
UPDATE NguoiDung SET HoTen = N'Quản trị viên' WHERE TenDangNhap = N'admin';
UPDATE NguoiDung SET HoTen = N'Nguyễn Văn A' WHERE TenDangNhap = N'khach1';
GO

-- Them san pham moi (bo qua neu da ton tai theo ten)
INSERT INTO SanPham (TenSP, MoTa, Gia, SoLuong, HinhAnh, HangSX)
SELECT * FROM (VALUES
(N'Lenovo Legion 5 Pro', N'Laptop gaming Lenovo, RTX 4070, AMD Ryzen 7, RAM 16GB, man hinh 165Hz', 32990000, 12,
 N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', N'Lenovo'),
(N'ASUS TUF Gaming A15', N'Laptop gaming gia re, RTX 4050, Ryzen 5, RAM 16GB, SSD 512GB', 21990000, 18,
 N'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400', N'ASUS'),
(N'Dell Inspiron 14', N'Laptop van phong mong nhe, Intel Core i5, RAM 16GB, pin trau', 16990000, 22,
 N'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', N'Dell'),
(N'HP Envy x360', N'Laptop 2-in-1 cao cap, man hinh cam ung, AMD Ryzen 7, RAM 16GB', 24990000, 10,
 N'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', N'HP'),
(N'MSI Katana 15', N'Laptop gaming MSI, RTX 4060, Intel Core i7, RAM 16GB, ban phim RGB', 26990000, 14,
 N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', N'MSI'),
(N'Acer Swift 3', N'Laptop sinh vien nhe, Intel Core i5, RAM 8GB, SSD 512GB, vo nhom', 13990000, 28,
 N'https://images.unsplash.com/photo-1525547719570-a1d2b4b93489?w=400', N'Acer'),
(N'MacBook Pro 14 M3', N'MacBook Pro chip M3, RAM 18GB, SSD 512GB, man hinh Liquid Retina XDR', 45990000, 6,
 N'https://images.unsplash.com/photo-1611186871348-b1ce06e07c0f?w=400', N'Apple'),
(N'Lenovo ThinkPad E14', N'Laptop doanh nhan, Intel Core i5, RAM 16GB, ban phim ThinkPad', 18990000, 16,
 N'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400', N'Lenovo'),
(N'ASUS ZenBook 14', N'Laptop van phong cao cap, OLED, Intel Core i7, RAM 16GB, sieu mong', 23990000, 11,
 N'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400', N'ASUS'),
(N'Gigabyte Aorus 15', N'Laptop gaming cao cap, RTX 4080, Intel Core i9, RAM 32GB', 54990000, 5,
 N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', N'Gigabyte'),
(N'Razer Blade 15', N'Laptop gaming cao cap, RTX 4070, Intel Core i7, vo nhom CNC', 49990000, 7,
 N'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400', N'Razer'),
(N'HP Victus 16', N'Laptop gaming HP, RTX 3050, AMD Ryzen 5, RAM 16GB, man hinh 144Hz', 17990000, 20,
 N'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400', N'HP')
) AS t(TenSP, MoTa, Gia, SoLuong, HinhAnh, HangSX)
WHERE NOT EXISTS (SELECT 1 FROM SanPham sp WHERE sp.TenSP = t.TenSP);
GO

-- Gan danh muc cho tat ca san pham
DECLARE @MaSP INT, @Hang NVARCHAR(100), @TenSP NVARCHAR(200);

DECLARE cur CURSOR FOR SELECT MaSP, HangSX, TenSP FROM SanPham;
OPEN cur;
FETCH NEXT FROM cur INTO @MaSP, @Hang, @TenSP;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Gan thuong hieu
    INSERT INTO SanPham_Loai (MaSP, MaLoai)
    SELECT @MaSP, lo.MaLoai FROM LoaiSP lo
    WHERE lo.LoaiDanhMuc = 2 AND lo.TenLoai = @Hang
      AND NOT EXISTS (SELECT 1 FROM SanPham_Loai sl WHERE sl.MaSP = @MaSP AND sl.MaLoai = lo.MaLoai);

    -- Gan nhu cau theo ten san pham
    IF @TenSP LIKE N'%gaming%' OR @TenSP LIKE N'%ROG%' OR @TenSP LIKE N'%Nitro%' OR @TenSP LIKE N'%Legion%' OR @TenSP LIKE N'%TUF%' OR @TenSP LIKE N'%Katana%' OR @TenSP LIKE N'%Victus%' OR @TenSP LIKE N'%Aorus%' OR @TenSP LIKE N'%Blade%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai) SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Gaming'
        AND NOT EXISTS (SELECT 1 FROM SanPham_Loai sl WHERE sl.MaSP = @MaSP AND sl.MaLoai = LoaiSP.MaLoai);

    IF @TenSP LIKE N'%Creator%' OR @TenSP LIKE N'%MacBook Pro%' OR @TenSP LIKE N'%ZenBook%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai) SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Đồ họa'
        AND NOT EXISTS (SELECT 1 FROM SanPham_Loai sl WHERE sl.MaSP = @MaSP AND sl.MaLoai = LoaiSP.MaLoai);

    IF @TenSP LIKE N'%IdeaPad%' OR @TenSP LIKE N'%VivoBook%' OR @TenSP LIKE N'%Swift%' OR @TenSP LIKE N'%Inspiron 14%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai) SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Sinh viên'
        AND NOT EXISTS (SELECT 1 FROM SanPham_Loai sl WHERE sl.MaSP = @MaSP AND sl.MaLoai = LoaiSP.MaLoai);

    IF @TenSP LIKE N'%XPS%' OR @TenSP LIKE N'%ThinkPad%' OR @TenSP LIKE N'%Pavilion%' OR @TenSP LIKE N'%MacBook Air%' OR @TenSP LIKE N'%Envy%'
        INSERT INTO SanPham_Loai (MaSP, MaLoai) SELECT @MaSP, MaLoai FROM LoaiSP WHERE TenLoai = N'Văn phòng'
        AND NOT EXISTS (SELECT 1 FROM SanPham_Loai sl WHERE sl.MaSP = @MaSP AND sl.MaLoai = LoaiSP.MaLoai);

    FETCH NEXT FROM cur INTO @MaSP, @Hang, @TenSP;
END
CLOSE cur;
DEALLOCATE cur;
GO

PRINT N'Cap nhat da danh muc thanh cong!';
GO
