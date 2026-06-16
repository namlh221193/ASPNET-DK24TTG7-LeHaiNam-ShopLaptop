<%@ Page Title="Lịch sử đơn hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LichSuDonHang.aspx.cs" Inherits="ShopLapTop.LichSuDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-bold text-slate-800">Lịch sử đơn hàng</h1>
        <a href="ThongTin.aspx" class="text-sm text-primary hover:underline">← Thông tin cá nhân</a>
    </div>

    <asp:Panel ID="pnlRong" runat="server" Visible="false">
        <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-12 text-center">
            <svg class="w-16 h-16 text-slate-200 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
            </svg>
            <p class="text-slate-400 text-lg mb-4">Bạn chưa có đơn hàng nào</p>
            <a href="ProductList.aspx" class="inline-block bg-primary text-white px-6 py-2.5 rounded-lg hover:bg-secondary transition font-medium">
                Mua sắm ngay
            </a>
        </div>
    </asp:Panel>

    <asp:Repeater ID="rptDonHang" runat="server" OnItemDataBound="rptDonHang_ItemDataBound">
        <ItemTemplate>
            <div class="bg-white rounded-2xl shadow-sm border border-slate-100 mb-4 overflow-hidden">
                <div class="flex flex-wrap items-center justify-between px-6 py-4 bg-slate-50 border-b border-slate-100 gap-3">
                    <div class="flex items-center gap-4">
                        <span class="font-bold text-slate-700">Đơn #<%# Eval("MaDH") %></span>
                        <span class="text-slate-400 text-sm"><%# string.Format("{0:dd/MM/yyyy HH:mm}", Eval("NgayDat")) %></span>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class='<%# GetTrangThaiClass(Eval("TrangThai").ToString()) %>'><%# Eval("TrangThai") %></span>
                        <span class="font-bold text-red-600"><%# string.Format("{0:N0}", Eval("TongTien")) %> đ</span>
                    </div>
                </div>
                <div class="px-6 py-4">
                    <asp:Repeater ID="rptChiTiet" runat="server">
                        <ItemTemplate>
                            <div class="flex justify-between py-2 text-sm border-b border-slate-50 last:border-0">
                                <span class="text-slate-700">
                                    <%# Eval("TenSP") %>
                                    <span class="text-slate-400 ml-1">x <%# Eval("SoLuong") %></span>
                                </span>
                                <span class="text-slate-600 font-medium whitespace-nowrap ml-4">
                                    <%# string.Format("{0:N0}", Eval("ThanhTien")) %> đ
                                </span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="mt-3 pt-3 border-t border-slate-50 flex flex-wrap gap-x-6 gap-y-1 text-sm text-slate-500">
                        <span><span class="font-medium text-slate-600">Giao tới:</span> <%# Eval("DiaChi") %></span>
                        <span><span class="font-medium text-slate-600">SĐT:</span> <%# Eval("SDT") %></span>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
