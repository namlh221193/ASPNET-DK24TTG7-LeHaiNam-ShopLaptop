using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace ShopLapTop
{
    public class DanhMucHelper
    {
        public const int NhuCau = 1;
        public const int ThuongHieu = 2;

        public static DataTable LayDanhMucTheoNhom(int nhom)
        {
            return KetNoi.LayDuLieu(
                "SELECT MaLoai, TenLoai FROM LoaiSP WHERE LoaiDanhMuc = @nhom ORDER BY TenLoai",
                new SqlParameter[] { new SqlParameter("@nhom", nhom) });
        }

        public static void GanDanhMucChoSP(int maSP, List<int> dsMaLoai)
        {
            KetNoi.ThucThi("DELETE FROM SanPham_Loai WHERE MaSP = @id",
                new SqlParameter[] { new SqlParameter("@id", maSP) });

            foreach (int maLoai in dsMaLoai)
            {
                KetNoi.ThucThi("INSERT INTO SanPham_Loai (MaSP, MaLoai) VALUES (@sp, @loai)",
                    new SqlParameter[] {
                        new SqlParameter("@sp", maSP),
                        new SqlParameter("@loai", maLoai)
                    });
            }
        }

        public static List<int> LayMaLoaiCuaSP(int maSP)
        {
            List<int> ds = new List<int>();
            DataTable dt = KetNoi.LayDuLieu(
                "SELECT MaLoai FROM SanPham_Loai WHERE MaSP = @id",
                new SqlParameter[] { new SqlParameter("@id", maSP) });
            foreach (DataRow row in dt.Rows)
                ds.Add((int)row["MaLoai"]);
            return ds;
        }

        public static void ChonCheckBoxList(CheckBoxList cbl, List<int> dsMaLoai)
        {
            foreach (ListItem item in cbl.Items)
            {
                item.Selected = dsMaLoai.Contains(int.Parse(item.Value));
            }
        }

        public static List<int> LayMaLoaiDaChon(CheckBoxList cbl)
        {
            List<int> ds = new List<int>();
            foreach (ListItem item in cbl.Items)
            {
                if (item.Selected)
                    ds.Add(int.Parse(item.Value));
            }
            return ds;
        }

        public static string TaoHTMLTheLoai(string danhSach, string mauNen, string mauChu)
        {
            if (string.IsNullOrEmpty(danhSach))
                return "";

            StringBuilder sb = new StringBuilder();
            string[] arr = danhSach.Split(',');
            foreach (string ten in arr)
            {
                string t = ten.Trim();
                if (t.Length > 0)
                    sb.AppendFormat(
                        "<span class='inline-block {0} {1} text-xs font-medium px-2 py-0.5 rounded-full mr-1 mb-1'>{2}</span>",
                        mauNen, mauChu, t);
            }
            return sb.ToString();
        }
    }
}
