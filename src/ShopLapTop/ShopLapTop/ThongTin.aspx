<%@ Page Title="Thông tin cá nhân" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThongTin.aspx.cs" Inherits="ShopLapTop.ThongTin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="max-w-lg mx-auto">
        <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-8">
            <h1 class="text-2xl font-bold text-slate-800 mb-1">Thông tin cá nhân</h1>
            <p class="text-slate-400 text-sm mb-6">
                Tài khoản: <strong class="text-slate-600"><asp:Literal ID="litTenDN" runat="server" /></strong>
            </p>

            <asp:Label ID="lblLoi" runat="server" CssClass="block text-red-500 text-sm mb-4" Visible="false" />
            <asp:Label ID="lblThanhCong" runat="server" CssClass="block text-emerald-600 text-sm mb-4" Visible="false" />

            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Họ tên</label>
                <asp:TextBox ID="txtHoTen" runat="server"
                    CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Email</label>
                <asp:TextBox ID="txtEmail" runat="server"
                    CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-6">
                <label class="block text-slate-700 font-medium mb-1">Số điện thoại</label>
                <asp:TextBox ID="txtSDT" runat="server"
                    CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>

            <asp:Button ID="btnLuu" runat="server" Text="Lưu thay đổi" OnClick="btnLuu_Click"
                CssClass="w-full bg-primary text-white py-3 rounded-lg font-medium hover:bg-secondary cursor-pointer transition" />

            <div class="flex justify-between mt-5 text-sm">
                <a href="DoiMatKhau.aspx" class="text-primary hover:underline">Đổi mật khẩu</a>
                <a href="LichSuDonHang.aspx" class="text-primary hover:underline">Lịch sử đơn hàng →</a>
            </div>
        </div>
    </div>
</asp:Content>
