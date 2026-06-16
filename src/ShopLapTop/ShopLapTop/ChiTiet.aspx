<%@ Page Title="Chi tiết sản phẩm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTiet.aspx.cs" Inherits="ShopLapTop.ChiTiet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlChiTiet" runat="server">
        <div class="bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-0">
                <div class="p-6 bg-slate-50">
                    <asp:Image ID="imgSP" runat="server" CssClass="w-full h-80 object-cover rounded-xl shadow-sm" />
                </div>
                <div class="p-6 md:p-8">
                    <div class="mb-3">
                        <asp:Literal ID="litTheLoai" runat="server" />
                    </div>
                    <h1 class="text-2xl md:text-3xl font-bold text-slate-800"><asp:Literal ID="litTenSP" runat="server" /></h1>
                    <p class="text-3xl font-bold text-red-600 mt-4"><asp:Literal ID="litGia" runat="server" /> đ</p>
                    <p class="text-sm text-slate-500 mt-2">Còn lại: <strong><asp:Literal ID="litSoLuong" runat="server" /></strong> sản phẩm</p>

                    <div class="mt-6 flex flex-wrap items-center gap-3">
                        <label class="text-slate-700 font-medium">Số lượng:</label>
                        <asp:TextBox ID="txtSoLuong" runat="server" Text="1" CssClass="w-20 border border-slate-200 rounded-lg px-3 py-2 text-center focus:ring-2 focus:ring-primary focus:outline-none" />
                        <button type="button" id="btnThemGio" class="bg-primary text-white px-6 py-2.5 rounded-lg font-medium hover:bg-secondary transition">
                            Thêm vào giỏ hàng
                        </button>
                    </div>

                    <div class="mt-8 pt-6 border-t border-slate-100">
                        <h3 class="font-bold text-slate-800 mb-2">Mô tả sản phẩm</h3>
                        <p class="text-slate-600 leading-relaxed"><asp:Literal ID="litMoTa" runat="server" /></p>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlKhongTimThay" runat="server" Visible="false" CssClass="text-center py-16">
        <p class="text-xl text-slate-500">Không tìm thấy sản phẩm!</p>
        <a href="Default.aspx" class="text-primary hover:underline mt-4 inline-block">Quay về trang chủ</a>
    </asp:Panel>

    <asp:HiddenField ID="hfMaSP" runat="server" />
    <asp:HiddenField ID="hfTenSP" runat="server" />
    <asp:HiddenField ID="hfGia" runat="server" />
    <asp:HiddenField ID="hfHinhAnh" runat="server" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="scripts" runat="server">
    <script>
        $(document).ready(function () {
            $('#btnThemGio').click(function () {
                $.ajax({
                    type: 'POST',
                    url: 'Ajax/ThemGioHang.aspx',
                    data: {
                        maSP: $('#<%= hfMaSP.ClientID %>').val(),
                        tenSP: $('#<%= hfTenSP.ClientID %>').val(),
                        gia: $('#<%= hfGia.ClientID %>').val(),
                        hinhAnh: $('#<%= hfHinhAnh.ClientID %>').val(),
                        soLuong: $('#<%= txtSoLuong.ClientID %>').val()
                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.success) {
                            $('#soLuongGio').text(res.soLuong);
                            alert('Đã thêm vào giỏ hàng!');
                        }
                    }
                });
            });
        });
    </script>
</asp:Content>
