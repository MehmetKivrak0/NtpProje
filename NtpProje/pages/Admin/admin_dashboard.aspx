<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="admin_dashboard.aspx.cs" Inherits="NtpProje_Web.Admin.admin_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <style>
        /* Dashboard'a Özel Ufak CSS Ayarları */
        .dashboard-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .charts-container { display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .info-card { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); border-left: 4px solid #63207c; }
        .card-label { display: block; color: #666; font-size: 14px; margin-bottom: 5px; }
        .card-value { font-size: 28px; font-weight: bold; color: #333; }
        .chart-card { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .chart-body { height: 300px; position: relative; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="topbar">
        <div class="topbar-left">
            <div class="logo-container" style="display: flex; align-items: center; gap: 15px;">
                <div class="logo-circle" style="width: 50px; height: 50px; border-radius: 50%; background: linear-gradient(135deg, #63207c 0%, #4f1a63 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 20px; box-shadow: 0 2px 10px rgba(99, 32, 124, 0.3);">
                    IY
                </div>
                <div>
                    <h1 style="margin: 0; color: white; font-size: 24px; font-weight: 600;">Innovate Yazılım</h1>
                </div>
            </div>
        </div>
        <div class="topbar-right" style="display: flex; align-items: center; gap: 15px;">
            <div class="user-info" style="text-align: right;">
                <div class="user-name" style="font-weight: 600; color: white; font-size: 14px;">
                    <asp:Label ID="lblUserName" runat="server"></asp:Label>
                </div>
                <div class="user-role" style="font-size: 12px; color: rgba(255, 255, 255, 0.8);">
                    <asp:Label ID="lblUserRole" runat="server" Text="Yönetici"></asp:Label>
                </div>
            </div>
            <div class="user-avatar" style="width: 45px; height: 45px; border-radius: 50%; background: linear-gradient(135deg, #63207c 0%, #4f1a63 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 18px; box-shadow: 0 2px 10px rgba(99, 32, 124, 0.3);">
                <asp:Label ID="lblUserInitials" runat="server"></asp:Label>
            </div>
        </div>
    </div>

    <div class="dashboard-content">
        <div class="page-header">
            <h2>Genel Bakış</h2>
        </div>

        <div class="dashboard-cards">
            <div class="info-card">
                <div class="card-content">
                    <span class="card-label">Blog Yazıları</span>
                    <span class="card-value">
                        <asp:Label ID="lblTotalPosts" runat="server" Text="0"></asp:Label>
                    </span>
                </div>
            </div>
            <div class="info-card">
                <div class="card-content">
                    <span class="card-label">Yeni Mesajlar</span>
                    <span class="card-value">
                         <asp:Label ID="lblNewComments" runat="server" Text="0"></asp:Label>
                    </span>
                </div>
            </div>
            <div class="info-card">
                <div class="card-content">
                    <span class="card-label">Proje Teklifleri</span>
                    <span class="card-value">
                        <asp:Label ID="lblProjectRequests" runat="server" Text="0"></asp:Label>
                    </span>
                </div>
            </div>
            <div class="info-card">
                <div class="card-content">
                    <span class="card-label">Toplam Kullanıcı</span>
                    <span class="card-value">
                        <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                    </span>
                </div>
            </div>
        </div>
        
        <!-- Gizli label - Pasta grafiği için proje sayısı -->
        <asp:Label ID="lblProjectCount" runat="server" Text="0" style="display:none;"></asp:Label>

        <div class="charts-container">
            <div class="chart-card">
                <div class="chart-header">
                    <h3>📊 Blog ve Proje Dağılımı</h3>
                </div>
                <div class="chart-body">
                    <canvas id="pieChart"></canvas>
                </div>
            </div>
            <div class="chart-card">
                <div class="chart-header">
                    <h3>📊 Satış / Gelir Grafiği</h3>
                </div>
                <div class="chart-body">
                    <canvas id="barChart"></canvas>
                </div>
            </div>
        </div>

        <div class="datatable-container">
            <div class="datatable-header">
                <h3>📋 Son İşlemler</h3>
            </div>
            <div class="datatable-wrapper" style="background:white; padding:20px; border-radius:8px;">
                <asp:Repeater ID="rptRecentActivities" runat="server">
                    <ItemTemplate>
                        <div class="activity-item" style="display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #eee; transition: background 0.2s;">
                            <div class="activity-icon" style="width: 40px; height: 40px; border-radius: 50%; background: <%# Eval("IconColor") %>; display: flex; align-items: center; justify-content: center; margin-right: 15px; font-size: 18px;">
                                <%# Eval("Icon") %>
                            </div>
                            <div class="activity-content" style="flex: 1;">
                                <div class="activity-title" style="font-weight: 600; color: #333; margin-bottom: 4px;">
                                    <%# Eval("Title") %>
                                </div>
                                <div class="activity-meta" style="font-size: 12px; color: #999;">
                                    <%# Eval("Meta") %>
                                </div>
                            </div>
                            <div class="activity-date" style="font-size: 12px; color: #999; margin-left: 15px;">
                                <%# Eval("Date") %>
                            </div>
                        </div>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <div class="activity-item" style="display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #eee; background: #f9f9f9; transition: background 0.2s;">
                            <div class="activity-icon" style="width: 40px; height: 40px; border-radius: 50%; background: <%# Eval("IconColor") %>; display: flex; align-items: center; justify-content: center; margin-right: 15px; font-size: 18px;">
                                <%# Eval("Icon") %>
                            </div>
                            <div class="activity-content" style="flex: 1;">
                                <div class="activity-title" style="font-weight: 600; color: #333; margin-bottom: 4px;">
                                    <%# Eval("Title") %>
                                </div>
                                <div class="activity-meta" style="font-size: 12px; color: #999;">
                                    <%# Eval("Meta") %>
                                </div>
                            </div>
                            <div class="activity-date" style="font-size: 12px; color: #999; margin-left: 15px;">
                                <%# Eval("Date") %>
                            </div>
                        </div>
                    </AlternatingItemTemplate>
                </asp:Repeater>
                <asp:PlaceHolder ID="phEmptyActivities" runat="server" Visible="false">
                    <div style="text-align: center; padding: 40px; color: #999;">
                        <p>Henüz işlem kaydı bulunmamaktadır.</p>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>

    </div>

    <script>
        // Pie Chart - Blog ve Proje Dağılımı
        const pieCtx = document.getElementById('pieChart');
        if (pieCtx) {
            // Server-side'dan gelen verileri kullan
            const blogCount = parseInt(document.getElementById('<%= lblTotalPosts.ClientID %>').textContent) || 0;
            const projectCount = parseInt(document.getElementById('<%= lblProjectCount.ClientID %>').textContent) || 0;
            
            new Chart(pieCtx, {
                type: 'pie',
                data: {
                    labels: ['Blog Yazıları', 'Projeler'],
                    datasets: [{
                        label: 'İçerik Dağılımı',
                        data: [blogCount, projectCount],
                        backgroundColor: [
                            'rgba(99, 32, 124, 0.8)',  // Mor - Blog
                            'rgba(40, 167, 69, 0.8)'   // Yeşil - Proje
                        ],
                        borderColor: [
                            'rgba(99, 32, 124, 1)',
                            'rgba(40, 167, 69, 1)'
                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                padding: 15,
                                font: {
                                    size: 14
                                }
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    let label = context.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                    const percentage = ((context.parsed / total) * 100).toFixed(1);
                                    label += context.parsed + ' (' + percentage + '%)';
                                    return label;
                                }
                            }
                        }
                    }
                }
            });
        }

        // Bar Chart
        const barCtx = document.getElementById('barChart');
        if (barCtx) {
            new Chart(barCtx, {
                type: 'bar',
                data: {
                    labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
                    datasets: [{
                        label: 'Gelir (TL)',
                        data: [5000, 7000, 9000, 11000, 13000, 15000],
                        backgroundColor: 'rgba(99, 32, 124, 0.6)'
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false }
            });
        }
    </script>

</asp:Content>