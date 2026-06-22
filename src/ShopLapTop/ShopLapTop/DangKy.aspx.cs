using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class DangKy : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] != null)
                Response.Redirect("Default.aspx");
        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            string tenDN = txtTenDN.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            if (string.IsNullOrEmpty(tenDN) || string.IsNullOrEmpty(matKhau))
            {
                lblLoi.Text = "Vui lòng nhập tên đăng nhập và mật khẩu!";
                lblLoi.Visible = true;
                return;
            }

            object tonTai = KetNoi.LayGiaTri(
                "SELECT COUNT(*) FROM NguoiDung WHERE TenDangNhap = @ten",
                new SqlParameter[] { new SqlParameter("@ten", tenDN) });

            if (Convert.ToInt32(tonTai) > 0)
            {
                lblLoi.Text = "Tên đăng nhập đã tồn tại!";
                lblLoi.Visible = true;
                return;
            }

            KetNoi.ThucThi(
                @"INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, SDT, VaiTro) 
                  VALUES (@ten, @mk, @hoten, @email, @sdt, 0)",
                new SqlParameter[] {
                    new SqlParameter("@ten", tenDN),
                    new SqlParameter("@mk", MatKhauHelper.MaHoa(matKhau)),
                    new SqlParameter("@hoten", txtHoTen.Text.Trim()),
                    new SqlParameter("@email", txtEmail.Text.Trim()),
                    new SqlParameter("@sdt", txtSDT.Text.Trim())
                });

            lblThanhCong.Text = "Đăng ký thành công! <a href='DangNhap.aspx' class='underline font-medium'>Đăng nhập ngay</a>";
            lblThanhCong.Visible = true;
            lblLoi.Visible = false;
        }
    }
}
