using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopLapTop
{
    public partial class LichSuDonHang : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] == null)
            {
                Response.Redirect("DangNhap.aspx");
                return;
            }

            if (!IsPostBack)
                LoadDonHang();
        }

        void LoadDonHang()
        {
            int maND = Convert.ToInt32(Session["MaND"]);
            DataTable dt = KetNoi.LayDuLieu(
                @"SELECT MaDH, NgayDat, TongTien, TrangThai, DiaChi, SDT
                  FROM DonHang WHERE MaND = @id ORDER BY NgayDat DESC",
                new SqlParameter[] { new SqlParameter("@id", maND) });

            if (dt.Rows.Count == 0)
            {
                pnlRong.Visible = true;
                rptDonHang.Visible = false;
                return;
            }

            rptDonHang.DataSource = dt;
            rptDonHang.DataBind();
        }

        protected void rptDonHang_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
                return;

            DataRowView row = (DataRowView)e.Item.DataItem;
            int maDH = Convert.ToInt32(row["MaDH"]);

            Repeater rptChiTiet = (Repeater)e.Item.FindControl("rptChiTiet");
            DataTable dtChiTiet = KetNoi.LayDuLieu(
                @"SELECT sp.TenSP, ct.SoLuong, ct.DonGia, ct.SoLuong * ct.DonGia AS ThanhTien
                  FROM ChiTietDonHang ct
                  INNER JOIN SanPham sp ON ct.MaSP = sp.MaSP
                  WHERE ct.MaDH = @maDH",
                new SqlParameter[] { new SqlParameter("@maDH", maDH) });

            rptChiTiet.DataSource = dtChiTiet;
            rptChiTiet.DataBind();
        }

        protected string GetTrangThaiClass(string trangThai)
        {
            switch (trangThai)
            {
                case "Chờ xử lý": return "px-2.5 py-1 rounded-full text-xs font-medium bg-yellow-50 text-yellow-700";
                case "Đang giao":  return "px-2.5 py-1 rounded-full text-xs font-medium bg-blue-50 text-blue-700";
                case "Đã giao":    return "px-2.5 py-1 rounded-full text-xs font-medium bg-emerald-50 text-emerald-700";
                case "Đã huỷ":    return "px-2.5 py-1 rounded-full text-xs font-medium bg-red-50 text-red-700";
                default:           return "px-2.5 py-1 rounded-full text-xs font-medium bg-slate-100 text-slate-600";
            }
        }
    }
}
