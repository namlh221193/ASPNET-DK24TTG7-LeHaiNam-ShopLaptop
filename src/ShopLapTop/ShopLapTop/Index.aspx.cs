using System;
using System.Data;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class Index : Page
    {
        public string MaLoaiGaming { get; private set; } = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                LoadDanhMuc();
                LoadNoiBat();
                LoadMoiNhat();
            }
        }

        void LoadStats()
        {
            litTongSP.Text = KetNoi.LayGiaTri("SELECT COUNT(*) FROM SanPham", null).ToString();
            litTongThuongHieu.Text = KetNoi.LayGiaTri(
                "SELECT COUNT(*) FROM LoaiSP WHERE LoaiDanhMuc = 2", null).ToString();
        }

        void LoadDanhMuc()
        {
            string sql = @"SELECT lo.MaLoai, lo.TenLoai,
                               ISNULL(lo.HinhAnh, 'Images/prod-gaming1.jpg') AS HinhAnh,
                               COUNT(sl.MaSP) AS SoSP
                           FROM LoaiSP lo
                           LEFT JOIN SanPham_Loai sl ON lo.MaLoai = sl.MaLoai
                           WHERE lo.LoaiDanhMuc = 1
                           GROUP BY lo.MaLoai, lo.TenLoai, lo.HinhAnh
                           ORDER BY lo.MaLoai";

            DataTable dt = KetNoi.LayDuLieu(sql);
            rptDanhMuc.DataSource = dt;
            rptDanhMuc.DataBind();

            // Lay MaLoai cua Gaming de dung cho nut hero
            foreach (DataRow row in dt.Rows)
            {
                if (row["TenLoai"].ToString() == "Gaming")
                {
                    MaLoaiGaming = row["MaLoai"].ToString();
                    break;
                }
            }
        }

        void LoadNoiBat()
        {
            string sql = @"SELECT TOP 8 sp.MaSP, sp.TenSP, sp.Gia, sp.HinhAnh,
                STUFF((SELECT N', ' + lo.TenLoai FROM SanPham_Loai sl
                       INNER JOIN LoaiSP lo ON sl.MaLoai = lo.MaLoai
                       WHERE sl.MaSP = sp.MaSP AND lo.LoaiDanhMuc = 2
                       FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'), 1, 2, '') AS ThuongHieu
                FROM SanPham sp ORDER BY sp.Gia DESC";

            rptNoiBat.DataSource = KetNoi.LayDuLieu(sql);
            rptNoiBat.DataBind();
        }

        void LoadMoiNhat()
        {
            string sql = @"SELECT TOP 3 sp.MaSP, sp.TenSP, sp.Gia, sp.HinhAnh,
                STUFF((SELECT N', ' + lo.TenLoai FROM SanPham_Loai sl
                       INNER JOIN LoaiSP lo ON sl.MaLoai = lo.MaLoai
                       WHERE sl.MaSP = sp.MaSP AND lo.LoaiDanhMuc = 2
                       FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'), 1, 2, '') AS ThuongHieu
                FROM SanPham sp ORDER BY sp.MaSP DESC";

            rptMoiNhat.DataSource = KetNoi.LayDuLieu(sql);
            rptMoiNhat.DataBind();
        }

        protected string GetDanhMucBgStyle(object hinhAnh)
        {
            string img = hinhAnh != null && !string.IsNullOrEmpty(hinhAnh.ToString())
                ? hinhAnh.ToString()
                : "Images/prod-gaming1.jpg";
            return "background-image:url(" + img + ")";
        }
    }
}
