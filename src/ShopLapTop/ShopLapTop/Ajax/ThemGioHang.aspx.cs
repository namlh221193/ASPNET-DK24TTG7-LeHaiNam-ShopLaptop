using System;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace ShopLapTop.Ajax
{
    public partial class ThemGioHang : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "application/json";

            try
            {
                int maSP = Convert.ToInt32(Request.Form["maSP"]);
                string tenSP = Request.Form["tenSP"];
                decimal gia = Convert.ToDecimal(Request.Form["gia"]);
                string hinhAnh = Request.Form["hinhAnh"];
                int soLuong = Convert.ToInt32(Request.Form["soLuong"]);

                if (soLuong < 1) soLuong = 1;

                GioHangHelper.ThemVaoGio(maSP, tenSP, gia, hinhAnh, soLuong);

                var ketQua = new
                {
                    success = true,
                    soLuong = GioHangHelper.DemSoLuong(),
                    message = "Đã thêm vào giỏ hàng"
                };

                Response.Write(new JavaScriptSerializer().Serialize(ketQua));
            }
            catch
            {
                var loi = new { success = false, message = "Lỗi thêm giỏ hàng" };
                Response.Write(new JavaScriptSerializer().Serialize(loi));
            }
            Response.End();
        }
    }
}
