using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace ShopLapTop
{
    public partial class ProductList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string kw = Request.QueryString["kw"] ?? "";
                if (!string.IsNullOrEmpty(kw))
                    txtTimKiem.Text = kw;

                string loaiQS = Request.QueryString["loai"] ?? "0";
                if (loaiQS != "0" && loaiQS != "")
                    hfMaLoai.Value = loaiQS;

                string sortQS = Request.QueryString["sort"] ?? "";
                if (sortQS == "moi")
                    ddlSapXep.SelectedValue = "moi";

                LoadAndSearch();
            }
            else
            {
                LoadSidebar();
            }
        }

        void LoadAndSearch()
        {
            LoadSidebar();
            TimKiem();
        }

        void LoadSidebar()
        {
            rptNhuCau.DataSource = KetNoi.LayDuLieu(
                "SELECT MaLoai, TenLoai, ISNULL(HinhAnh,'') AS HinhAnh FROM LoaiSP WHERE LoaiDanhMuc = 1 ORDER BY MaLoai");
            rptNhuCau.DataBind();

            rptThuongHieu.DataSource = KetNoi.LayDuLieu(
                "SELECT MaLoai, TenLoai FROM LoaiSP WHERE LoaiDanhMuc = 2 ORDER BY MaLoai");
            rptThuongHieu.DataBind();

            rptNhuCauMobile.DataSource = KetNoi.LayDuLieu(
                "SELECT MaLoai, TenLoai, ISNULL(HinhAnh,'') AS HinhAnh FROM LoaiSP WHERE LoaiDanhMuc = 1 ORDER BY MaLoai");
            rptNhuCauMobile.DataBind();

            int giaBand = 0;
            int.TryParse(hfGiaBand.Value, out giaBand);

            string baseClass = "block w-full text-left px-3 py-2 rounded-lg text-sm transition ";
            string activePrice = baseClass + "filter-price-active";
            string inactivePrice = baseClass + "text-slate-600 hover:bg-slate-50";

            btnGia0.CssClass = giaBand == 0 ? activePrice : inactivePrice;
            btnGia1.CssClass = giaBand == 1 ? activePrice : inactivePrice;
            btnGia2.CssClass = giaBand == 2 ? activePrice : inactivePrice;
            btnGia3.CssClass = giaBand == 3 ? activePrice : inactivePrice;
            btnGia4.CssClass = giaBand == 4 ? activePrice : inactivePrice;

            int maLoai = 0;
            int.TryParse(hfMaLoai.Value, out maLoai);

            string baseTatCa = "block w-full text-left px-3 py-2 rounded-lg text-sm transition ";
            btnTatCaNhuCau.CssClass = maLoai == 0 ? baseTatCa + "filter-active" : baseTatCa + "text-slate-600 hover:bg-slate-50";
            btnTatCaThuongHieu.CssClass = maLoai == 0 ? baseTatCa + "filter-brand-active" : baseTatCa + "text-slate-600 hover:bg-slate-50";
        }

        void TimKiem()
        {
            string kw = txtTimKiem.Text.Trim();
            int maLoai = 0;
            int.TryParse(hfMaLoai.Value, out maLoai);
            int giaBand = 0;
            int.TryParse(hfGiaBand.Value, out giaBand);
            string sapXep = ddlSapXep.SelectedValue;

            var where = new List<string>();
            var pms = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(kw))
            {
                where.Add("(sp.TenSP LIKE @kw OR sp.HangSX LIKE @kw OR sp.MoTa LIKE @kw)");
                pms.Add(new SqlParameter("@kw", "%" + kw + "%"));
            }

            if (maLoai > 0)
            {
                where.Add("sp.MaSP IN (SELECT MaSP FROM SanPham_Loai WHERE MaLoai = @maLoai)");
                pms.Add(new SqlParameter("@maLoai", maLoai));
            }

            switch (giaBand)
            {
                case 1: where.Add("sp.Gia < 10000000"); break;
                case 2: where.Add("sp.Gia BETWEEN 10000000 AND 20000000"); break;
                case 3: where.Add("sp.Gia BETWEEN 20000000 AND 35000000"); break;
                case 4: where.Add("sp.Gia > 35000000"); break;
            }

            string order = sapXep == "gia-tang" ? "sp.Gia ASC"
                         : sapXep == "gia-giam" ? "sp.Gia DESC"
                         : sapXep == "ten-az"   ? "sp.TenSP ASC"
                         : "sp.MaSP DESC";

            string sql = @"SELECT sp.MaSP, sp.TenSP, sp.Gia, sp.HinhAnh, sp.SoLuong,
                STUFF((SELECT N', ' + lo.TenLoai FROM SanPham_Loai sl
                       INNER JOIN LoaiSP lo ON sl.MaLoai = lo.MaLoai
                       WHERE sl.MaSP = sp.MaSP AND lo.LoaiDanhMuc = 1
                       FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'), 1, 2, '') AS NhuCau,
                STUFF((SELECT N', ' + lo.TenLoai FROM SanPham_Loai sl
                       INNER JOIN LoaiSP lo ON sl.MaLoai = lo.MaLoai
                       WHERE sl.MaSP = sp.MaSP AND lo.LoaiDanhMuc = 2
                       FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'), 1, 2, '') AS ThuongHieu
                FROM SanPham sp";

            if (where.Count > 0)
                sql += " WHERE " + string.Join(" AND ", where);

            sql += " ORDER BY " + order;

            DataTable dt = KetNoi.LayDuLieu(sql, pms.Count > 0 ? pms.ToArray() : null);
            rptSanPham.DataSource = dt;
            rptSanPham.DataBind();
            litSoSP.Text = dt.Rows.Count.ToString();
            pnlKhongCoSP.Visible = dt.Rows.Count == 0;

            // Display active filter summary
            var parts = new List<string>();
            if (!string.IsNullOrEmpty(kw)) parts.Add("từ khóa <b>" + kw + "</b>");
            if (maLoai > 0)
            {
                object tenLoai = KetNoi.LayGiaTri(
                    "SELECT TenLoai FROM LoaiSP WHERE MaLoai = @id",
                    new[] { new SqlParameter("@id", maLoai) });
                if (tenLoai != null) parts.Add("danh mục <b>" + tenLoai + "</b>");
            }
            string[] giaNhan = { "", "dưới 10 triệu", "10–20 triệu", "20–35 triệu", "trên 35 triệu" };
            if (giaBand > 0) parts.Add($"giá <b>{giaNhan[giaBand]}</b>");

            litBoLocHienThi.Text = parts.Count > 0
                ? " &bull; Đang lọc: " + string.Join(", ", parts)
                : "";
        }

        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
            hfGiaBand.Value = "0";
            hfMaLoai.Value = "0";
            LoadAndSearch();
        }

        protected void btnXoaBoLoc_Click(object sender, EventArgs e)
        {
            txtTimKiem.Text = "";
            hfMaLoai.Value = "0";
            hfGiaBand.Value = "0";
            ddlSapXep.SelectedValue = "moi";
            LoadAndSearch();
        }

        protected void LocDanhMuc_Click(object sender, CommandEventArgs e)
        {
            hfMaLoai.Value = e.CommandArgument.ToString();
            LoadAndSearch();
        }

        protected void LocGia_Click(object sender, CommandEventArgs e)
        {
            hfGiaBand.Value = e.CommandArgument.ToString();
            LoadAndSearch();
        }

        protected void ddlSapXep_Changed(object sender, EventArgs e)
        {
            LoadAndSearch();
        }

        protected string GetNhuCauClass(object maLoai)
        {
            int cur = 0; int.TryParse(hfMaLoai.Value, out cur);
            int id = 0; int.TryParse(maLoai?.ToString(), out id);
            return id == cur && cur > 0
                ? "block w-full text-left px-3 py-2 rounded-lg text-sm transition filter-active"
                : "block w-full text-left px-3 py-2 rounded-lg text-sm transition text-slate-600 hover:bg-slate-50";
        }

        protected string GetThuongHieuClass(object maLoai)
        {
            int cur = 0; int.TryParse(hfMaLoai.Value, out cur);
            int id = 0; int.TryParse(maLoai?.ToString(), out id);
            return id == cur && cur > 0
                ? "block w-full text-left px-3 py-2 rounded-lg text-sm transition filter-brand-active"
                : "block w-full text-left px-3 py-2 rounded-lg text-sm transition text-slate-600 hover:bg-slate-50";
        }

        protected string GetNhuCauMobileClass(object maLoai)
        {
            int cur = 0; int.TryParse(hfMaLoai.Value, out cur);
            int id = 0; int.TryParse(maLoai?.ToString(), out id);
            return id == cur && cur > 0
                ? "text-xs px-3 py-1.5 rounded-full bg-primary text-white font-medium"
                : "text-xs px-3 py-1.5 rounded-full bg-slate-100 text-slate-600 hover:bg-primary hover:text-white transition";
        }

        protected string GetButtonClass(object soLuong)
        {
            int sl = 0; int.TryParse(soLuong?.ToString(), out sl);
            string cls = "btn-them-gio text-xs px-3 py-1.5 rounded-lg transition ";
            return sl == 0
                ? cls + "bg-slate-300 text-slate-500 cursor-not-allowed"
                : cls + "bg-primary text-white hover:bg-secondary";
        }

        protected string GetButtonDisabled(object soLuong)
        {
            int sl = 0; int.TryParse(soLuong?.ToString(), out sl);
            return sl == 0 ? "disabled" : "";
        }

        protected string GetButtonText(object soLuong)
        {
            int sl = 0; int.TryParse(soLuong?.ToString(), out sl);
            return sl == 0 ? "H&#7871;t h&#224;ng" : "+ Gi&#7887;";
        }

        protected string GetHetHangOverlay(object soLuong)
        {
            int sl = 0;
            int.TryParse(soLuong?.ToString(), out sl);
            return sl == 0
                ? "<div class=\"absolute inset-0 bg-black/50 flex items-center justify-center\"><span class=\"bg-red-600 text-white text-xs font-bold px-3 py-1 rounded-full\">H&#7871;t h&#224;ng</span></div>"
                : "";
        }

        protected string TaoTheNhuCau(object nhuCau)
        {
            if (nhuCau == null || string.IsNullOrEmpty(nhuCau.ToString())) return "";
            var sb = new StringBuilder();
            foreach (string ten in nhuCau.ToString().Split(','))
            {
                string t = ten.Trim();
                if (!string.IsNullOrEmpty(t))
                    sb.Append($"<span class=\"text-xs bg-blue-50 text-blue-700 px-2 py-0.5 rounded-full\">{t}</span>");
            }
            return sb.ToString();
        }

        protected string TaoTheThuongHieu(object thuongHieu)
        {
            if (thuongHieu == null || string.IsNullOrEmpty(thuongHieu.ToString())) return "";
            var sb = new StringBuilder();
            foreach (string ten in thuongHieu.ToString().Split(','))
            {
                string t = ten.Trim();
                if (!string.IsNullOrEmpty(t))
                    sb.Append($"<span class=\"text-xs bg-violet-50 text-violet-700 px-2 py-0.5 rounded-full\">{t}</span>");
            }
            return sb.ToString();
        }
    }
}
