using System;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class SiteMaster : MasterPage
    {
        public int SoLuongGioHang
        {
            get { return GioHangHelper.DemSoLuong(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] != null)
            {
                pnlChuaDangNhap.Visible = false;
                pnlDaDangNhap.Visible = true;
                litTenND.Text = Session["HoTen"] != null ? Session["HoTen"].ToString() : Session["TenDangNhap"].ToString();

                if (Session["VaiTro"] != null && Convert.ToInt32(Session["VaiTro"]) == 1)
                    pnlAdmin.Visible = true;
            }
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
    }
}
