using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class ChiTiet : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (string.IsNullOrEmpty(id))
                {
                    HienThiLoi();
                    return;
                }

                string sql = "SELECT * FROM SanPham WHERE MaSP = @id";
                DataTable dt = KetNoi.LayDuLieu(sql, new SqlParameter[] { new SqlParameter("@id", id) });

                if (dt.Rows.Count == 0)
                {
                    HienThiLoi();
                    return;
                }

                DataRow row = dt.Rows[0];
                int maSP = Convert.ToInt32(row["MaSP"]);

                imgSP.ImageUrl = row["HinhAnh"].ToString();
                litTenSP.Text = row["TenSP"].ToString();
                litGia.Text = string.Format("{0:N0}", row["Gia"]);
                litSoLuong.Text = row["SoLuong"].ToString();
                litMoTa.Text = row["MoTa"].ToString();

                // Hien thi the danh muc
                DataTable dtLoai = KetNoi.LayDuLieu(
                    @"SELECT lo.TenLoai, lo.LoaiDanhMuc FROM SanPham_Loai sl
                      INNER JOIN LoaiSP lo ON sl.MaLoai = lo.MaLoai
                      WHERE sl.MaSP = @id ORDER BY lo.LoaiDanhMuc",
                    new SqlParameter[] { new SqlParameter("@id", maSP) });

                string nhuCau = "", thuongHieu = "";
                foreach (DataRow lo in dtLoai.Rows)
                {
                    if (Convert.ToInt32(lo["LoaiDanhMuc"]) == DanhMucHelper.NhuCau)
                        nhuCau += (nhuCau.Length > 0 ? ", " : "") + lo["TenLoai"];
                    else
                        thuongHieu += (thuongHieu.Length > 0 ? ", " : "") + lo["TenLoai"];
                }

                litTheLoai.Text = DanhMucHelper.TaoHTMLTheLoai(nhuCau, "bg-blue-50", "text-blue-700")
                    + DanhMucHelper.TaoHTMLTheLoai(thuongHieu, "bg-violet-50", "text-violet-700");

                hfMaSP.Value = maSP.ToString();
                hfTenSP.Value = row["TenSP"].ToString();
                hfGia.Value = row["Gia"].ToString();
                hfHinhAnh.Value = row["HinhAnh"].ToString();
            }
        }

        void HienThiLoi()
        {
            pnlChiTiet.Visible = false;
            pnlKhongTimThay.Visible = true;
        }
    }
}
