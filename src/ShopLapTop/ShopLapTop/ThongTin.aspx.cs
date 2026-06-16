using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class ThongTin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] == null)
            {
                Response.Redirect("DangNhap.aspx");
                return;
            }

            if (!IsPostBack)
                LoadThongTin();
        }

        void LoadThongTin()
        {
            int maND = Convert.ToInt32(Session["MaND"]);
            var dt = KetNoi.LayDuLieu(
                "SELECT TenDangNhap, HoTen, Email, SDT FROM NguoiDung WHERE MaND = @id",
                new SqlParameter[] { new SqlParameter("@id", maND) });

            if (dt.Rows.Count > 0)
            {
                var row = dt.Rows[0];
                litTenDN.Text = row["TenDangNhap"].ToString();
                txtHoTen.Text = row["HoTen"].ToString();
                txtEmail.Text = row["Email"].ToString();
                txtSDT.Text = row["SDT"].ToString();
            }
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            int maND = Convert.ToInt32(Session["MaND"]);
            string hoTen = txtHoTen.Text.Trim();
            string email = txtEmail.Text.Trim();
            string sdt = txtSDT.Text.Trim();

            KetNoi.ThucThi(
                "UPDATE NguoiDung SET HoTen = @ht, Email = @em, SDT = @sdt WHERE MaND = @id",
                new SqlParameter[] {
                    new SqlParameter("@ht", hoTen),
                    new SqlParameter("@em", email),
                    new SqlParameter("@sdt", sdt),
                    new SqlParameter("@id", maND)
                });

            Session["HoTen"] = hoTen;
            lblThanhCong.Text = "Cập nhật thông tin thành công!";
            lblThanhCong.Visible = true;
            lblLoi.Visible = false;
        }
    }
}
