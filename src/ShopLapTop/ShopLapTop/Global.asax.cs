using System;
using System.Text;
using System.Web;

namespace ShopLapTop
{
    public class Global : HttpApplication
    {
        // Buoc quan trong nhat: ep toan bo response dung UTF-8
        // Day la nguyen nhan gay loi "ChÃ o" thay vi "Chào"
        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            Response.ContentEncoding = Encoding.UTF8;
            Response.Charset = "utf-8";
            Response.HeaderEncoding = Encoding.UTF8;
        }

        protected void Application_Start(object sender, EventArgs e)
        {
        }
    }
}
