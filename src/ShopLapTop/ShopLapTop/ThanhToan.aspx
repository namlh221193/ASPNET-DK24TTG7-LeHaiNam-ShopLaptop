<%@ Page Title="Thanh toán" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="ShopLapTop.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="text-2xl font-bold text-slate-800 mb-6">Thanh toán đơn hàng</h1>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <div class="bg-white rounded-xl shadow-sm border border-slate-100 p-6">
            <h2 class="text-lg font-bold text-slate-800 mb-4">Thông tin giao hàng</h2>

            <asp:Label ID="lblLoi" runat="server" CssClass="block text-red-500 text-sm mb-4" Visible="false" />

            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Họ tên người nhận *</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Số điện thoại *</label>
                <asp:TextBox ID="txtSDT" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Địa chỉ giao hàng *</label>
                <asp:TextBox ID="txtDiaChi" runat="server" TextMode="MultiLine" Rows="3" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div class="mb-4">
                <label class="block text-slate-700 font-medium mb-1">Ghi chú</label>
                <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="2" CssClass="w-full border border-slate-200 rounded-lg px-4 py-2.5 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-slate-100 p-6">
            <h2 class="text-lg font-bold text-slate-800 mb-4">Đơn hàng của bạn</h2>

            <asp:Repeater ID="rptDonHang" runat="server">
                <ItemTemplate>
                    <div class="flex justify-between py-2 border-b border-slate-50 text-sm">
                        <span class="text-slate-700"><%# Eval("TenSP") %> x <%# Eval("SoLuong") %></span>
                        <span class="font-medium text-slate-800"><%# string.Format("{0:N0}", Eval("ThanhTien")) %> đ</span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="flex justify-between mt-4 pt-4 border-t border-slate-100">
                <span class="text-lg font-bold text-slate-800">Tổng cộng:</span>
                <span class="text-xl font-bold text-red-600"><asp:Literal ID="litTongTien" runat="server" /> đ</span>
            </div>

            <asp:Button ID="btnDatHang" runat="server" Text="Đặt hàng" OnClick="btnDatHang_Click"
                CssClass="w-full mt-6 bg-emerald-600 text-white py-3 rounded-lg font-medium hover:bg-emerald-700 cursor-pointer transition" />
        </div>
    </div>
</asp:Content>
