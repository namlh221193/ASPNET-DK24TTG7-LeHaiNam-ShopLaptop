<%@ Page Title="Giỏ hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="ShopLapTop.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="text-2xl font-bold text-slate-800 mb-6">Giỏ hàng của bạn</h1>

    <asp:Panel ID="pnlCoHang" runat="server">
        <div class="bg-white rounded-xl shadow-sm border border-slate-100 overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-slate-50">
                        <tr>
                            <th class="text-left p-4 text-slate-600 font-medium text-sm">Sản phẩm</th>
                            <th class="text-center p-4 text-slate-600 font-medium text-sm">Đơn giá</th>
                            <th class="text-center p-4 text-slate-600 font-medium text-sm">Số lượng</th>
                            <th class="text-center p-4 text-slate-600 font-medium text-sm">Thành tiền</th>
                            <th class="text-center p-4 text-slate-600 font-medium text-sm"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptGioHang" runat="server" OnItemCommand="rptGioHang_ItemCommand">
                            <ItemTemplate>
                                <tr class="border-t border-slate-50">
                                    <td class="p-4">
                                        <div class="flex items-center gap-3">
                                            <img src='<%# Eval("HinhAnh") %>' class="w-16 h-16 object-cover rounded-lg border border-slate-100" />
                                            <span class="font-medium text-slate-800"><%# Eval("TenSP") %></span>
                                        </div>
                                    </td>
                                    <td class="p-4 text-center text-slate-600"><%# string.Format("{0:N0}", Eval("Gia")) %> đ</td>
                                    <td class="p-4 text-center"><%# Eval("SoLuong") %></td>
                                    <td class="p-4 text-center font-bold text-red-600"><%# string.Format("{0:N0}", Eval("ThanhTien")) %> đ</td>
                                    <td class="p-4 text-center">
                                        <asp:LinkButton runat="server" CommandName="Xoa" CommandArgument='<%# Eval("MaSP") %>'
                                            CssClass="text-red-500 hover:text-red-700 text-sm" OnClientClick="return confirm('Xóa sản phẩm này?');">Xóa</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="mt-6 flex flex-col md:flex-row justify-between items-center gap-4 bg-white rounded-xl p-6 border border-slate-100">
            <a href="Default.aspx" class="text-primary hover:underline font-medium">&larr; Tiếp tục mua sắm</a>
            <div class="text-right">
                <p class="text-slate-500 text-sm">Tổng tiền:</p>
                <p class="text-2xl font-bold text-red-600"><asp:Literal ID="litTongTien" runat="server" /> đ</p>
                <a href="ThanhToan.aspx" class="mt-3 inline-block bg-primary text-white px-8 py-3 rounded-lg font-medium hover:bg-secondary transition">
                    Thanh toán
                </a>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlTrong" runat="server" Visible="false" CssClass="text-center py-16 bg-white rounded-xl border border-slate-100">
        <div class="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
            </svg>
        </div>
        <p class="text-xl text-slate-500">Giỏ hàng trống!</p>
        <a href="Default.aspx" class="mt-4 inline-block bg-primary text-white px-6 py-2.5 rounded-lg hover:bg-secondary transition">Mua sắm ngay</a>
    </asp:Panel>
</asp:Content>
