using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class ThanhToan : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<GioHangItem> gio = GioHangHelper.LayGioHang();
            if (gio.Count == 0)
            {
                Response.Redirect("GioHang.aspx");
                return;
            }

            if (!IsPostBack)
            {
                rptDonHang.DataSource = gio;
                rptDonHang.DataBind();
                litTongTien.Text = string.Format("{0:N0}", GioHangHelper.TinhTongTien());

                // Tu dong dien thong tin neu da dang nhap
                if (Session["HoTen"] != null)
                    txtHoTen.Text = Session["HoTen"].ToString();
            }
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string sdt = txtSDT.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();

            if (string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(sdt) || string.IsNullOrEmpty(diaChi))
            {
                lblLoi.Text = "Vui lòng nhập đầy đủ thông tin giao hàng!";
                lblLoi.Visible = true;
                return;
            }

            List<GioHangItem> gio = GioHangHelper.LayGioHang();
            decimal tongTien = GioHangHelper.TinhTongTien();
            int maND = Session["MaND"] != null ? Convert.ToInt32(Session["MaND"]) : 0;

            // Neu chua dang nhap thi tao nguoi dung tam (hoac dung MaND = null)
            string sqlDH = @"INSERT INTO DonHang (MaND, TongTien, DiaChi, SDT, GhiChu, TrangThai) 
                             VALUES (@maND, @tong, @dc, @sdt, @gc, N'Chờ xử lý');
                             SELECT SCOPE_IDENTITY();";

            object maDHObj = KetNoi.LayGiaTri(sqlDH, new SqlParameter[] {
                new SqlParameter("@maND", maND == 0 ? (object)DBNull.Value : maND),
                new SqlParameter("@tong", tongTien),
                new SqlParameter("@dc", diaChi),
                new SqlParameter("@sdt", sdt),
                new SqlParameter("@gc", txtGhiChu.Text.Trim())
            });

            int maDH = Convert.ToInt32(maDHObj);

            // Them chi tiet don hang
            foreach (GioHangItem item in gio)
            {
                string sqlCT = @"INSERT INTO ChiTietDonHang (MaDH, MaSP, SoLuong, DonGia) 
                                 VALUES (@maDH, @maSP, @sl, @gia)";
                KetNoi.ThucThi(sqlCT, new SqlParameter[] {
                    new SqlParameter("@maDH", maDH),
                    new SqlParameter("@maSP", item.MaSP),
                    new SqlParameter("@sl", item.SoLuong),
                    new SqlParameter("@gia", item.Gia)
                });

                // Tru so luong san pham
                KetNoi.ThucThi("UPDATE SanPham SET SoLuong = SoLuong - @sl WHERE MaSP = @maSP",
                    new SqlParameter[] {
                        new SqlParameter("@sl", item.SoLuong),
                        new SqlParameter("@maSP", item.MaSP)
                    });
            }

            GioHangHelper.XoaHet();
            Response.Redirect("DatHangThanhCong.aspx?maDH=" + maDH);
        }
    }
}
