# Shop Laptop - ASP.NET Web Forms

Website bán laptop xây dựng bằng **ASP.NET Web Forms (.NET Framework 4.8)**, **SQL Server** và **Tailwind CSS**.

## Yêu cầu hệ thống

| Phần mềm | Phiên bản gợi ý |
|---|---|
| Windows | 10 / 11 |
| Visual Studio | 2022 (workload **ASP.NET and web development**) |
| SQL Server | SQL Server Express hoặc Developer Edition |
| SSMS | SQL Server Management Studio |

## Chạy dự án từ đầu (sau khi clone)

### Bước 1: Clone source code

```bash
git clone <url-repo>
cd ASPNET-DK24TTG7-LeHaiNam-ShopLaptop
```

### Bước 2: Tạo database

1. Mở **SQL Server Management Studio (SSMS)** và kết nối tới SQL Server (mặc định thường là `.\SQLEXPRESS`).
2. Mở file:

```
src/ShopLapTop/ShopLapTop/Database/CuaHangLapTop.sql
```

3. Nhấn **Execute** (F5) để chạy toàn bộ script.

Script sẽ tự động:
- Tạo database `CuaHangLapTop`
- Tạo bảng, khóa ngoại và nạp dữ liệu mẫu: danh mục, sản phẩm, tài khoản, đơn hàng

**Tài khoản test:**

| Vai trò | Tên đăng nhập | Mật khẩu |
|---|---|---|
| Quản trị viên | `admin` | `123456` |

> **Lưu ý:** File sql sẽ **xóa và tạo lại** database `CuaHangLapTop` nếu đã tồn tại. Chỉ chạy khi muốn reset dữ liệu về trạng thái ban đầu.

### Bước 3: Cấu hình chuỗi kết nối

Mở file `src/ShopLapTop/ShopLapTop/Web.config` và kiểm tra `connectionStrings`:

```xml
<add name="CuaHangLapTop"
     connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=CuaHangLapTop;Integrated Security=True"
     providerName="System.Data.SqlClient" />
```

### Bước 4: Mở solution và restore NuGet

1. Mở Visual Studio 2022.
2. Mở file solution:

```
src/ShopLapTop/ShopLapTop.slnx
```

### Bước 5: Build và chạy

1. Chọn cấu hình **Debug**.
2. Nhấn **F5** (hoặc **Ctrl+F5** để chạy không debug).
3. Trình duyệt sẽ mở trang chủ (thường là `https://localhost:44334/`).

## Chức năng chính

**Khách hàng:**
- Xem danh sách / chi tiết sản phẩm, lọc theo danh mục
- Đăng ký, đăng nhập, giỏ hàng, thanh toán
- Sửa thông tin cá nhân, đổi mật khẩu, xem lịch sử đơn hàng

**Quản trị viên** (đăng nhập `admin`):
- Dashboard thống kê
- Quản lý sản phẩm (upload ảnh, tối đa 5MB)
- Quản lý danh mục (upload ảnh)
- Quản lý đơn hàng

## Xử lý lỗi thường gặp

**Không kết nối được database**
- Kiểm tra SQL Server đang chạy (Services → `SQL Server (SQLEXPRESS)`).
- Kiểm tra `Data Source` trong `Web.config` khớp với instance SQL Server của bạn.

**Lỗi NuGet khi build**
- Mở Visual Studio → **Tools → NuGet Package Manager → Package Manager Console**.
- Chạy: `Update-Package -reinstall`

## Reset dữ liệu về ban đầu

Chạy lại file `src/ShopLapTop/ShopLapTop/Database/CuaHangLapTop.sql` trong SSMS. Toàn bộ dữ liệu sẽ được tạo lại từ đầu.
