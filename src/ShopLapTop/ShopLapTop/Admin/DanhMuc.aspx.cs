using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopLapTop.Admin
{
    public partial class DanhMuc : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadDanhMuc();
        }

        void LoadDanhMuc()
        {
            string sql = @"SELECT lo.MaLoai, lo.TenLoai, lo.HinhAnh, lo.LoaiDanhMuc,
                               COUNT(sl.MaSP) AS SoSP
                           FROM LoaiSP lo
                           LEFT JOIN SanPham_Loai sl ON lo.MaLoai = sl.MaLoai
                           GROUP BY lo.MaLoai, lo.TenLoai, lo.HinhAnh, lo.LoaiDanhMuc
                           ORDER BY lo.TenLoai";
            DataTable dt = KetNoi.LayDuLieu(sql);

            DataView dvNhuCau = new DataView(dt, "LoaiDanhMuc = 1", "TenLoai", DataViewRowState.CurrentRows);
            DataView dvThuongHieu = new DataView(dt, "LoaiDanhMuc = 2", "TenLoai", DataViewRowState.CurrentRows);

            rptNhuCau.DataSource = dvNhuCau;
            rptNhuCau.DataBind();

            rptThuongHieu.DataSource = dvThuongHieu;
            rptThuongHieu.DataBind();
        }

        void ResetForm()
        {
            hfMaLoai.Value = "0";
            hfHinhAnh.Value = "";
            txtTenLoai.Text = "";
            ddlNhom.SelectedValue = "1";
            pnlImgPreview.Visible = false;
            litTieuDeForm.Text = "Thêm danh mục mới";
            lblThongBao.Visible = false;
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            string tenLoai = txtTenLoai.Text.Trim();
            if (string.IsNullOrEmpty(tenLoai))
            {
                ShowError("Vui lòng nhập tên danh mục!");
                return;
            }

            int nhom = Convert.ToInt32(ddlNhom.SelectedValue);
            int maLoai = Convert.ToInt32(hfMaLoai.Value);
            string hinhAnh = hfHinhAnh.Value;

            if (fuHinhAnh.HasFile)
            {
                try   { hinhAnh = UploadHelper.LuuHinhAnh(fuHinhAnh.PostedFile, "Categories"); }
                catch (Exception ex) { ShowError(ex.Message); return; }
            }

            if (maLoai == 0)
            {
                KetNoi.ThucThi(
                    "INSERT INTO LoaiSP (TenLoai, LoaiDanhMuc, HinhAnh) VALUES (@ten, @nhom, @ha)",
                    new SqlParameter[] {
                        new SqlParameter("@ten",  tenLoai),
                        new SqlParameter("@nhom", nhom),
                        new SqlParameter("@ha",   (object)hinhAnh ?? DBNull.Value)
                    });
                ShowSuccess("Thêm danh mục thành công!");
            }
            else
            {
                KetNoi.ThucThi(
                    "UPDATE LoaiSP SET TenLoai=@ten, LoaiDanhMuc=@nhom, HinhAnh=@ha WHERE MaLoai=@id",
                    new SqlParameter[] {
                        new SqlParameter("@ten",  tenLoai),
                        new SqlParameter("@nhom", nhom),
                        new SqlParameter("@ha",   (object)hinhAnh ?? DBNull.Value),
                        new SqlParameter("@id",   maLoai)
                    });
                ShowSuccess("Cập nhật danh mục thành công!");
            }

            ResetForm();
            LoadDanhMuc();
        }

        protected void btnHuy_Click(object sender, EventArgs e) => ResetForm();

        protected void rpt_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int maLoai = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Sua")
            {
                DataTable dt = KetNoi.LayDuLieu(
                    "SELECT MaLoai, TenLoai, LoaiDanhMuc, HinhAnh FROM LoaiSP WHERE MaLoai = @id",
                    new SqlParameter[] { new SqlParameter("@id", maLoai) });

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfMaLoai.Value = maLoai.ToString();
                    txtTenLoai.Text = row["TenLoai"].ToString();
                    ddlNhom.SelectedValue = row["LoaiDanhMuc"].ToString();
                    litTieuDeForm.Text = "Sửa danh mục #" + maLoai;

                    string ha = row["HinhAnh"].ToString();
                    hfHinhAnh.Value = ha;
                    if (!string.IsNullOrEmpty(ha))
                    {
                        pnlImgPreview.Visible = true;
                        imgPreview.ImageUrl = "~/" + ha;
                    }
                }
            }
            else if (e.CommandName == "Xoa")
            {
                // SanPham_Loai da co ON DELETE CASCADE nen tu dong xoa lien ket
                KetNoi.ThucThi("DELETE FROM LoaiSP WHERE MaLoai = @id",
                    new SqlParameter[] { new SqlParameter("@id", maLoai) });
                LoadDanhMuc();
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
