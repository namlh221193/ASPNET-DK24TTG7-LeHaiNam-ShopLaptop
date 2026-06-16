using System;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class DatHangThanhCong : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string maDH = Request.QueryString["maDH"];
            litMaDH.Text = string.IsNullOrEmpty(maDH) ? "?" : maDH;
        }
    }
}
