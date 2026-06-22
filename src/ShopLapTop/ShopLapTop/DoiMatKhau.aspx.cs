using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class DoiMatKhau : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] == null)
            {
                Response.Redirect("DangNhap.aspx");
                return;
            }
        }

        protected void btnDoiMK_Click(object sender, EventArgs e)
        {
            string mkCu = txtMatKhauCu.Text.Trim();
            string mkMoi = txtMatKhauMoi.Text.Trim();
            string xacNhan = txtXacNhan.Text.Trim();

            if (string.IsNullOrEmpty(mkCu) || string.IsNullOrEmpty(mkMoi) || string.IsNullOrEmpty(xacNhan))
            {
                lblLoi.Text = "Vui lòng nhập đầy đủ thông tin!";
                lblLoi.Visible = true;
                lblThanhCong.Visible = false;
                return;
            }

            if (mkMoi != xacNhan)
            {
                lblLoi.Text = "Mật khẩu mới và xác nhận không khớp!";
                lblLoi.Visible = true;
                lblThanhCong.Visible = false;
                return;
            }

            if (mkMoi.Length < 6)
            {
                lblLoi.Text = "Mật khẩu mới phải có ít nhất 6 ký tự!";
                lblLoi.Visible = true;
                lblThanhCong.Visible = false;
                return;
            }

            int maND = Convert.ToInt32(Session["MaND"]);
            object mkLuu = KetNoi.LayGiaTri(
                "SELECT MatKhau FROM NguoiDung WHERE MaND = @id",
                new SqlParameter[] { new SqlParameter("@id", maND) });

            if (mkLuu == null || !MatKhauHelper.KiemTra(mkCu, mkLuu.ToString()))
            {
                lblLoi.Text = "Mật khẩu hiện tại không đúng!";
                lblLoi.Visible = true;
                lblThanhCong.Visible = false;
                return;
            }

            KetNoi.ThucThi(
                "UPDATE NguoiDung SET MatKhau = @mkMoi WHERE MaND = @id",
                new SqlParameter[] {
                    new SqlParameter("@mkMoi", MatKhauHelper.MaHoa(mkMoi)),
                    new SqlParameter("@id", maND)
                });

            txtMatKhauCu.Text = "";
            txtMatKhauMoi.Text = "";
            txtXacNhan.Text = "";
            lblThanhCong.Text = "Đổi mật khẩu thành công!";
            lblThanhCong.Visible = true;
            lblLoi.Visible = false;
        }
    }
}
