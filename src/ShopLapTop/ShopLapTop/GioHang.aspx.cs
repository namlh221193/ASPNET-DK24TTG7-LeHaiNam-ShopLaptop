using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopLapTop
{
    public partial class GioHang : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadGioHang();
        }

        void LoadGioHang()
        {
            List<GioHangItem> gio = GioHangHelper.LayGioHang();
            if (gio.Count == 0)
            {
                pnlCoHang.Visible = false;
                pnlTrong.Visible = true;
                return;
            }

            rptGioHang.DataSource = gio;
            rptGioHang.DataBind();
            litTongTien.Text = string.Format("{0:N0}", GioHangHelper.TinhTongTien());
        }

        protected void rptGioHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Xoa")
            {
                int maSP = Convert.ToInt32(e.CommandArgument);
                GioHangHelper.XoaKhoiGio(maSP);
                LoadGioHang();
            }
        }
    }
}
