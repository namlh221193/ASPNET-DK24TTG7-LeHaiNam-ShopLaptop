using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web.UI;

namespace ShopLapTop.Admin
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null || Convert.ToInt32(Session["VaiTro"]) != 1)
            {
                Response.Redirect(ResolveUrl("~/DangNhap.aspx"));
                return;
            }

            if (!IsPostBack)
            {
                LoadStats();
                LoadChartData();
            }
        }

        void LoadStats()
        {
            litTongSP.Text = KetNoi.LayGiaTri("SELECT COUNT(*) FROM SanPham", null)?.ToString() ?? "0";
            litTongDH.Text = KetNoi.LayGiaTri("SELECT COUNT(*) FROM DonHang", null)?.ToString() ?? "0";
            litDHCho.Text  = KetNoi.LayGiaTri(
                "SELECT COUNT(*) FROM DonHang WHERE TrangThai = N'Chờ xử lý'", null)?.ToString() ?? "0";

            object tongTien = KetNoi.LayGiaTri("SELECT ISNULL(SUM(TongTien),0) FROM DonHang", null);
            decimal dt = tongTien != null ? Convert.ToDecimal(tongTien) : 0;
            litDoanhThu.Text = string.Format("{0:N0}", dt) + " đ";
        }

        void LoadChartData()
        {
            // 1. Revenue last 7 days
            DataTable dtDoanhThu = KetNoi.LayDuLieu(@"
                SELECT CAST(NgayDat AS DATE) AS Ngay,
                       ISNULL(SUM(TongTien)/1000000.0, 0) AS TrieuDong
                FROM DonHang
                WHERE NgayDat >= DATEADD(DAY, -6, CAST(GETDATE() AS DATE))
                GROUP BY CAST(NgayDat AS DATE)");

            var dtLabels = new List<string>();
            var dtData   = new List<string>();
            for (int i = 6; i >= 0; i--)
            {
                DateTime d = DateTime.Today.AddDays(-i);
                dtLabels.Add(d.ToString("dd/MM"));
                decimal val = 0;
                foreach (DataRow row in dtDoanhThu.Rows)
                {
                    if (Convert.ToDateTime(row["Ngay"]).Date == d.Date)
                    {
                        val = Convert.ToDecimal(row["TrieuDong"]);
                        break;
                    }
                }
                dtData.Add(val.ToString("F1", System.Globalization.CultureInfo.InvariantCulture));
            }

            // 2. Order status distribution
            DataTable dtTrangThai = KetNoi.LayDuLieu(
                "SELECT TrangThai, COUNT(*) AS SoDon FROM DonHang GROUP BY TrangThai");
            var ttLabels = new List<string>();
            var ttData   = new List<string>();
            foreach (DataRow row in dtTrangThai.Rows)
            {
                ttLabels.Add(row["TrangThai"].ToString().Replace("'", "\\'"));
                ttData.Add(row["SoDon"].ToString());
            }
            if (ttLabels.Count == 0) { ttLabels.Add("Chưa có"); ttData.Add("0"); }

            // 3. Top 5 products by sold quantity
            DataTable dtTopSP = KetNoi.LayDuLieu(@"
                SELECT TOP 5 sp.TenSP,
                       ISNULL(SUM(ct.SoLuong), 0) AS SoLuongBan
                FROM SanPham sp
                LEFT JOIN ChiTietDonHang ct ON sp.MaSP = ct.MaSP
                GROUP BY sp.MaSP, sp.TenSP
                ORDER BY SoLuongBan DESC");

            var topLabels = new List<string>();
            var topData   = new List<string>();
            foreach (DataRow row in dtTopSP.Rows)
            {
                string ten = row["TenSP"].ToString();
                // Shorten long names
                if (ten.Length > 18) ten = ten.Substring(0, 16) + "..";
                topLabels.Add(ten.Replace("'", "\\'"));
                topData.Add(row["SoLuongBan"].ToString());
            }

            // Build JSON
            var sb = new StringBuilder();
            sb.Append("<script>window.__chartData={");
            sb.AppendFormat("doanhThu:{{labels:[{0}],data:[{1}]}},",
                string.Join(",", dtLabels.ConvertAll(l => $"'{l}'")),
                string.Join(",", dtData));
            sb.AppendFormat("trangThai:{{labels:[{0}],data:[{1}]}},",
                string.Join(",", ttLabels.ConvertAll(l => $"'{l}'")),
                string.Join(",", ttData));
            sb.AppendFormat("topSP:{{labels:[{0}],data:[{1}]}}",
                string.Join(",", topLabels.ConvertAll(l => $"'{l}'")),
                string.Join(",", topData));
            sb.Append("};</script>");

            litChartData.Text = sb.ToString();
        }
    }
}
