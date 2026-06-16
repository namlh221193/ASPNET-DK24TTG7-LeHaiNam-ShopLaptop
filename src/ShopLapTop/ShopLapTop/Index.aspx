<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ShopLapTop.Index" %>

<asp:Content ID="cHead" ContentPlaceHolderID="head" runat="server">
<style>
  .cat-card:hover .cat-img { transform: scale(1.07); }
  .cat-img { transition: transform .5s ease; }
  .prod-card:hover { transform: translateY(-3px); box-shadow: 0 8px 24px rgba(0,0,0,.1); }
  .prod-card { transition: transform .2s ease, box-shadow .2s ease; }
</style>
</asp:Content>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">

  <%-- ===== HERO ===== --%>
  <section class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-blue-800 via-blue-700 to-indigo-700 text-white mb-10 shadow-xl">
    <div class="absolute -right-16 -top-16 w-80 h-80 bg-white/5 rounded-full pointer-events-none"></div>
    <div class="absolute right-10 -bottom-20 w-64 h-64 bg-indigo-500/20 rounded-full pointer-events-none"></div>
    <div class="relative z-10 grid grid-cols-1 md:grid-cols-2">
      <div class="p-8 md:p-14 flex flex-col justify-center">
        <div class="inline-flex items-center gap-2 bg-white/15 rounded-full px-4 py-1.5 text-sm text-blue-100 mb-5 w-fit">
          ✓ Chính hãng &middot; Bảo hành 24 tháng
        </div>
        <h1 class="text-3xl md:text-5xl font-extrabold leading-tight mb-4">
          Laptop <span class="text-yellow-300">chính hãng</span><br/>giá tốt nhất thị trường
        </h1>
        <p class="text-blue-100 text-base md:text-lg mb-8 max-w-md">
          Hơn 20 mẫu laptop từ 9 thương hiệu uy tín. Giao hàng toàn quốc, đổi trả trong 7 ngày.
        </p>
        <div class="flex flex-wrap gap-3">
          <a href="ProductList.aspx" class="bg-white text-blue-800 font-bold px-7 py-3 rounded-xl text-sm hover:bg-yellow-300 hover:text-blue-900 transition shadow-md">Mua sắm ngay &rarr;</a>
          <a href='ProductList.aspx?loai=<%= MaLoaiGaming %>' class="bg-white/15 text-white font-bold px-7 py-3 rounded-xl text-sm border border-white/30 hover:bg-white/25 transition">Laptop Gaming</a>
        </div>
      </div>
      <div class="hidden md:flex items-center justify-end p-6 pr-10">
        <img src="Images/prod-gaming1.jpg" alt="Laptop" class="w-80 h-60 object-cover rounded-xl shadow-2xl border-2 border-white/20" />
      </div>
    </div>
  </section>

  <%-- ===== STATS ===== --%>
  <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-10">
    <div class="bg-white rounded-xl p-5 text-center shadow-sm border border-slate-100">
      <p class="text-3xl font-extrabold text-primary"><asp:Literal ID="litTongSP" runat="server" /></p>
      <p class="text-sm text-slate-500 mt-1">Sản phẩm</p>
    </div>
    <div class="bg-white rounded-xl p-5 text-center shadow-sm border border-slate-100">
      <p class="text-3xl font-extrabold text-violet-600"><asp:Literal ID="litTongThuongHieu" runat="server" /></p>
      <p class="text-sm text-slate-500 mt-1">Thương hiệu</p>
    </div>
    <div class="bg-white rounded-xl p-5 text-center shadow-sm border border-slate-100">
      <p class="text-3xl font-extrabold text-emerald-600">24</p>
      <p class="text-sm text-slate-500 mt-1">Tháng bảo hành</p>
    </div>
    <div class="bg-white rounded-xl p-5 text-center shadow-sm border border-slate-100">
      <p class="text-3xl font-extrabold text-orange-500">2-4</p>
      <p class="text-sm text-slate-500 mt-1">Ngày giao hàng</p>
    </div>
  </div>

  <%-- ===== DANH MUC NOI BAT ===== --%>
  <div class="mb-10">
    <div class="flex items-center justify-between mb-5">
      <h2 class="text-xl font-bold text-slate-800">Danh mục nổi bật</h2>
      <a href='<%= ResolveUrl("~/ProductList.aspx") %>' class="text-sm text-primary hover:underline font-medium">Xem tất cả &rarr;</a>
    </div>
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
      <asp:Repeater ID="rptDanhMuc" runat="server">
        <ItemTemplate>
          <a href='<%= ResolveUrl("~/ProductList.aspx") %>?loai=<%# Eval("MaLoai") %>' class="cat-card group relative overflow-hidden rounded-xl block shadow-sm" style="height:160px">
            <div class="cat-img absolute inset-0 bg-cover bg-center" style="<%# GetDanhMucBgStyle(Eval("HinhAnh")) %>"></div>
            <div class="absolute inset-0 bg-gradient-to-t from-black/75 via-black/20 to-transparent"></div>
            <div class="absolute inset-0 flex flex-col justify-end p-4 text-white">
              <h3 class="font-bold text-lg group-hover:text-yellow-300 transition"><%# Eval("TenLoai") %></h3>
              <p class="text-xs text-white/70"><asp:Literal ID="litCatCount" runat="server" /><%# Eval("SoSP") %> sản phẩm</p>
            </div>
          </a>
        </ItemTemplate>
      </asp:Repeater>
    </div>
  </div>

  <%-- ===== SAN PHAM NOI BAT ===== --%>
  <div class="mb-10">
    <div class="flex items-center justify-between mb-5">
      <h2 class="text-xl font-bold text-slate-800">Sản phẩm nổi bật</h2>
      <a href="ProductList.aspx" class="text-sm text-primary hover:underline font-medium">Xem tất cả &rarr;</a>
    </div>
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
      <asp:Repeater ID="rptNoiBat" runat="server">
        <ItemTemplate>
          <div class="prod-card bg-white rounded-xl border border-slate-100 overflow-hidden flex flex-col">
            <a href='ChiTiet.aspx?id=<%# Eval("MaSP") %>' class="block overflow-hidden">
              <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TenSP") %>'
                   class="w-full h-36 object-cover hover:scale-105 transition-transform duration-300"
                   onerror="this.src='https://placehold.co/400x300/e2e8f0/94a3b8?text=Laptop'" />
            </a>
            <div class="p-3 flex flex-col flex-1">
              <div class="text-xs text-violet-600 font-medium mb-1 truncate"><%# Eval("ThuongHieu") %></div>
              <h3 class="text-sm font-semibold text-slate-800 line-clamp-2 flex-1 mb-2">
                <a href='ChiTiet.aspx?id=<%# Eval("MaSP") %>' class="hover:text-primary transition"><%# Eval("TenSP") %></a>
              </h3>
              <div class="flex items-center justify-between pt-2 border-t border-slate-50">
                <span class="font-bold text-red-600 text-sm"><%# string.Format("{0:N0}", Eval("Gia")) %> đ</span>
                <button type="button" class="btn-them-gio text-xs bg-primary text-white px-2.5 py-1.5 rounded-lg hover:bg-secondary transition"
                    data-masp='<%# Eval("MaSP") %>'
                    data-tensp='<%# Eval("TenSP") %>'
                    data-gia='<%# Eval("Gia") %>'
                    data-hinhanh='<%# Eval("HinhAnh") %>'>+ Giỏ</button>
              </div>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>
    </div>
  </div>

  <%-- ===== SAN PHAM MOI NHAT ===== --%>
  <div class="mb-10">
    <div class="flex items-center justify-between mb-5">
      <h2 class="text-xl font-bold text-slate-800">Mới nhập kho</h2>
      <a href="ProductList.aspx?sort=moi" class="text-sm text-primary hover:underline font-medium">Xem thêm &rarr;</a>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-5">
      <asp:Repeater ID="rptMoiNhat" runat="server">
        <ItemTemplate>
          <div class="prod-card bg-white rounded-xl border border-slate-100 overflow-hidden flex gap-4 p-4">
            <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TenSP") %>'
                 class="w-24 h-24 object-cover rounded-lg flex-shrink-0"
                 onerror="this.src='https://placehold.co/200x200/e2e8f0/94a3b8?text=Laptop'" />
            <div class="flex-1 min-w-0">
              <div class="text-xs text-violet-600 font-medium mb-1 truncate"><%# Eval("ThuongHieu") %></div>
              <h3 class="text-sm font-semibold text-slate-800 line-clamp-2 mb-2">
                <a href='ChiTiet.aspx?id=<%# Eval("MaSP") %>' class="hover:text-primary"><%# Eval("TenSP") %></a>
              </h3>
              <span class="font-bold text-red-600"><%# string.Format("{0:N0}", Eval("Gia")) %> đ</span>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>
    </div>
  </div>

  <%-- ===== WHY US ===== --%>
  <div class="bg-gradient-to-br from-slate-800 to-slate-900 rounded-2xl text-white p-8 md:p-10">
    <h2 class="text-2xl font-bold text-center mb-8">Tại sao chọn Shop Laptop?</h2>
    <div class="grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
      <div>
        <div class="w-14 h-14 bg-blue-500/20 rounded-2xl flex items-center justify-center mx-auto mb-3">
          <svg class="w-7 h-7 text-blue-300" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/></svg>
        </div>
        <h3 class="font-semibold text-sm">Chính hãng 100%</h3>
        <p class="text-xs text-slate-400 mt-1">Nhập khẩu trực tiếp từ hãng</p>
      </div>
      <div>
        <div class="w-14 h-14 bg-emerald-500/20 rounded-2xl flex items-center justify-center mx-auto mb-3">
          <svg class="w-7 h-7 text-emerald-300" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/></svg>
        </div>
        <h3 class="font-semibold text-sm">Đổi trả 7 ngày</h3>
        <p class="text-xs text-slate-400 mt-1">Lỗi phần cứng đổi mới ngay</p>
      </div>
      <div>
        <div class="w-14 h-14 bg-orange-500/20 rounded-2xl flex items-center justify-center mx-auto mb-3">
          <svg class="w-7 h-7 text-orange-300" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
        </div>
        <h3 class="font-semibold text-sm">Giao hàng nhanh</h3>
        <p class="text-xs text-slate-400 mt-1">2–4 ngày toàn quốc, miễn phí</p>
      </div>
      <div>
        <div class="w-14 h-14 bg-violet-500/20 rounded-2xl flex items-center justify-center mx-auto mb-3">
          <svg class="w-7 h-7 text-violet-300" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/></svg>
        </div>
        <h3 class="font-semibold text-sm">Hỗ trợ 24/7</h3>
        <p class="text-xs text-slate-400 mt-1">Tư vấn kỹ thuật nhiệt tình</p>
      </div>
    </div>
  </div>

</asp:Content>

<asp:Content ID="cScripts" ContentPlaceHolderID="scripts" runat="server">
<script>
$(function () {
    $(document).on('click', '.btn-them-gio', function () {
        var btn = $(this);
        $.ajax({
            type: 'POST', url: 'Ajax/ThemGioHang.aspx', dataType: 'json',
            data: { maSP: btn.data('masp'), tenSP: btn.data('tensp'), gia: btn.data('gia'), hinhAnh: btn.data('hinhanh'), soLuong: 1 },
            success: function (r) {
                if (r && r.success) {
                    $('#soLuongGio').text(r.soLuong);
                    btn.text('✓').addClass('bg-emerald-500');
                    setTimeout(function () { btn.text('+ Giỏ').removeClass('bg-emerald-500'); }, 1800);
                }
            }
        });
    });
});
</script>
</asp:Content>
