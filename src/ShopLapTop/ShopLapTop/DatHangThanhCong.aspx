<%@ Page Title="Đặt hàng thành công" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatHangThanhCong.aspx.cs" Inherits="ShopLapTop.DatHangThanhCong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="text-center py-16 bg-white rounded-2xl border border-slate-100 shadow-sm">
        <div class="w-16 h-16 bg-emerald-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-emerald-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
            </svg>
        </div>
        <h1 class="text-2xl font-bold text-slate-800 mb-2">Đặt hàng thành công!</h1>
        <p class="text-slate-500 mb-2">Mã đơn hàng: <strong class="text-primary">#<asp:Literal ID="litMaDH" runat="server" /></strong></p>
        <p class="text-slate-500 mb-6">Cảm ơn bạn đã mua hàng tại Shop Laptop!</p>
        <a href="Default.aspx" class="bg-primary text-white px-6 py-3 rounded-lg font-medium hover:bg-secondary inline-block transition">
            Tiếp tục mua sắm
        </a>
    </div>
</asp:Content>
