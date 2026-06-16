using System;
using System.Web.UI;

namespace ShopLapTop.Admin
{
    public class AdminMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null || Convert.ToInt32(Session["VaiTro"]) != 1)
            {
                Response.Redirect(ResolveUrl("~/DangNhap.aspx"));
                return;
            }

            litTenAdmin.Text = Session["HoTen"]?.ToString() ?? "Admin";
            litSoSP.Text = KetNoi.LayGiaTri("SELECT COUNT(*) FROM SanPham", null)?.ToString() ?? "0";
            litDHCho.Text = KetNoi.LayGiaTri(
                "SELECT COUNT(*) FROM DonHang WHERE TrangThai = N'Chờ xử lý'", null)?.ToString() ?? "0";
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect(ResolveUrl("~/DangNhap.aspx"));
        }

        protected string GetNavClass(string pageName)
        {
            string currentPage = System.IO.Path.GetFileName(Page.Request.FilePath);
            bool isActive = currentPage.Equals(pageName, StringComparison.OrdinalIgnoreCase);
            string baseClass = "flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-medium transition-all w-full ";
            return isActive
                ? baseClass + "bg-white/15 text-white"
                : baseClass + "text-slate-400 hover:text-white hover:bg-white/8";
        }

        protected global::System.Web.UI.WebControls.Literal litTenAdmin;
        protected global::System.Web.UI.WebControls.Literal litSoSP;
        protected global::System.Web.UI.WebControls.Literal litDHCho;
        protected global::System.Web.UI.WebControls.LinkButton btnDangXuat;
    }
}
