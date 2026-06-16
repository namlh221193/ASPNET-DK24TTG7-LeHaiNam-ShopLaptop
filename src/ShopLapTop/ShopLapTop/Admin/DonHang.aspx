<%@ Page Title="Quản lý đơn hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DonHang.aspx.cs" Inherits="ShopLapTop.Admin.DonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-bold text-slate-800">Quản lý đơn hàng</h1>
        <a href="Default.aspx" class="text-primary hover:underline text-sm font-medium">&larr; Quay lại</a>
    </div>

    <div class="bg-white rounded-xl shadow-sm border border-slate-100 overflow-x-auto">
        <table class="w-full text-sm">
            <thead class="bg-slate-50">
                <tr>
                    <th class="p-3 text-left text-slate-600">Mã ĐH</th>
                    <th class="p-3 text-left text-slate-600">Ngày đặt</th>
                    <th class="p-3 text-left text-slate-600">SĐT</th>
                    <th class="p-3 text-left text-slate-600">Địa chỉ</th>
                    <th class="p-3 text-right text-slate-600">Tổng tiền</th>
                    <th class="p-3 text-center text-slate-600">Trạng thái</th>
                    <th class="p-3 text-center text-slate-600">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptDonHang" runat="server" OnItemCommand="rptDonHang_ItemCommand" OnItemDataBound="rptDonHang_ItemDataBound">
                    <ItemTemplate>
                        <tr class="border-t border-slate-50 hover:bg-slate-50">
                            <td class="p-3 font-medium">#<%# Eval("MaDH") %></td>
                            <td class="p-3"><%# Eval("NgayDat", "{0:dd/MM/yyyy HH:mm}") %></td>
                            <td class="p-3"><%# Eval("SDT") %></td>
                            <td class="p-3 max-w-xs truncate"><%# Eval("DiaChi") %></td>
                            <td class="p-3 text-right font-medium text-red-600"><%# string.Format("{0:N0}", Eval("TongTien")) %> đ</td>
                            <td class="p-3 text-center">
                                <span class='<%# GetTrangThaiClass(Eval("TrangThai").ToString()) %> px-2 py-1 rounded-full text-xs font-medium'>
                                    <%# Eval("TrangThai") %>
                                </span>
                            </td>
                            <td class="p-3 text-center whitespace-nowrap">
                                <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="border border-slate-200 rounded px-2 py-1 text-xs">
                                    <asp:ListItem Value="Chờ xử lý" Text="Chờ xử lý" />
                                    <asp:ListItem Value="Đang giao" Text="Đang giao" />
                                    <asp:ListItem Value="Đã giao" Text="Đã giao" />
                                    <asp:ListItem Value="Đã hủy" Text="Đã hủy" />
                                </asp:DropDownList>
                                <asp:LinkButton runat="server" CommandName="CapNhat" CommandArgument='<%# Eval("MaDH") %>'
                                    CssClass="ml-2 text-primary hover:underline text-xs">Cập nhật</asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <asp:Panel ID="pnlTrong" runat="server" Visible="false" CssClass="text-center py-12 text-slate-500">
        Chưa có đơn hàng nào!
    </asp:Panel>
</asp:Content>
