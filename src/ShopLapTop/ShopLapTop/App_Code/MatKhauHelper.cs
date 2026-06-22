using System;
using System.Security.Cryptography;

namespace ShopLapTop
{
    /// <summary>
    /// Mã hóa mật khẩu bằng PBKDF2 (Rfc2898DeriveBytes) — có salt ngẫu nhiên, lưu dạng Base64.
    /// </summary>
    public static class MatKhauHelper
    {
        private const int SaltSize = 16;
        private const int HashSize = 32;
        private const int Iterations = 10000;

        public static string MaHoa(string matKhau)
        {
            byte[] salt = new byte[SaltSize];
            using (var rng = new RNGCryptoServiceProvider())
                rng.GetBytes(salt);

            byte[] hash = TaoHash(matKhau, salt);
            byte[] ketQua = new byte[SaltSize + HashSize];
            Buffer.BlockCopy(salt, 0, ketQua, 0, SaltSize);
            Buffer.BlockCopy(hash, 0, ketQua, SaltSize, HashSize);
            return Convert.ToBase64String(ketQua);
        }

        public static bool KiemTra(string matKhauNhap, string matKhauLuu)
        {
            if (string.IsNullOrEmpty(matKhauLuu))
                return false;

            // Hỗ trợ tài khoản cũ lưu mật khẩu thuần (tự nâng cấp khi đăng nhập)
            if (!LaMatKhauDaMaHoa(matKhauLuu))
                return matKhauNhap == matKhauLuu;

            byte[] duLieu;
            try
            {
                duLieu = Convert.FromBase64String(matKhauLuu);
            }
            catch
            {
                return false;
            }

            if (duLieu.Length != SaltSize + HashSize)
                return false;

            byte[] salt = new byte[SaltSize];
            byte[] hashLuu = new byte[HashSize];
            Buffer.BlockCopy(duLieu, 0, salt, 0, SaltSize);
            Buffer.BlockCopy(duLieu, SaltSize, hashLuu, 0, HashSize);

            byte[] hashTinh = TaoHash(matKhauNhap, salt);
            return SoSanhAnToan(hashLuu, hashTinh);
        }

        /// <summary>True nếu mật khẩu trong DB đã được mã hóa (không còn lưu thuần).</summary>
        public static bool DaDuocMaHoa(string matKhauLuu)
        {
            return LaMatKhauDaMaHoa(matKhauLuu);
        }

        private static bool LaMatKhauDaMaHoa(string giaTri)
        {
            if (giaTri.Length < 40)
                return false;

            try
            {
                byte[] data = Convert.FromBase64String(giaTri);
                return data.Length == SaltSize + HashSize;
            }
            catch
            {
                return false;
            }
        }

        private static byte[] TaoHash(string matKhau, byte[] salt)
        {
            using (var pbkdf2 = new Rfc2898DeriveBytes(matKhau, salt, Iterations))
                return pbkdf2.GetBytes(HashSize);
        }

        private static bool SoSanhAnToan(byte[] a, byte[] b)
        {
            if (a.Length != b.Length)
                return false;

            int khac = 0;
            for (int i = 0; i < a.Length; i++)
                khac |= a[i] ^ b[i];
            return khac == 0;
        }
    }
}
