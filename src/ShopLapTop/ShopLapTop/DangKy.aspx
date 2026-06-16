<%@ Page Title="Đăng ký" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="ShopLapTop.DangKy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="max-w-md mx-auto">
        <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-8">
            <h1 class="text-2xl font-bold text-slate-800 text-center mb-6">Đăng ký tài khoản</h1>

            <asp:Label ID="lblLoi" runat="server" CssClass="block text-red-500 text-sm mb-4 text-center" Visible="false" />
            <asp:Label ID="lblThanhCong" runat="server" CssClass="block text-emerald-600 text-sm mb-4 text-center" Visible="false" />

            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Tên đăng nhập *</label>
                <asp:TextBox ID="txtTenDN" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Mật khẩu *</label>
                <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Họ tên</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>
            <div class="mb-6">
                <label class="block text-slate-700 font-medium mb-1">Số điện thoại</label>
                <asp:TextBox ID="txtSDT" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:outline-none focus:ring-2 focus:ring-primary" />
            </div>

            <asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" OnClick="btnDangKy_Click"
                CssClass="w-full bg-primary text-white py-3 rounded-lg font-medium hover:bg-secondary cursor-pointer transition" />

            <p class="text-center text-slate-500 mt-4 text-sm">
                Đã có tài khoản? <a href="DangNhap.aspx" class="text-primary hover:underline">Đăng nhập</a>
            </p>
        </div>
    </div>
</asp:Content>
