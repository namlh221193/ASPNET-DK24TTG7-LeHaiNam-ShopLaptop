<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="ShopLapTop.DangNhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="max-w-md mx-auto">
        <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-8">
            <h1 class="text-2xl font-bold text-slate-800 text-center mb-6">Đăng nhập</h1>

            <asp:Label ID="lblLoi" runat="server" CssClass="block text-red-500 text-sm mb-4 text-center" Visible="false" />

            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Tên đăng nhập</label>
                <asp:TextBox ID="txtTenDN" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-6">
                <label class="block text-slate-700 font-medium mb-1">Mật khẩu</label>
                <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>

            <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" OnClick="btnDangNhap_Click"
                CssClass="w-full bg-primary text-white py-3 rounded-lg font-medium hover:bg-secondary cursor-pointer transition" />

            <p class="text-center text-slate-500 mt-4 text-sm">
                Chưa có tài khoản? <a href="DangKy.aspx" class="text-primary hover:underline">Đăng ký ngay</a>
            </p>
            <p class="text-center text-slate-400 mt-2 text-xs">Demo: admin / 123456</p>
        </div>
    </div>
</asp:Content>
