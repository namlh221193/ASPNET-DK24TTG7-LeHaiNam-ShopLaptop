using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopLapTop.Admin
{
    public partial class SanPham : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCheckBoxLists();
                LoadSanPham();
            }
        }

        void LoadCheckBoxLists()
        {
            BindCbl(cblNhuCau,    DanhMucHelper.LayDanhMucTheoNhom(DanhMucHelper.NhuCau));
            BindCbl(cblThuongHieu, DanhMucHelper.LayDanhMucTheoNhom(DanhMucHelper.ThuongHieu));
        }

        void BindCbl(CheckBoxList cbl, DataTable dt)
        {
            cbl.DataSource     = dt;
            cbl.DataTextField  = "TenLoai";
            cbl.DataValueField = "MaLoai";
            cbl.DataBind();
        }

        void LoadSanPham()
        {
            string sql = @"SELECT sp.MaSP, sp.TenSP, sp.Gia, sp.SoLuong,
                STUFF((SELECT N', ' + lo.TenLoai FROM SanPham_Loai sl
                       INNER JOIN LoaiSP lo ON sl.MaLoai = lo.MaLoai
                       WHERE sl.MaSP = sp.MaSP
                       FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'), 1, 2, '') AS DanhMuc
                FROM SanPham sp ORDER BY sp.MaSP DESC";
            rptSanPham.DataSource = KetNoi.LayDuLieu(sql);
            rptSanPham.DataBind();
        }

        void ResetForm()
        {
            hfMaSP.Value    = "0";
            hfHinhAnh.Value = "";
            txtTenSP.Text   = "";
            txtHangSX.Text  = "";
            txtGia.Text     = "";
            txtSoLuong.Text = "";
            txtMoTa.Text    = "";
            pnlImgPreview.Visible  = false;
            litTieuDeForm.Text     = "Thêm sản phẩm mới";
            lblThongBao.Visible    = false;

            foreach (ListItem item in cblNhuCau.Items)    item.Selected = false;
            foreach (ListItem item in cblThuongHieu.Items) item.Selected = false;
        }

        List<int> LayDanhMucDaChon()
        {
            var ds = new List<int>();
            ds.AddRange(DanhMucHelper.LayMaLoaiDaChon(cblNhuCau));
            ds.AddRange(DanhMucHelper.LayMaLoaiDaChon(cblThuongHieu));
            return ds;
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            string tenSP = txtTenSP.Text.Trim();
            if (string.IsNullOrEmpty(tenSP))
            {
                ShowError("Vui lòng nhập tên sản phẩm!");
                return;
            }

            // Handle image upload
            string hinhAnh = hfHinhAnh.Value;
            if (fuHinhAnh.HasFile)
            {
                try   { hinhAnh = UploadHelper.LuuHinhAnh(fuHinhAnh.PostedFile, "Products"); }
                catch (Exception ex) { ShowError(ex.Message); return; }
            }

            int maSP = Convert.ToInt32(hfMaSP.Value);
            decimal gia      = decimal.TryParse(txtGia.Text,     out decimal g) ? g : 0;
            int soLuong      = int.TryParse(txtSoLuong.Text,     out int sl) ? sl : 0;
            List<int> dsLoai = LayDanhMucDaChon();

            if (maSP == 0)
            {
                object id = KetNoi.LayGiaTri(
                    @"INSERT INTO SanPham (TenSP, MoTa, Gia, SoLuong, HinhAnh, HangSX)
                      VALUES (@ten, @mt, @gia, @sl, @ha, @hang); SELECT SCOPE_IDENTITY();",
                    new SqlParameter[] {
                        new SqlParameter("@ten",  tenSP),
                        new SqlParameter("@mt",   txtMoTa.Text),
                        new SqlParameter("@gia",  gia),
                        new SqlParameter("@sl",   soLuong),
                        new SqlParameter("@ha",   (object)hinhAnh ?? DBNull.Value),
                        new SqlParameter("@hang", txtHangSX.Text)
                    });
                maSP = Convert.ToInt32(id);
                ShowSuccess("Thêm sản phẩm thành công!");
            }
            else
            {
                KetNoi.ThucThi(
                    @"UPDATE SanPham SET TenSP=@ten, MoTa=@mt, Gia=@gia, SoLuong=@sl,
                      HinhAnh=@ha, HangSX=@hang WHERE MaSP=@id",
                    new SqlParameter[] {
                        new SqlParameter("@ten",  tenSP),
                        new SqlParameter("@mt",   txtMoTa.Text),
                        new SqlParameter("@gia",  gia),
                        new SqlParameter("@sl",   soLuong),
                        new SqlParameter("@ha",   (object)hinhAnh ?? DBNull.Value),
                        new SqlParameter("@hang", txtHangSX.Text),
                        new SqlParameter("@id",   maSP)
                    });
                ShowSuccess("Cập nhật sản phẩm thành công!");
            }

            DanhMucHelper.GanDanhMucChoSP(maSP, dsLoai);
            ResetForm();
            LoadSanPham();
        }

        protected void btnHuy_Click(object sender, EventArgs e) => ResetForm();

        protected void rptSanPham_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int maSP = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Sua")
            {
                DataTable dt = KetNoi.LayDuLieu("SELECT * FROM SanPham WHERE MaSP = @id",
                    new SqlParameter[] { new SqlParameter("@id", maSP) });

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfMaSP.Value    = maSP.ToString();
                    txtTenSP.Text   = row["TenSP"].ToString();
                    txtHangSX.Text  = row["HangSX"].ToString();
                    txtGia.Text     = row["Gia"].ToString();
                    txtSoLuong.Text = row["SoLuong"].ToString();
                    txtMoTa.Text    = row["MoTa"].ToString();
                    litTieuDeForm.Text = "Sửa sản phẩm #" + maSP;

                    string ha = row["HinhAnh"].ToString();
                    hfHinhAnh.Value = ha;
                    if (!string.IsNullOrEmpty(ha))
                    {
                        pnlImgPreview.Visible = true;
                        imgPreview.ImageUrl    = ha.StartsWith("http") ? ha : "~/" + ha;
                    }

                    List<int> dsLoai = DanhMucHelper.LayMaLoaiCuaSP(maSP);
                    DanhMucHelper.ChonCheckBoxList(cblNhuCau,     dsLoai);
                    DanhMucHelper.ChonCheckBoxList(cblThuongHieu, dsLoai);
                }
            }
            else if (e.CommandName == "Xoa")
            {
                KetNoi.ThucThi("DELETE FROM SanPham WHERE MaSP = @id",
                    new SqlParameter[] { new SqlParameter("@id", maSP) });
                LoadSanPham();
            }
        }

        void ShowSuccess(string msg)
        {
            lblThongBao.Text = msg;
            lblThongBao.CssClass = "block text-emerald-600 text-sm mb-3";
            lblThongBao.Visible = true;
        }

        void ShowError(string msg)
        {
            lblThongBao.Text = msg;
            lblThongBao.CssClass = "block text-red-500 text-sm mb-3";
            lblThongBao.Visible = true;
        }
    }
}
