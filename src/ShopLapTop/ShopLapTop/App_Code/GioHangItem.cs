using System;

namespace ShopLapTop
{
    // Item trong gio hang
    [Serializable]
    public class GioHangItem
    {
        public int MaSP { get; set; }
        public string TenSP { get; set; }
        public decimal Gia { get; set; }
        public int SoLuong { get; set; }
        public string HinhAnh { get; set; }

        public decimal ThanhTien
        {
            get { return Gia * SoLuong; }
        }
    }
}
