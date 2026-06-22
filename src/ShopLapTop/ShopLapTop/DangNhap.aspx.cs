using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class DangNhap : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] != null)
                Response.Redirect("Default.aspx");
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string tenDN = txtTenDN.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            if (string.IsNullOrEmpty(tenDN) || string.IsNullOrEmpty(matKhau))
            {
                lblLoi.Text = "Vui lòng nhập đầy đủ thông tin!";
                lblLoi.Visible = true;
                return;
            }

            string sql = "SELECT * FROM NguoiDung WHERE TenDangNhap = @ten";
            DataTable dt = KetNoi.LayDuLieu(sql, new SqlParameter[] {
                new SqlParameter("@ten", tenDN)
            });

            if (dt.Rows.Count == 0)
            {
                lblLoi.Text = "Tên đăng nhập hoặc mật khẩu không đúng!";
                lblLoi.Visible = true;
                return;
            }

            DataRow row = dt.Rows[0];
            string matKhauLuu = row["MatKhau"].ToString();

            if (!MatKhauHelper.KiemTra(matKhau, matKhauLuu))
            {
                lblLoi.Text = "Tên đăng nhập hoặc mật khẩu không đúng!";
                lblLoi.Visible = true;
                return;
            }

            // Tài khoản cũ lưu mật khẩu thuần → tự nâng cấp lên dạng mã hóa
            if (!MatKhauHelper.DaDuocMaHoa(matKhauLuu))
            {
                KetNoi.ThucThi(
                    "UPDATE NguoiDung SET MatKhau = @mk WHERE MaND = @id",
                    new SqlParameter[] {
                        new SqlParameter("@mk", MatKhauHelper.MaHoa(matKhau)),
                        new SqlParameter("@id", row["MaND"])
                    });
            }

            Session["MaND"] = row["MaND"];
            Session["TenDangNhap"] = row["TenDangNhap"];
            Session["HoTen"] = row["HoTen"];
            Session["VaiTro"] = row["VaiTro"];

            if (Convert.ToInt32(row["VaiTro"]) == 1)
                Response.Redirect("Admin/Default.aspx");
            else
                Response.Redirect("Default.aspx");
        }
    }
}
