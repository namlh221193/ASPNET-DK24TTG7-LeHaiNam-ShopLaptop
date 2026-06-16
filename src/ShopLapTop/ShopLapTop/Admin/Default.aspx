<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShopLapTop.Admin.Default" %>

<asp:Content ID="cHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">

  <%-- ===== STATS CARDS ===== --%>
  <div class="grid grid-cols-2 md:grid-cols-4 gap-5 mb-6">
    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <div class="flex items-center justify-between mb-3">
        <p class="text-sm font-medium text-slate-500">Sản phẩm</p>
        <div class="w-9 h-9 bg-blue-50 rounded-xl flex items-center justify-center">
          <svg class="w-5 h-5 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/></svg>
        </div>
      </div>
      <p class="text-3xl font-extrabold text-slate-800"><asp:Literal ID="litTongSP" runat="server" /></p>
    </div>
    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <div class="flex items-center justify-between mb-3">
        <p class="text-sm font-medium text-slate-500">Tổng đơn hàng</p>
        <div class="w-9 h-9 bg-emerald-50 rounded-xl flex items-center justify-center">
          <svg class="w-5 h-5 text-emerald-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/></svg>
        </div>
      </div>
      <p class="text-3xl font-extrabold text-slate-800"><asp:Literal ID="litTongDH" runat="server" /></p>
    </div>
    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <div class="flex items-center justify-between mb-3">
        <p class="text-sm font-medium text-slate-500">Chờ xử lý</p>
        <div class="w-9 h-9 bg-orange-50 rounded-xl flex items-center justify-center">
          <svg class="w-5 h-5 text-orange-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        </div>
      </div>
      <p class="text-3xl font-extrabold text-orange-500"><asp:Literal ID="litDHCho" runat="server" /></p>
    </div>
    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <div class="flex items-center justify-between mb-3">
        <p class="text-sm font-medium text-slate-500">Doanh thu</p>
        <div class="w-9 h-9 bg-violet-50 rounded-xl flex items-center justify-center">
          <svg class="w-5 h-5 text-violet-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        </div>
      </div>
      <p class="text-xl font-extrabold text-violet-600"><asp:Literal ID="litDoanhThu" runat="server" /></p>
    </div>
  </div>

  <%-- ===== CHARTS ROW ===== --%>
  <div class="grid grid-cols-1 md:grid-cols-3 gap-5 mb-6">

    <%-- Bar chart: Revenue last 7 days (2/3 width) --%>
    <div class="md:col-span-2 bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <div class="flex items-center justify-between mb-4">
        <h3 class="font-bold text-slate-700">Doanh thu 7 ngày gần nhất</h3>
        <span class="text-xs text-slate-400 bg-slate-50 px-2.5 py-1 rounded-full">triệu đồng</span>
      </div>
      <div style="height:220px;position:relative">
        <canvas id="chartDoanhThu"></canvas>
      </div>
    </div>

    <%-- Doughnut chart: Order status --%>
    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <h3 class="font-bold text-slate-700 mb-4">Trạng thái đơn hàng</h3>
      <div style="height:180px;position:relative">
        <canvas id="chartTrangThai"></canvas>
      </div>
      <div id="legendTrangThai" class="mt-3 space-y-1.5 text-xs"></div>
    </div>

  </div>

  <%-- ===== TOP PRODUCTS + RECENT ORDERS ===== --%>
  <div class="grid grid-cols-1 md:grid-cols-2 gap-5">

    <%-- Top products bar chart --%>
    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <h3 class="font-bold text-slate-700 mb-4">Top 5 sản phẩm bán chạy</h3>
      <div style="height:200px;position:relative">
        <canvas id="chartTopSP"></canvas>
      </div>
    </div>

    <%-- Quick links --%>
    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 p-5">
      <h3 class="font-bold text-slate-700 mb-4">Truy cập nhanh</h3>
      <div class="space-y-3">
        <a href='<%= ResolveUrl("~/Admin/SanPham.aspx") %>'
           class="flex items-center gap-4 p-3.5 rounded-xl border border-slate-100 hover:border-blue-200 hover:bg-blue-50 transition group">
          <div class="w-10 h-10 bg-blue-100 rounded-xl flex items-center justify-center group-hover:bg-blue-200 transition">
            <svg class="w-5 h-5 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
          </div>
          <div>
            <p class="font-semibold text-slate-700 text-sm">Thêm sản phẩm mới</p>
            <p class="text-xs text-slate-400">Quản lý danh mục laptop</p>
          </div>
          <svg class="w-4 h-4 text-slate-300 ml-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
        </a>
        <a href='<%= ResolveUrl("~/Admin/DonHang.aspx") %>'
           class="flex items-center gap-4 p-3.5 rounded-xl border border-slate-100 hover:border-emerald-200 hover:bg-emerald-50 transition group">
          <div class="w-10 h-10 bg-emerald-100 rounded-xl flex items-center justify-center group-hover:bg-emerald-200 transition">
            <svg class="w-5 h-5 text-emerald-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
          </div>
          <div>
            <p class="font-semibold text-slate-700 text-sm">Xử lý đơn hàng</p>
            <p class="text-xs text-slate-400">Cập nhật trạng thái giao hàng</p>
          </div>
          <svg class="w-4 h-4 text-slate-300 ml-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
        </a>
        <a href='<%= ResolveUrl("~/ProductList.aspx") %>'
           class="flex items-center gap-4 p-3.5 rounded-xl border border-slate-100 hover:border-violet-200 hover:bg-violet-50 transition group">
          <div class="w-10 h-10 bg-violet-100 rounded-xl flex items-center justify-center group-hover:bg-violet-200 transition">
            <svg class="w-5 h-5 text-violet-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>
          </div>
          <div>
            <p class="font-semibold text-slate-700 text-sm">Xem cửa hàng</p>
            <p class="text-xs text-slate-400">Giao diện khách hàng</p>
          </div>
          <svg class="w-4 h-4 text-slate-300 ml-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
        </a>
      </div>
    </div>

  </div>

  <%-- Hidden JSON data for charts --%>
  <asp:Literal ID="litChartData" runat="server" />

</asp:Content>

<asp:Content ID="cScripts" ContentPlaceHolderID="scripts" runat="server">
<script>
(function() {
    var cd = window.__chartData || {};
    var doanhThu = cd.doanhThu || { labels:[], data:[] };
    var trangThai = cd.trangThai || { labels:[], data:[] };
    var topSP     = cd.topSP    || { labels:[], data:[] };

    // ---- Bar: Revenue ----
    new Chart(document.getElementById('chartDoanhThu'), {
        type: 'bar',
        data: {
            labels: doanhThu.labels,
            datasets: [{
                label: 'Doanh thu (triệu đ)',
                data: doanhThu.data,
                backgroundColor: 'rgba(37,99,235,0.15)',
                borderColor: '#2563eb',
                borderWidth: 2,
                borderRadius: 6
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, grid: { color:'rgba(0,0,0,.04)' },
                     ticks: { callback: function(v) { return v + 'M'; } } },
                x: { grid: { display: false } }
            }
        }
    });

    // ---- Doughnut: TrangThai ----
    var trangThaiColors = ['#f97316','#3b82f6','#10b981','#ef4444'];
    var dtChart = new Chart(document.getElementById('chartTrangThai'), {
        type: 'doughnut',
        data: {
            labels: trangThai.labels,
            datasets: [{ data: trangThai.data, backgroundColor: trangThaiColors,
                         borderWidth: 2, borderColor: '#fff' }]
        },
        options: {
            responsive: true, maintainAspectRatio: false, cutout: '70%',
            plugins: { legend: { display: false } }
        }
    });
    // Custom legend
    var legend = document.getElementById('legendTrangThai');
    trangThai.labels.forEach(function(l, i) {
        legend.innerHTML += '<div class="flex items-center justify-between"><div class="flex items-center gap-1.5"><span style="width:10px;height:10px;border-radius:50%;background:' + trangThaiColors[i] + ';display:inline-block"></span><span class="text-slate-600">' + l + '</span></div><span class="font-bold text-slate-700">' + trangThai.data[i] + '</span></div>';
    });

    // ---- Horizontal Bar: Top SP ----
    new Chart(document.getElementById('chartTopSP'), {
        type: 'bar',
        data: {
            labels: topSP.labels,
            datasets: [{
                label: 'Số lượng bán',
                data: topSP.data,
                backgroundColor: ['#2563eb','#7c3aed','#10b981','#f97316','#ec4899'],
                borderRadius: 5
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true, maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { beginAtZero: true, grid: { color:'rgba(0,0,0,.04)' } },
                y: { grid: { display: false }, ticks: { font: { size: 11 } } }
            }
        }
    });
})();
</script>
</asp:Content>
