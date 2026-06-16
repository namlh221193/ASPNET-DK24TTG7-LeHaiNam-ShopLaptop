using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShopLapTop
{
    public class GioHangHelper
    {
        public static List<GioHangItem> LayGioHang()
        {
            if (HttpContext.Current.Session["GioHang"] == null)
                HttpContext.Current.Session["GioHang"] = new List<GioHangItem>();
            return (List<GioHangItem>)HttpContext.Current.Session["GioHang"];
        }

        public static void ThemVaoGio(int maSP, string tenSP, decimal gia, string hinhAnh, int soLuong)
        {
            List<GioHangItem> gio = LayGioHang();
            GioHangItem sp = gio.Find(x => x.MaSP == maSP);
            if (sp != null)
            {
                sp.SoLuong += soLuong;
            }
            else
            {
                gio.Add(new GioHangItem
                {
                    MaSP = maSP,
                    TenSP = tenSP,
                    Gia = gia,
                    SoLuong = soLuong,
                    HinhAnh = hinhAnh
                });
            }
            HttpContext.Current.Session["GioHang"] = gio;
        }

        public static int DemSoLuong()
        {
            List<GioHangItem> gio = LayGioHang();
            return gio.Sum(x => x.SoLuong);
        }

        public static decimal TinhTongTien()
        {
            List<GioHangItem> gio = LayGioHang();
            return gio.Sum(x => x.ThanhTien);
        }

        public static void XoaKhoiGio(int maSP)
        {
            List<GioHangItem> gio = LayGioHang();
            gio.RemoveAll(x => x.MaSP == maSP);
            HttpContext.Current.Session["GioHang"] = gio;
        }

        public static void XoaHet()
        {
            HttpContext.Current.Session["GioHang"] = new List<GioHangItem>();
        }
    }
}
