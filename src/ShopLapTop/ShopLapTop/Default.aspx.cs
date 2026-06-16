using System;
using System.Web.UI;

namespace ShopLapTop
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.RedirectPermanent("~/Index.aspx", true);
        }
    }
}
