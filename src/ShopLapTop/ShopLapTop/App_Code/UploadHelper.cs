using System;
using System.IO;
using System.Web;

namespace ShopLapTop
{
    public class UploadHelper
    {
        static readonly string[] _allowedExt = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };
        const int MaxBytes = 5 * 1024 * 1024; // 5 MB

        /// <summary>
        /// Validates and saves an uploaded image.
        /// </summary>
        /// <param name="file">HttpPostedFile from FileUpload control</param>
        /// <param name="subFolder">Sub-folder inside ~/Images/ (e.g. "Products" or "Categories")</param>
        /// <returns>Relative path (e.g. "Images/Products/abc.jpg"), or null if no file.</returns>
        public static string LuuHinhAnh(HttpPostedFile file, string subFolder)
        {
            if (file == null || file.ContentLength == 0)
                return null;

            if (file.ContentLength > MaxBytes)
                throw new InvalidOperationException("Hình ảnh không được lớn hơn 5MB!");

            string ext = Path.GetExtension(file.FileName).ToLower();
            if (Array.IndexOf(_allowedExt, ext) < 0)
                throw new InvalidOperationException("Chỉ chấp nhận định dạng: JPG, PNG, GIF, WEBP!");

            if (!file.ContentType.StartsWith("image/", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException("File phải là định dạng hình ảnh hợp lệ!");

            string folder = HttpContext.Current.Server.MapPath("~/Images/" + subFolder);
            if (!Directory.Exists(folder))
                Directory.CreateDirectory(folder);

            string fileName = Guid.NewGuid().ToString("N") + ext;
            file.SaveAs(Path.Combine(folder, fileName));
            return "Images/" + subFolder + "/" + fileName;
        }
    }
}
