<%@ Page Title="Quản lý sản phẩm" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="ShopLapTop.Admin.SanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-bold text-slate-800">Quản lý sản phẩm</h1>
        <a href="Default.aspx" class="text-primary hover:underline text-sm font-medium">&larr; Quay lại</a>
    </div>

    <div class="bg-white rounded-xl shadow-sm border border-slate-100 p-6 mb-6">
        <h2 class="text-lg font-bold text-slate-800 mb-4">
            <asp:Literal ID="litTieuDeForm" runat="server" Text="Thêm sản phẩm mới" />
        </h2>
        <asp:Label ID="lblThongBao" runat="server" CssClass="block text-emerald-600 text-sm mb-3" Visible="false" />

        <asp:HiddenField ID="hfMaSP" runat="server" Value="0" />

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-1">Tên sản phẩm *</label>
                <asp:TextBox ID="txtTenSP" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-1">Hãng sản xuất</label>
                <asp:TextBox ID="txtHangSX" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-1">Giá (VND) *</label>
                <asp:TextBox ID="txtGia" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-1">Số lượng *</label>
                <asp:TextBox ID="txtSoLuong" runat="server" CssClass="w-full border border-slate-200 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-1">Hình ảnh sản phẩm</label>
                <asp:HiddenField ID="hfHinhAnh" runat="server" />
                <asp:Panel ID="pnlImgPreview" runat="server" Visible="false" CssClass="mb-2 flex items-center gap-3">
                    <asp:Image ID="imgPreview" runat="server"
                        CssClass="w-24 h-16 object-cover rounded-lg border border-slate-200" />
                    <p class="text-xs text-slate-400">Hình hiện tại.<br />Chọn file mới để thay thế.</p>
                </asp:Panel>
                <asp:FileUpload ID="fuHinhAnh" runat="server"
                    CssClass="block w-full text-sm text-slate-500 file:mr-3 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-primary file:text-white hover:file:bg-secondary cursor-pointer" />
                <p class="text-xs text-slate-400 mt-1">JPG, PNG, GIF, WEBP - tối đa 5MB</p>
            </div>
            <div class="md:col-span-2">
                <label class="block text-slate-700 text-sm font-medium mb-1">Mô tả</label>
                <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="3" CssClass="w-full border border-slate-200 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-2">Nhu cầu sử dụng</label>
                <asp:CheckBoxList ID="cblNhuCau" runat="server" RepeatLayout="Flow" CssClass="flex flex-wrap gap-3" />
            </div>
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-2">Thương hiệu</label>
                <asp:CheckBoxList ID="cblThuongHieu" runat="server" RepeatLayout="Flow" CssClass="flex flex-wrap gap-3" />
            </div>
        </div>

        <div class="mt-4 flex gap-3">
            <asp:Button ID="btnLuu" runat="server" Text="Lưu" OnClick="btnLuu_Click"
                CssClass="bg-primary text-white px-6 py-2 rounded-lg hover:bg-secondary cursor-pointer transition" />
            <asp:Button ID="btnHuy" runat="server" Text="Hủy" OnClick="btnHuy_Click" CausesValidation="false"
                CssClass="bg-slate-200 text-slate-700 px-6 py-2 rounded-lg hover:bg-slate-300 cursor-pointer transition" />
        </div>
    </div>

    <div class="bg-white rounded-xl shadow-sm border border-slate-100 overflow-x-auto">
        <table class="w-full text-sm">
            <thead class="bg-slate-50">
                <tr>
                    <th class="p-3 text-left text-slate-600">ID</th>
                    <th class="p-3 text-left text-slate-600">Tên SP</th>
                    <th class="p-3 text-left text-slate-600">Danh mục</th>
                    <th class="p-3 text-right text-slate-600">Giá</th>
                    <th class="p-3 text-center text-slate-600">SL</th>
                    <th class="p-3 text-center text-slate-600">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptSanPham" runat="server" OnItemCommand="rptSanPham_ItemCommand">
                    <ItemTemplate>
                        <tr class="border-t border-slate-50 hover:bg-slate-50">
                            <td class="p-3"><%# Eval("MaSP") %></td>
                            <td class="p-3 font-medium"><%# Eval("TenSP") %></td>
                            <td class="p-3 text-slate-600 text-xs"><%# Eval("DanhMuc") %></td>
                            <td class="p-3 text-right"><%# string.Format("{0:N0}", Eval("Gia")) %> đ</td>
                            <td class="p-3 text-center"><%# Eval("SoLuong") %></td>
                            <td class="p-3 text-center whitespace-nowrap">
                                <asp:LinkButton runat="server" CommandName="Sua" CommandArgument='<%# Eval("MaSP") %>'
                                    CssClass="text-blue-600 hover:underline mr-3">Sửa</asp:LinkButton>
                                <asp:LinkButton runat="server" CommandName="Xoa" CommandArgument='<%# Eval("MaSP") %>'
                                    CssClass="text-red-600 hover:underline" OnClientClick="return confirm('Xóa sản phẩm này?');">Xóa</asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</asp:Content>
