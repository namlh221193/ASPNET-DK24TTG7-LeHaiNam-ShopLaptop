USE CuaHangLapTop;
GO

-- ===== Them cot HinhAnh vao LoaiSP =====
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='LoaiSP' AND COLUMN_NAME='HinhAnh')
    ALTER TABLE LoaiSP ADD HinhAnh nvarchar(200) NULL;
GO

-- ===== Fix LoaiSP.TenLoai (biet chinh xac MaLoai) =====
UPDATE LoaiSP SET TenLoai = N'Văn phòng' WHERE MaLoai = 2;
UPDATE LoaiSP SET TenLoai = N'Sinh viên'  WHERE MaLoai = 3;
UPDATE LoaiSP SET TenLoai = N'Đồ họa'    WHERE MaLoai = 4;
GO

-- ===== Fix NguoiDung.HoTen =====
UPDATE NguoiDung SET HoTen = N'Quản trị viên' WHERE MaND = 1;
UPDATE NguoiDung SET HoTen = N'Nguyễn Văn A'  WHERE MaND = 2;
GO

-- ===== Fix DonHang.TrangThai (chi co 1 gia tri dang ton tai) =====
UPDATE DonHang SET TrangThai = N'Chờ xử lý'
    WHERE TrangThai NOT IN (N'Chờ xử lý', N'Đang giao', N'Đã giao', N'Đã hủy');
GO

-- ===== Kiem tra lai sau khi fix =====
PRINT N'--- LoaiSP ---';
SELECT MaLoai, TenLoai, LoaiDanhMuc FROM LoaiSP ORDER BY LoaiDanhMuc, MaLoai;
PRINT N'--- NguoiDung ---';
SELECT MaND, HoTen, VaiTro FROM NguoiDung;
PRINT N'--- DonHang TrangThai ---';
SELECT DISTINCT TrangThai FROM DonHang;
PRINT N'--- Fix hoan tat! ---';
