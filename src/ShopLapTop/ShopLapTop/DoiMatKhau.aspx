<%@ Page Title="Đổi mật khẩu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DoiMatKhau.aspx.cs" Inherits="ShopLapTop.DoiMatKhau" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="max-w-md mx-auto">
        <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-8">
            <h1 class="text-2xl font-bold text-slate-800 text-center mb-6">Đổi mật khẩu</h1>

            <asp:Label ID="lblLoi" runat="server" CssClass="block text-red-500 text-sm mb-4 text-center" Visible="false" />
            <asp:Label ID="lblThanhCong" runat="server" CssClass="block text-emerald-600 text-sm mb-4 text-center" Visible="false" />

            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Mật khẩu hiện tại</label>
                <asp:TextBox ID="txtMatKhauCu" runat="server" TextMode="Password"
                    CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Mật khẩu mới</label>
                <asp:TextBox ID="txtMatKhauMoi" runat="server" TextMode="Password"
                    CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-6">
                <label class="block text-slate-700 font-medium mb-1">Xác nhận mật khẩu mới</label>
                <asp:TextBox ID="txtXacNhan" runat="server" TextMode="Password"
                    CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>

            <asp:Button ID="btnDoiMK" runat="server" Text="Đổi mật khẩu" OnClick="btnDoiMK_Click"
                CssClass="w-full bg-primary text-white py-3 rounded-lg font-medium hover:bg-secondary cursor-pointer transition" />

            <p class="text-center mt-4">
                <a href="ThongTin.aspx" class="text-slate-400 text-sm hover:underline">← Quay lại thông tin cá nhân</a>
            </p>
        </div>
    </div>
</asp:Content>
