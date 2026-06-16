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
            BindCheckBoxList(cblNhuCau, DanhMucHelper.LayDanhMucTheoNhom(DanhMucHelper.NhuCau));
            BindCheckBoxList(cblThuongHieu, DanhMucHelper.LayDanhMucTheoNhom(DanhMucHelper.ThuongHieu));
        }

        void BindCheckBoxList(CheckBoxList cbl, DataTable dt)
        {
            cbl.DataSource = dt;
            cbl.DataTextField = "TenLoai";
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
            hfMaSP.Value = "0";
            txtTenSP.Text = "";
            txtHangSX.Text = "";
            txtGia.Text = "";
            txtSoLuong.Text = "";
            txtHinhAnh.Text = "";
            txtMoTa.Text = "";
            litTieuDeForm.Text = "Thêm sản phẩm mới";

            foreach (ListItem item in cblNhuCau.Items) item.Selected = false;
            foreach (ListItem item in cblThuongHieu.Items) item.Selected = false;
        }

        List<int> LayDanhMucDaChon()
        {
            List<int> ds = new List<int>();
            ds.AddRange(DanhMucHelper.LayMaLoaiDaChon(cblNhuCau));
            ds.AddRange(DanhMucHelper.LayMaLoaiDaChon(cblThuongHieu));
            return ds;
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            string tenSP = txtTenSP.Text.Trim();
            if (string.IsNullOrEmpty(tenSP))
                return;

            int maSP = Convert.ToInt32(hfMaSP.Value);
            decimal gia = Convert.ToDecimal(txtGia.Text);
            int soLuong = Convert.ToInt32(txtSoLuong.Text);
            List<int> dsLoai = LayDanhMucDaChon();

            if (maSP == 0)
            {
                object id = KetNoi.LayGiaTri(
                    @"INSERT INTO SanPham (TenSP, MoTa, Gia, SoLuong, HinhAnh, HangSX) 
                      VALUES (@ten, @mt, @gia, @sl, @ha, @hang); SELECT SCOPE_IDENTITY();",
                    new SqlParameter[] {
                        new SqlParameter("@ten", tenSP),
                        new SqlParameter("@mt", txtMoTa.Text),
                        new SqlParameter("@gia", gia),
                        new SqlParameter("@sl", soLuong),
                        new SqlParameter("@ha", txtHinhAnh.Text),
                        new SqlParameter("@hang", txtHangSX.Text)
                    });
                maSP = Convert.ToInt32(id);
                lblThongBao.Text = "Thêm sản phẩm thành công!";
            }
            else
            {
                KetNoi.ThucThi(
                    @"UPDATE SanPham SET TenSP=@ten, MoTa=@mt, Gia=@gia, SoLuong=@sl, 
                      HinhAnh=@ha, HangSX=@hang WHERE MaSP=@id",
                    new SqlParameter[] {
                        new SqlParameter("@ten", tenSP),
                        new SqlParameter("@mt", txtMoTa.Text),
                        new SqlParameter("@gia", gia),
                        new SqlParameter("@sl", soLuong),
                        new SqlParameter("@ha", txtHinhAnh.Text),
                        new SqlParameter("@hang", txtHangSX.Text),
                        new SqlParameter("@id", maSP)
                    });
                lblThongBao.Text = "Cập nhật sản phẩm thành công!";
            }

            DanhMucHelper.GanDanhMucChoSP(maSP, dsLoai);
            lblThongBao.Visible = true;
            ResetForm();
            LoadSanPham();
        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

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
                    hfMaSP.Value = maSP.ToString();
                    txtTenSP.Text = row["TenSP"].ToString();
                    txtHangSX.Text = row["HangSX"].ToString();
                    txtGia.Text = row["Gia"].ToString();
                    txtSoLuong.Text = row["SoLuong"].ToString();
                    txtHinhAnh.Text = row["HinhAnh"].ToString();
                    txtMoTa.Text = row["MoTa"].ToString();
                    litTieuDeForm.Text = "Sửa sản phẩm #" + maSP;

                    List<int> dsLoai = DanhMucHelper.LayMaLoaiCuaSP(maSP);
                    DanhMucHelper.ChonCheckBoxList(cblNhuCau, dsLoai);
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
    }
}
