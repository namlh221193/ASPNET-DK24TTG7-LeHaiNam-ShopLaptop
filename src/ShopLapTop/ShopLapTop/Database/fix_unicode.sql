-- Fix toan bo tieng Viet trong database
USE CuaHangLapTop;
GO

-- Fix danh muc (co the bi loi do encoding khi chay script cu)
UPDATE LoaiSP SET TenLoai = N'Văn phòng' WHERE TenLoai LIKE N'%n ph%ng%' OR TenLoai = N'Van phong' OR TenLoai = N'V?n ph?ng';
UPDATE LoaiSP SET TenLoai = N'Sinh viên' WHERE TenLoai LIKE N'Sinh vi%n' AND TenLoai != N'Sinh viên';
UPDATE LoaiSP SET TenLoai = N'Đồ họa' WHERE TenLoai LIKE N'%h%a%' AND LoaiDanhMuc = 1 AND TenLoai != N'Đồ họa';
GO

-- Fix mo ta san pham - them dau tieng Viet
UPDATE SanPham SET MoTa = N'Laptop gaming mạnh mẽ, RTX 4060, Intel Core i7 Gen 13, RAM 16GB, SSD 512GB, màn hình 165Hz' WHERE TenSP = N'ASUS ROG Strix G16';
UPDATE SanPham SET MoTa = N'Laptop cao cấp cho doanh nhân, màn hình OLED 3.5K, Intel Core i7, RAM 16GB, SSD 512GB' WHERE TenSP = N'Dell XPS 15';
UPDATE SanPham SET MoTa = N'Laptop văn phòng giá rẻ, AMD Ryzen 5, RAM 8GB, SSD 256GB, thiết kế gọn nhẹ' WHERE TenSP = N'HP Pavilion 15';
UPDATE SanPham SET MoTa = N'Laptop sinh viên lý tưởng, Intel Core i5, RAM 8GB, SSD 512GB, nhẹ và bền bỉ' WHERE TenSP = N'Lenovo IdeaPad 3';
UPDATE SanPham SET MoTa = N'Laptop đồ họa chuyên nghiệp, RTX 3070 Ti, màn hình 16 inch 2K, thiết kế sang trọng' WHERE TenSP = N'MSI Creator Z16';
UPDATE SanPham SET MoTa = N'Laptop gaming giá tốt, RTX 3050, Intel Core i5, RAM 16GB, tản nhiệt hiệu quả' WHERE TenSP = N'Acer Nitro 5';
UPDATE SanPham SET MoTa = N'Apple MacBook Air chip M2, RAM 8GB, SSD 256GB, siêu mỏng nhẹ, pin 18 giờ' WHERE TenSP = N'MacBook Air M2';
UPDATE SanPham SET MoTa = N'Laptop học tập đa năng, Intel Core i3, RAM 8GB, SSD 256GB, phù hợp sinh viên' WHERE TenSP = N'ASUS VivoBook 15';
UPDATE SanPham SET MoTa = N'Laptop gaming Lenovo, RTX 4070, AMD Ryzen 7, RAM 16GB, màn hình 165Hz, hiệu năng cao' WHERE TenSP = N'Lenovo Legion 5 Pro';
UPDATE SanPham SET MoTa = N'Laptop gaming giá rẻ từ ASUS, RTX 4050, Ryzen 5, RAM 16GB, SSD 512GB, vỏ nhôm' WHERE TenSP = N'ASUS TUF Gaming A15';
UPDATE SanPham SET MoTa = N'Laptop văn phòng mỏng nhẹ, Intel Core i5, RAM 16GB, pin trâu 12 giờ' WHERE TenSP = N'Dell Inspiron 14';
UPDATE SanPham SET MoTa = N'Laptop 2-in-1 cao cấp, màn hình cảm ứng, AMD Ryzen 7, RAM 16GB, xoay gập 360°' WHERE TenSP = N'HP Envy x360';
UPDATE SanPham SET MoTa = N'Laptop gaming MSI tầm trung, RTX 4060, Intel Core i7, RAM 16GB, bàn phím RGB đẹp' WHERE TenSP = N'MSI Katana 15';
UPDATE SanPham SET MoTa = N'Laptop sinh viên vỏ nhôm, Intel Core i5, RAM 8GB, SSD 512GB, nhẹ chỉ 1.5kg' WHERE TenSP = N'Acer Swift 3';
UPDATE SanPham SET MoTa = N'MacBook Pro chip M3, RAM 18GB, SSD 512GB, màn hình Liquid Retina XDR, hiệu năng đỉnh' WHERE TenSP = N'MacBook Pro 14 M3';
UPDATE SanPham SET MoTa = N'Laptop doanh nhân bền bỉ, Intel Core i5, RAM 16GB, bàn phím ThinkPad huyền thoại' WHERE TenSP = N'Lenovo ThinkPad E14';
UPDATE SanPham SET MoTa = N'Laptop văn phòng cao cấp, màn hình OLED, Intel Core i7, RAM 16GB, siêu mỏng 14mm' WHERE TenSP = N'ASUS ZenBook 14';
UPDATE SanPham SET MoTa = N'Laptop gaming cao cấp Gigabyte, RTX 4080, Intel Core i9, RAM 32GB, hiệu năng khủng' WHERE TenSP = N'Gigabyte Aorus 15';
UPDATE SanPham SET MoTa = N'Laptop gaming cao cấp Razer, RTX 4070, Intel Core i7, vỏ nhôm CNC, thiết kế tối giản' WHERE TenSP = N'Razer Blade 15';
UPDATE SanPham SET MoTa = N'Laptop gaming HP, RTX 3050, AMD Ryzen 5, RAM 16GB, màn hình 144Hz, giá tốt' WHERE TenSP = N'HP Victus 16';
GO

-- Fix trang thai don hang co the bi loi
UPDATE DonHang SET TrangThai = N'Chờ xử lý' WHERE TrangThai IN (N'Cho xu ly', N'Ch? x? lý', N'Ch? x? ly');
UPDATE DonHang SET TrangThai = N'Đang giao'  WHERE TrangThai IN (N'Dang giao', N'?ang giao');
UPDATE DonHang SET TrangThai = N'Đã giao'    WHERE TrangThai IN (N'Da giao', N'?ã giao');
UPDATE DonHang SET TrangThai = N'Đã hủy'     WHERE TrangThai IN (N'Da huy', N'?ã h?y');
GO

PRINT N'Fix Unicode hoàn tất!';
