<%@ Page Title="Quản lý danh mục" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DanhMuc.aspx.cs" Inherits="ShopLapTop.Admin.DanhMuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-bold text-slate-800">Quản lý danh mục</h1>
        <a href="Default.aspx" class="text-primary hover:underline text-sm font-medium">&larr; Quay lại</a>
    </div>

    <%-- Form thêm / sửa --%>
    <div class="bg-white rounded-xl shadow-sm border border-slate-100 p-6 mb-6">
        <h2 class="text-lg font-bold text-slate-800 mb-4">
            <asp:Literal ID="litTieuDeForm" runat="server" Text="Thêm danh mục mới" />
        </h2>
        <asp:Label ID="lblThongBao" runat="server" Visible="false"
            CssClass="block text-sm mb-3" />

        <asp:HiddenField ID="hfMaLoai" runat="server" Value="0" />
        <asp:HiddenField ID="hfHinhAnh" runat="server" />

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-1">Tên danh mục *</label>
                <asp:TextBox ID="txtTenLoai" runat="server"
                    CssClass="w-full border border-slate-200 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary focus:outline-none" />
            </div>
            <div>
                <label class="block text-slate-700 text-sm font-medium mb-1">Nhóm *</label>
                <asp:DropDownList ID="ddlNhom" runat="server"
                    CssClass="w-full border border-slate-200 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary focus:outline-none bg-white">
                    <asp:ListItem Value="1">Nhu cầu sử dụng</asp:ListItem>
                    <asp:ListItem Value="2">Thương hiệu</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="md:col-span-1">
                <label class="block text-slate-700 text-sm font-medium mb-1">Hình ảnh đại diện</label>
                <asp:Panel ID="pnlImgPreview" runat="server" Visible="false" CssClass="mb-2 flex items-center gap-3">
                    <asp:Image ID="imgPreview" runat="server"
                        CssClass="w-20 h-14 object-cover rounded-lg border border-slate-200" />
                    <p class="text-xs text-slate-400">Hình hiện tại.<br />Chọn file mới để thay thế.</p>
                </asp:Panel>
                <asp:FileUpload ID="fuHinhAnh" runat="server"
                    CssClass="block w-full text-sm text-slate-500 file:mr-3 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-primary file:text-white hover:file:bg-secondary cursor-pointer" />
                <p class="text-xs text-slate-400 mt-1">JPG, PNG, GIF, WEBP - tối đa 5MB</p>
            </div>
        </div>

        <div class="mt-4 flex gap-3">
            <asp:Button ID="btnLuu" runat="server" Text="Lưu" OnClick="btnLuu_Click"
                CssClass="bg-primary text-white px-6 py-2 rounded-lg hover:bg-secondary cursor-pointer transition" />
            <asp:Button ID="btnHuy" runat="server" Text="Hủy" OnClick="btnHuy_Click" CausesValidation="false"
                CssClass="bg-slate-200 text-slate-700 px-6 py-2 rounded-lg hover:bg-slate-300 cursor-pointer transition" />
        </div>
    </div>

    <%-- Danh sach danh muc --%>
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

        <%-- Nhom nhu cau --%>
        <div class="bg-white rounded-xl shadow-sm border border-slate-100 overflow-hidden">
            <div class="px-5 py-3 bg-blue-50 border-b border-blue-100">
                <h3 class="font-bold text-blue-800 text-sm">Nhu cầu sử dụng</h3>
            </div>
            <asp:Repeater ID="rptNhuCau" runat="server" OnItemCommand="rpt_ItemCommand">
                <ItemTemplate>
                    <div class="flex items-center gap-3 px-5 py-3 border-b border-slate-50 hover:bg-slate-50 last:border-0">
                        <asp:Image runat="server" ImageUrl='<%# ResolveUrl("~/" + (string.IsNullOrEmpty(Eval("HinhAnh").ToString()) ? "Images/prod-gaming1.jpg" : Eval("HinhAnh").ToString())) %>'
                            CssClass="w-12 h-9 object-cover rounded-lg border border-slate-200 flex-shrink-0" />
                        <div class="flex-1 min-w-0">
                            <p class="font-medium text-slate-800 text-sm"><%# Eval("TenLoai") %></p>
                            <p class="text-xs text-slate-400"><%# Eval("SoSP") %> sản phẩm</p>
                        </div>
                        <div class="flex gap-3 flex-shrink-0">
                            <asp:LinkButton runat="server" CommandName="Sua" CommandArgument='<%# Eval("MaLoai") %>'
                                CssClass="text-blue-600 hover:underline text-sm">Sửa</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Xoa" CommandArgument='<%# Eval("MaLoai") %>'
                                CssClass="text-red-500 hover:underline text-sm"
                                OnClientClick="return confirm('Xóa danh mục này? Các liên kết sản phẩm sẽ bị xóa theo.');">Xóa</asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <%-- Nhom thuong hieu --%>
        <div class="bg-white rounded-xl shadow-sm border border-slate-100 overflow-hidden">
            <div class="px-5 py-3 bg-violet-50 border-b border-violet-100">
                <h3 class="font-bold text-violet-800 text-sm">Thương hiệu</h3>
            </div>
            <asp:Repeater ID="rptThuongHieu" runat="server" OnItemCommand="rpt_ItemCommand">
                <ItemTemplate>
                    <div class="flex items-center gap-3 px-5 py-3 border-b border-slate-50 hover:bg-slate-50 last:border-0">
                        <asp:Image runat="server" ImageUrl='<%# ResolveUrl("~/" + (string.IsNullOrEmpty(Eval("HinhAnh").ToString()) ? "Images/prod-gaming1.jpg" : Eval("HinhAnh").ToString())) %>'
                            CssClass="w-12 h-9 object-cover rounded-lg border border-slate-200 flex-shrink-0" />
                        <div class="flex-1 min-w-0">
                            <p class="font-medium text-slate-800 text-sm"><%# Eval("TenLoai") %></p>
                            <p class="text-xs text-slate-400"><%# Eval("SoSP") %> sản phẩm</p>
                        </div>
                        <div class="flex gap-3 flex-shrink-0">
                            <asp:LinkButton runat="server" CommandName="Sua" CommandArgument='<%# Eval("MaLoai") %>'
                                CssClass="text-blue-600 hover:underline text-sm">Sửa</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Xoa" CommandArgument='<%# Eval("MaLoai") %>'
                                CssClass="text-red-500 hover:underline text-sm"
                                OnClientClick="return confirm('Xóa danh mục này? Các liên kết sản phẩm sẽ bị xóa theo.');">Xóa</asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</asp:Content>
