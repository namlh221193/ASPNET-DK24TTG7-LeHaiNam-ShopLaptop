using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ShopLapTop
{
    // Class ket noi database - viet don gian nhu junior
    public class KetNoi
    {
        public static SqlConnection MoKetNoi()
        {
            string chuoiKetNoi = ConfigurationManager.ConnectionStrings["CuaHangLapTop"].ConnectionString;
            SqlConnection conn = new SqlConnection(chuoiKetNoi);
            conn.Open();
            return conn;
        }

        public static DataTable LayDuLieu(string sql)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = MoKetNoi())
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.Fill(dt);
            }
            return dt;
        }

        public static DataTable LayDuLieu(string sql, SqlParameter[] thamSo)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = MoKetNoi())
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                if (thamSo != null)
                    cmd.Parameters.AddRange(thamSo);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        public static int ThucThi(string sql, SqlParameter[] thamSo)
        {
            using (SqlConnection conn = MoKetNoi())
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                if (thamSo != null)
                    cmd.Parameters.AddRange(thamSo);
                return cmd.ExecuteNonQuery();
            }
        }

        public static object LayGiaTri(string sql, SqlParameter[] thamSo)
        {
            using (SqlConnection conn = MoKetNoi())
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                if (thamSo != null)
                    cmd.Parameters.AddRange(thamSo);
                return cmd.ExecuteScalar();
            }
        }
    }
}
