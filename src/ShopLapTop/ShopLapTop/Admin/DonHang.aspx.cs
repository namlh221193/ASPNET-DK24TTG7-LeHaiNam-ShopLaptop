using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopLapTop.Admin
{
    public partial class DonHang : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadDonHang();
        }

        void LoadDonHang()
        {
            DataTable dt = KetNoi.LayDuLieu("SELECT * FROM DonHang ORDER BY NgayDat DESC");
            rptDonHang.DataSource = dt;
            rptDonHang.DataBind();
            pnlTrong.Visible = dt.Rows.Count == 0;
        }

        protected string GetTrangThaiClass(string trangThai)
        {
            switch (trangThai)
            {
                case "Chờ xử lý":
                case "Cho xu ly": return "bg-yellow-100 text-yellow-800";
                case "Đang giao":
                case "Dang giao": return "bg-blue-100 text-blue-800";
                case "Đã giao":
                case "Da giao": return "bg-emerald-100 text-emerald-800";
                case "Đã hủy":
                case "Da huy": return "bg-red-100 text-red-800";
                default: return "bg-slate-100 text-slate-800";
            }
        }

        protected void rptDonHang_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string trangThai = DataBinder.Eval(e.Item.DataItem, "TrangThai").ToString();
                DropDownList ddl = (DropDownList)e.Item.FindControl("ddlTrangThai");
                if (ddl != null)
                {
                    // Ho tro ca trang thai cu (khong dau) va moi (co dau)
                    if (trangThai == "Cho xu ly") ddl.SelectedValue = "Chờ xử lý";
                    else if (trangThai == "Dang giao") ddl.SelectedValue = "Đang giao";
                    else if (trangThai == "Da giao") ddl.SelectedValue = "Đã giao";
                    else if (trangThai == "Da huy") ddl.SelectedValue = "Đã hủy";
                    else ddl.SelectedValue = trangThai;
                }
            }
        }

        protected void rptDonHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CapNhat")
            {
                int maDH = Convert.ToInt32(e.CommandArgument);
                DropDownList ddl = (DropDownList)e.Item.FindControl("ddlTrangThai");

                KetNoi.ThucThi("UPDATE DonHang SET TrangThai = @tt WHERE MaDH = @id",
                    new SqlParameter[] {
                        new SqlParameter("@tt", ddl.SelectedValue),
                        new SqlParameter("@id", maDH)
                    });
                LoadDonHang();
            }
        }
    }
}
