<%@ Page Title="Sản phẩm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="ShopLapTop.ProductList" %>

<asp:Content ID="cHead" ContentPlaceHolderID="head" runat="server">
<style>
  .prod-card:hover { transform: translateY(-3px); box-shadow: 0 8px 24px rgba(0,0,0,.1); }
  .prod-card { transition: transform .2s ease, box-shadow .2s ease; }
  .filter-active { background:#2563eb !important; color:#fff !important; font-weight:600; }
  .filter-brand-active { background:#7c3aed !important; color:#fff !important; font-weight:600; }
  .filter-price-active { background:#ea580c !important; color:#fff !important; font-weight:600; }
</style>
</asp:Content>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">

  <%-- Hidden fields luu trang thai filter --%>
  <asp:HiddenField ID="hfMaLoai" runat="server" Value="0" />
  <asp:HiddenField ID="hfGiaBand" runat="server" Value="0" />

  <%-- ===== SEARCH BAR ===== --%>
  <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-5 mb-6">
    <asp:Panel ID="pnlTimKiem" runat="server" DefaultButton="btnTimKiem">
      <div class="flex gap-3">
        <div class="relative flex-1">
          <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">
            <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
          </span>
          <asp:TextBox ID="txtTimKiem" runat="server"
            CssClass="w-full pl-12 pr-4 py-3 rounded-xl border border-slate-200 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent text-sm"
            placeholder="Tìm kiếm theo tên, thương hiệu, mô tả..." />
        </div>
        <asp:Button ID="btnTimKiem" runat="server" Text="Tìm kiếm"
          CssClass="bg-primary text-white px-7 py-3 rounded-xl font-semibold text-sm hover:bg-secondary transition whitespace-nowrap"
          OnClick="btnTimKiem_Click" />
        <asp:Button ID="btnXoaBoLoc" runat="server" Text="Xóa lọc"
          CssClass="bg-slate-100 text-slate-600 px-5 py-3 rounded-xl font-medium text-sm hover:bg-slate-200 transition whitespace-nowrap"
          OnClick="btnXoaBoLoc_Click" CausesValidation="false" />
      </div>
    </asp:Panel>
  </div>

  <%-- ===== LAYOUT: SIDEBAR + PRODUCTS ===== --%>
  <div class="flex gap-6">

    <%-- --- SIDEBAR --- --%>
    <aside class="hidden md:block w-56 flex-shrink-0">

      <%-- Nhu cau su dung --%>
      <div class="bg-white rounded-xl border border-slate-100 shadow-sm mb-4 overflow-hidden">
        <div class="px-4 py-3 border-b border-slate-50 bg-slate-50">
          <h3 class="font-bold text-slate-700 text-sm uppercase tracking-wide">Nhu cầu sử dụng</h3>
        </div>
        <nav class="p-2 space-y-0.5">
          <asp:LinkButton ID="btnTatCaNhuCau" runat="server" CausesValidation="false"
            CommandArgument="0" OnCommand="LocDanhMuc_Click"
            CssClass="block w-full text-left px-3 py-2 rounded-lg text-sm transition hover:bg-slate-50">Tất cả</asp:LinkButton>
          <asp:Repeater ID="rptNhuCau" runat="server">
            <ItemTemplate>
              <asp:LinkButton runat="server" CausesValidation="false"
                CommandArgument='<%# Eval("MaLoai") %>'
                OnCommand="LocDanhMuc_Click"
                CssClass='<%# GetNhuCauClass(Eval("MaLoai")) %>'>
                <span class="flex items-center gap-2.5">
                  <img src='<%# Eval("HinhAnh") %>' alt=""
                       class="w-7 h-7 rounded-lg object-cover flex-shrink-0"
                       onerror="this.style.display='none'" />
                  <span><%# Eval("TenLoai") %></span>
                </span>
              </asp:LinkButton>
            </ItemTemplate>
          </asp:Repeater>
        </nav>
      </div>

      <%-- Thuong hieu --%>
      <div class="bg-white rounded-xl border border-slate-100 shadow-sm mb-4 overflow-hidden">
        <div class="px-4 py-3 border-b border-slate-50 bg-slate-50">
          <h3 class="font-bold text-slate-700 text-sm uppercase tracking-wide">Thương hiệu</h3>
        </div>
        <nav class="p-2 space-y-0.5">
          <asp:LinkButton ID="btnTatCaThuongHieu" runat="server" CausesValidation="false"
            CommandArgument="0" OnCommand="LocDanhMuc_Click"
            CssClass="block w-full text-left px-3 py-2 rounded-lg text-sm transition hover:bg-slate-50">Tất cả</asp:LinkButton>
          <asp:Repeater ID="rptThuongHieu" runat="server">
            <ItemTemplate>
              <asp:LinkButton runat="server" CausesValidation="false"
                CommandArgument='<%# Eval("MaLoai") %>'
                OnCommand="LocDanhMuc_Click"
                CssClass='<%# GetThuongHieuClass(Eval("MaLoai")) %>'><%# Eval("TenLoai") %></asp:LinkButton>
            </ItemTemplate>
          </asp:Repeater>
        </nav>
      </div>

      <%-- Khoang gia --%>
      <div class="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden">
        <div class="px-4 py-3 border-b border-slate-50 bg-slate-50">
          <h3 class="font-bold text-slate-700 text-sm uppercase tracking-wide">Khoảng giá</h3>
        </div>
        <nav class="p-2 space-y-0.5">
          <asp:LinkButton ID="btnGia0" runat="server" CausesValidation="false" CommandArgument="0" OnCommand="LocGia_Click"
            CssClass="block w-full text-left px-3 py-2 rounded-lg text-sm transition hover:bg-slate-50">Tất cả mức giá</asp:LinkButton>
          <asp:LinkButton ID="btnGia1" runat="server" CausesValidation="false" CommandArgument="1" OnCommand="LocGia_Click"
            CssClass="block w-full text-left px-3 py-2 rounded-lg text-sm transition hover:bg-slate-50">Dưới 10 triệu</asp:LinkButton>
          <asp:LinkButton ID="btnGia2" runat="server" CausesValidation="false" CommandArgument="2" OnCommand="LocGia_Click"
            CssClass="block w-full text-left px-3 py-2 rounded-lg text-sm transition hover:bg-slate-50">10 – 20 triệu</asp:LinkButton>
          <asp:LinkButton ID="btnGia3" runat="server" CausesValidation="false" CommandArgument="3" OnCommand="LocGia_Click"
            CssClass="block w-full text-left px-3 py-2 rounded-lg text-sm transition hover:bg-slate-50">20 – 35 triệu</asp:LinkButton>
          <asp:LinkButton ID="btnGia4" runat="server" CausesValidation="false" CommandArgument="4" OnCommand="LocGia_Click"
            CssClass="block w-full text-left px-3 py-2 rounded-lg text-sm transition hover:bg-slate-50">Trên 35 triệu</asp:LinkButton>
        </nav>
      </div>

    </aside>

    <%-- --- PRODUCT SECTION --- --%>
    <div class="flex-1 min-w-0">

      <%-- Sort + count bar --%>
      <div class="flex items-center justify-between mb-4 bg-white rounded-xl border border-slate-100 shadow-sm px-4 py-3">
        <p class="text-sm text-slate-500">
          Tìm thấy <strong class="text-slate-800"><asp:Literal ID="litSoSP" runat="server">0</asp:Literal></strong> sản phẩm
          <asp:Literal ID="litBoLocHienThi" runat="server" />
        </p>
        <div class="flex items-center gap-2">
          <label class="text-xs text-slate-500 hidden sm:block">Sắp xếp:</label>
          <asp:DropDownList ID="ddlSapXep" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSapXep_Changed"
            CssClass="text-sm border border-slate-200 rounded-lg px-3 py-2 focus:outline-none focus:ring-1 focus:ring-primary bg-white">
            <asp:ListItem Text="Mới nhất" Value="moi" />
            <asp:ListItem Text="Giá thấp → cao" Value="gia-tang" />
            <asp:ListItem Text="Giá cao → thấp" Value="gia-giam" />
            <asp:ListItem Text="Tên A → Z" Value="ten-az" />
          </asp:DropDownList>
        </div>
      </div>

      <%-- Mobile filter chips --%>
      <div class="md:hidden flex gap-2 overflow-x-auto pb-2 mb-4 scrollbar-hide">
        <button type="button" onclick="$('#mobileFilters').slideToggle()" 
          class="flex-shrink-0 flex items-center gap-1.5 bg-white border border-slate-200 text-slate-700 text-xs px-3 py-2 rounded-full">
          <svg class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/></svg>
          Bộ lọc
        </button>
      </div>

      <%-- Mobile filter panel --%>
      <div id="mobileFilters" class="md:hidden bg-white rounded-xl border border-slate-100 shadow-sm p-4 mb-4 hidden">
        <p class="text-xs font-bold text-slate-500 uppercase mb-2">Nhu cầu</p>
        <div class="flex flex-wrap gap-2 mb-3">
          <asp:LinkButton ID="btnTatCaMobile" runat="server" CausesValidation="false"
            CommandArgument="0" OnCommand="LocDanhMuc_Click"
            CssClass="text-xs bg-slate-100 text-slate-600 px-3 py-1.5 rounded-full hover:bg-primary hover:text-white transition">Tất cả</asp:LinkButton>
          <asp:Repeater ID="rptNhuCauMobile" runat="server">
            <ItemTemplate>
              <asp:LinkButton runat="server" CausesValidation="false"
                CommandArgument='<%# Eval("MaLoai") %>'
                OnCommand="LocDanhMuc_Click"
                CssClass='<%# GetNhuCauMobileClass(Eval("MaLoai")) %>'><%# Eval("TenLoai") %></asp:LinkButton>
            </ItemTemplate>
          </asp:Repeater>
        </div>
        <p class="text-xs font-bold text-slate-500 uppercase mb-2">Giá</p>
        <div class="flex flex-wrap gap-2">
          <asp:LinkButton ID="btnGiaMobile0" runat="server" CausesValidation="false" CommandArgument="0" OnCommand="LocGia_Click"
            CssClass="text-xs bg-slate-100 text-slate-600 px-3 py-1.5 rounded-full hover:bg-orange-500 hover:text-white transition">Tất cả</asp:LinkButton>
          <asp:LinkButton ID="btnGiaMobile1" runat="server" CausesValidation="false" CommandArgument="1" OnCommand="LocGia_Click"
            CssClass="text-xs bg-slate-100 text-slate-600 px-3 py-1.5 rounded-full hover:bg-orange-500 hover:text-white transition">Dưới 10M</asp:LinkButton>
          <asp:LinkButton ID="btnGiaMobile2" runat="server" CausesValidation="false" CommandArgument="2" OnCommand="LocGia_Click"
            CssClass="text-xs bg-slate-100 text-slate-600 px-3 py-1.5 rounded-full hover:bg-orange-500 hover:text-white transition">10–20M</asp:LinkButton>
          <asp:LinkButton ID="btnGiaMobile3" runat="server" CausesValidation="false" CommandArgument="3" OnCommand="LocGia_Click"
            CssClass="text-xs bg-slate-100 text-slate-600 px-3 py-1.5 rounded-full hover:bg-orange-500 hover:text-white transition">20–35M</asp:LinkButton>
          <asp:LinkButton ID="btnGiaMobile4" runat="server" CausesValidation="false" CommandArgument="4" OnCommand="LocGia_Click"
            CssClass="text-xs bg-slate-100 text-slate-600 px-3 py-1.5 rounded-full hover:bg-orange-500 hover:text-white transition">Trên 35M</asp:LinkButton>
        </div>
      </div>

      <%-- Product grid --%>
      <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
        <asp:Repeater ID="rptSanPham" runat="server">
          <ItemTemplate>
            <div class="prod-card bg-white rounded-xl border border-slate-100 overflow-hidden flex flex-col">
              <a href='ChiTiet.aspx?id=<%# Eval("MaSP") %>' class="block overflow-hidden relative">
                <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TenSP") %>'
                     class="w-full h-40 object-cover hover:scale-105 transition-transform duration-300"
                     onerror="this.src='https://placehold.co/400x300/e2e8f0/94a3b8?text=Laptop'" />
                <%# GetHetHangOverlay(Eval("SoLuong")) %>
              </a>
              <div class="p-3 flex flex-col flex-1">
                <div class="flex flex-wrap gap-1 mb-2">
                  <%# TaoTheNhuCau(Eval("NhuCau")) %>
                  <%# TaoTheThuongHieu(Eval("ThuongHieu")) %>
                </div>
                <h3 class="text-sm font-semibold text-slate-800 line-clamp-2 flex-1 mb-3">
                  <a href='ChiTiet.aspx?id=<%# Eval("MaSP") %>' class="hover:text-primary transition"><%# Eval("TenSP") %></a>
                </h3>
                <div class="flex items-center justify-between pt-2 border-t border-slate-50">
                  <span class="font-bold text-red-600"><%# string.Format("{0:N0}", Eval("Gia")) %> đ</span>
                  <button type="button"
                      class='<%# GetButtonClass(Eval("SoLuong")) %>'
                      data-masp='<%# Eval("MaSP") %>'
                      data-tensp='<%# Eval("TenSP") %>'
                      data-gia='<%# Eval("Gia") %>'
                      data-hinhanh='<%# Eval("HinhAnh") %>'
                      <%# GetButtonDisabled(Eval("SoLuong")) %>>
                    <%# GetButtonText(Eval("SoLuong")) %>
                  </button>
                </div>
              </div>
            </div>
          </ItemTemplate>
        </asp:Repeater>
      </div>

      <%-- No results --%>
      <asp:Panel ID="pnlKhongCoSP" runat="server" Visible="false"
        CssClass="text-center py-16 bg-white rounded-xl border border-slate-100">
        <svg class="w-16 h-16 text-slate-300 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1"><path stroke-linecap="round" stroke-linejoin="round" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        <p class="text-slate-500 text-lg font-medium mb-2">Không tìm thấy sản phẩm</p>
        <p class="text-slate-400 text-sm mb-4">Hãy thử thay đổi bộ lọc hoặc từ khóa tìm kiếm</p>
        <asp:Button ID="btnResetKhongCoSP" runat="server" Text="Xem tất cả sản phẩm"
          CssClass="bg-primary text-white px-6 py-2.5 rounded-xl font-medium text-sm hover:bg-secondary transition"
          OnClick="btnXoaBoLoc_Click" CausesValidation="false" />
      </asp:Panel>

    </div><%-- end product section --%>

  </div><%-- end flex layout --%>

</asp:Content>

<asp:Content ID="cScripts" ContentPlaceHolderID="scripts" runat="server">
<script>
$(function () {
    $(document).on('click', '.btn-them-gio:not(:disabled)', function () {
        var btn = $(this);
        $.ajax({
            type: 'POST', url: 'Ajax/ThemGioHang.aspx', dataType: 'json',
            data: { maSP: btn.data('masp'), tenSP: btn.data('tensp'), gia: btn.data('gia'), hinhAnh: btn.data('hinhanh'), soLuong: 1 },
            success: function (r) {
                if (r && r.success) {
                    $('#soLuongGio').text(r.soLuong);
                    btn.text('✓ Đã thêm').addClass('!bg-emerald-500');
                    setTimeout(function () { btn.text('+ Giỏ').removeClass('!bg-emerald-500'); }, 1800);
                }
            }
        });
    });
});
</script>
</asp:Content>
