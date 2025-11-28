<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="admin_dashboard.aspx.cs" Inherits="NtpProje_Web.Admin.admin_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <style>
        /* Dashboard Content Padding */
        .dashboard-content {
            background: #f5f7fa;
            padding: 30px;
            margin-left: 0;
            margin-right: 0;
            min-height: calc(100vh - 60px);
        }

        /* Dashboard Stats Cards */
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: #ffffff;
            border-radius: 4px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            transition: transform 0.2s, box-shadow 0.2s;
            border-left: 4px solid #4e73df;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.25rem 2rem 0 rgba(58, 59, 69, 0.25);
        }

        .stat-card.blue { border-left-color: #4e73df; }
        .stat-card.orange { border-left-color: #f6c23e; }
        .stat-card.green { border-left-color: #1cc88a; }
        .stat-card.red { border-left-color: #e74a3b; }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }

        .stat-icon.blue { background: #e3f2fd; }
        .stat-icon.orange { background: #fff3cd; }
        .stat-icon.green { background: #d4edda; }
        .stat-icon.red { background: #f8d7da; }

        .stat-content {
            flex: 1;
        }

        .stat-content h3 {
            margin: 0;
            font-size: 32px;
            font-weight: 700;
            color: #5a5c69;
            line-height: 1.2;
        }

        .stat-content p {
            margin: 5px 0 0 0;
            color: #858796;
            font-size: 13px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Charts Container */
        .charts-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }

        .chart-card {
            background: #ffffff;
            border-radius: 4px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            overflow: hidden;
        }

        .chart-header {
            padding: 15px 20px;
            border-bottom: 1px solid #e3e6f0;
            background: #f8f9fc;
        }

        .chart-header h3 {
            font-size: 16px;
            font-weight: 700;
            color: #5a5c69;
            margin: 0;
        }

        .chart-wrapper {
            padding: 20px;
            height: 300px;
            position: relative;
        }

        /* Dashboard Table / Activities */
        .dashboard-table {
            background: #ffffff;
            border-radius: 4px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            overflow: hidden;
        }

        .table-header {
            padding: 15px 20px;
            border-bottom: 1px solid #e3e6f0;
            background: #f8f9fc;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h2 {
            margin: 0;
            font-size: 16px;
            font-weight: 700;
            color: #5a5c69;
        }

        .btn-export-csv {
            background: #1cc88a;
            color: #ffffff;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-export-csv:hover {
            background: #17a673;
        }

        .btn-export-csv:active {
            background: #13855c;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            border-bottom: 1px solid #e3e6f0;
            transition: background 0.2s;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-item:hover {
            background: #f8f9fc;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: #5a5c69;
            margin-bottom: 4px;
            font-size: 14px;
        }

        .activity-meta {
            font-size: 12px;
            color: #858796;
            margin-bottom: 2px;
        }

        .activity-date {
            font-size: 12px;
            color: #b7b9cc;
        }

        /* Topbar */
        .topbar-left p {
            margin: 5px 0 0 0;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }

        /* Empty State */
        .empty-activities {
            text-align: center;
            padding: 50px 20px;
            color: #858796;
        }

        .empty-activities h3 {
            font-size: 18px;
            color: #5a5c69;
            margin-bottom: 10px;
        }

        .empty-activities p {
            font-size: 14px;
            color: #858796;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .dashboard-stats {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .charts-container {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .dashboard-content {
                padding: 20px;
            }

            .dashboard-stats {
                grid-template-columns: 1fr;
                gap: 15px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="topbar">
        <div class="topbar-left">
            <h1>📊 Dashboard</h1>
            <p>Genel bakış ve istatistikler</p>
        </div>
    </div>

    <div class="dashboard-content">
        <!-- Dashboard Stats -->
        <div class="dashboard-stats">
            <div class="stat-card blue">
                <div class="stat-icon blue">📝</div>
                <div class="stat-content">
                    <h3><asp:Label ID="lblTotalPosts" runat="server" Text="0" /></h3>
                    <p>Toplam Blog Yazısı</p>
                </div>
            </div>

            <div class="stat-card orange">
                <div class="stat-icon orange">💬</div>
                <div class="stat-content">
                    <h3><asp:Label ID="lblNewComments" runat="server" Text="0" /></h3>
                    <p>Onay Bekleyen Yorum</p>
                </div>
            </div>

            <div class="stat-card green">
                <div class="stat-icon green">💼</div>
                <div class="stat-content">
                    <h3><asp:Label ID="lblProjectRequests" runat="server" Text="0" /></h3>
                    <p>Okunmamış Proje Teklifi</p>
                </div>
            </div>

            <div class="stat-card red">
                <div class="stat-icon red">👥</div>
                <div class="stat-content">
                    <h3><asp:Label ID="lblTotalUsers" runat="server" Text="0" /></h3>
                    <p>Toplam Kullanıcı</p>
                </div>
            </div>
        </div>

        <!-- Charts Section -->
        <div class="charts-container">
            <!-- Pie Chart - Blog ve Proje Dağılımı -->
            <div class="chart-card">
                <div class="chart-header">
                    <h3>📊 Blog ve Proje Dağılımı</h3>
                </div>
                <div class="chart-wrapper">
                    <canvas id="pieChart"></canvas>
                </div>
            </div>

            <!-- Bar Chart - Blog ve Proje Sayıları -->
            <div class="chart-card">
                <div class="chart-header">
                    <h3>📈 Blog ve Proje Sayıları</h3>
                </div>
                <div class="chart-wrapper">
                    <canvas id="barChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Second Charts Row - Uzman Ekip ve İletişim -->
        <div class="charts-container">
            <!-- Bar Chart - Uzman Ekip ve İletişim Sayıları -->
            <div class="chart-card">
                <div class="chart-header">
                    <h3>👥 Uzman Ekip ve İletişim Sayıları</h3>
                </div>
                <div class="chart-wrapper">
                    <canvas id="teamContactChart"></canvas>
                </div>
            </div>

            <!-- Pie Chart - Uzman Ekip ve İletişim Dağılımı -->
            <div class="chart-card">
                <div class="chart-header">
                    <h3>📊 Uzman Ekip ve İletişim Dağılımı</h3>
                </div>
                <div class="chart-wrapper">
                    <canvas id="teamContactPieChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Hidden Field for Chart Data -->
        <asp:HiddenField ID="hfChartData" runat="server" />
        <asp:Label ID="lblProjectCount" runat="server" Text="0" style="display:none;"></asp:Label>
        <asp:Label ID="lblTeamMemberCount" runat="server" Text="0" style="display:none;"></asp:Label>
        <asp:Label ID="lblContactMessageCount" runat="server" Text="0" style="display:none;"></asp:Label>

        <!-- Recent Activities -->
        <div class="dashboard-table">
            <div class="table-header">
                <h2>Son Aktiviteler</h2>
                <asp:Button ID="btnExportCSV" runat="server" 
                    Text="📥 CSV İndir" 
                    CssClass="btn-export-csv"
                    OnClick="btnExportCSV_Click" />
            </div>

            <asp:PlaceHolder ID="phEmptyActivities" runat="server" Visible="false">
                <div class="empty-activities">
                    <h3>📭 Henüz aktivite yok</h3>
                    <p>Aktiviteler burada görünecek.</p>
                </div>
            </asp:PlaceHolder>

            <asp:Repeater ID="rptRecentActivities" runat="server">
                <ItemTemplate>
                    <div class="activity-item">
                        <div class="activity-icon" style="background: <%# Eval("IconColor") %>;">
                            <%# Eval("Icon") %>
                        </div>
                        <div class="activity-content">
                            <div class="activity-title"><%# Eval("Title") %></div>
                            <div class="activity-meta"><%# Eval("Meta") %></div>
                            <div class="activity-date"><%# Eval("Date") %></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script>
            // Grafik verilerini yükle
        document.addEventListener('DOMContentLoaded', function() {
            // Server-side'dan gelen verileri kullan
            const blogCount = parseInt(document.getElementById('<%= lblTotalPosts.ClientID %>').textContent) || 0;
            const projectCount = parseInt(document.getElementById('<%= lblProjectCount.ClientID %>').textContent) || 0;
            const teamMemberCount = parseInt(document.getElementById('<%= lblTeamMemberCount.ClientID %>').textContent) || 0;
            const contactMessageCount = parseInt(document.getElementById('<%= lblContactMessageCount.ClientID %>').textContent) || 0;

            // Pasta Grafiği
            const pieCtx = document.getElementById('pieChart');
            if (pieCtx) {
                new Chart(pieCtx, {
                    type: 'pie',
                    data: {
                        labels: ['Blog Yazıları', 'Projeler'],
                        datasets: [{
                            label: 'Dağılım',
                            data: [blogCount, projectCount],
                            backgroundColor: [
                                'rgba(78, 115, 223, 0.8)',
                                'rgba(28, 200, 138, 0.8)'
                            ],
                            borderColor: [
                                'rgba(78, 115, 223, 1)',
                                'rgba(28, 200, 138, 1)'
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
                                        size: 14,
                                        family: "'Source Sans Pro', sans-serif"
                                    },
                                    color: '#5a5c69'
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(90, 92, 105, 0.9)',
                                titleFont: {
                                    family: "'Source Sans Pro', sans-serif",
                                    size: 14
                                },
                                bodyFont: {
                                    family: "'Source Sans Pro', sans-serif",
                                    size: 13
                                },
                                callbacks: {
                                    label: function(context) {
                                        var label = context.label || '';
                                        var value = context.parsed || 0;
                                        var total = context.dataset.data.reduce((a, b) => a + b, 0);
                                        var percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                        return label + ': ' + value + ' (' + percentage + '%)';
                                    }
                                }
                            }
                        }
                    }
                });
            }

            // Çubuk Grafiği
            const barCtx = document.getElementById('barChart');
            if (barCtx) {
                new Chart(barCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Blog Yazıları', 'Projeler'],
                        datasets: [{
                            label: 'Sayı',
                            data: [blogCount, projectCount],
                            backgroundColor: [
                                'rgba(78, 115, 223, 0.8)',
                                'rgba(28, 200, 138, 0.8)'
                            ],
                            borderColor: [
                                'rgba(78, 115, 223, 1)',
                                'rgba(28, 200, 138, 1)'
                            ],
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                backgroundColor: 'rgba(90, 92, 105, 0.9)',
                                titleFont: {
                                    family: "'Source Sans Pro', sans-serif",
                                    size: 14
                                },
                                bodyFont: {
                                    family: "'Source Sans Pro', sans-serif",
                                    size: 13
                                },
                                callbacks: {
                                    label: function(context) {
                                        return 'Toplam: ' + context.parsed.y;
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    stepSize: 1,
                                    font: {
                                        size: 12,
                                        family: "'Source Sans Pro', sans-serif"
                                    },
                                    color: '#858796'
                                },
                                grid: {
                                    color: 'rgba(227, 230, 240, 0.5)'
                                }
                            },
                            x: {
                                ticks: {
                                    font: {
                                        size: 12,
                                        family: "'Source Sans Pro', sans-serif"
                                    },
                                    color: '#5a5c69'
                                },
                                grid: {
                                    display: false
                                }
                            }
                        }
                    }
                });
            }

            // Uzman Ekip ve İletişim - Çubuk Grafiği
            const teamContactCtx = document.getElementById('teamContactChart');
            if (teamContactCtx) {
                new Chart(teamContactCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Uzman Ekip', 'İletişim Mesajları'],
                        datasets: [{
                            label: 'Sayı',
                            data: [teamMemberCount, contactMessageCount],
                            backgroundColor: [
                                'rgba(246, 194, 62, 0.8)',  // Turuncu - Uzman Ekip
                                'rgba(231, 74, 59, 0.8)'   // Kırmızı - İletişim
                            ],
                            borderColor: [
                                'rgba(246, 194, 62, 1)',
                                'rgba(231, 74, 59, 1)'
                            ],
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                backgroundColor: 'rgba(90, 92, 105, 0.9)',
                                titleFont: {
                                    family: "'Source Sans Pro', sans-serif",
                                    size: 14
                                },
                                bodyFont: {
                                    family: "'Source Sans Pro', sans-serif",
                                    size: 13
                                },
                                callbacks: {
                                    label: function(context) {
                                        return 'Toplam: ' + context.parsed.y;
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    stepSize: 1,
                                    font: {
                                        size: 12,
                                        family: "'Source Sans Pro', sans-serif"
                                    },
                                    color: '#858796'
                                },
                                grid: {
                                    color: 'rgba(227, 230, 240, 0.5)'
                                }
                            },
                            x: {
                                ticks: {
                                    font: {
                                        size: 12,
                                        family: "'Source Sans Pro', sans-serif"
                                    },
                                    color: '#5a5c69'
                                },
                                grid: {
                                    display: false
                                }
                            }
                        }
                    }
                });
            }

            // Uzman Ekip ve İletişim - Pasta Grafiği
            const teamContactPieCtx = document.getElementById('teamContactPieChart');
            if (teamContactPieCtx) {
                new Chart(teamContactPieCtx, {
                    type: 'pie',
                    data: {
                        labels: ['Uzman Ekip', 'İletişim Mesajları'],
                        datasets: [{
                            label: 'Dağılım',
                            data: [teamMemberCount, contactMessageCount],
                            backgroundColor: [
                                'rgba(246, 194, 62, 0.8)',  // Turuncu - Uzman Ekip
                                'rgba(231, 74, 59, 0.8)'   // Kırmızı - İletişim
                            ],
                            borderColor: [
                                'rgba(246, 194, 62, 1)',
                                'rgba(231, 74, 59, 1)'
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
                                        size: 14,
                                        family: "'Source Sans Pro', sans-serif"
                                    },
                                    color: '#5a5c69'
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(90, 92, 105, 0.9)',
                                titleFont: {
                                    family: "'Source Sans Pro', sans-serif",
                                    size: 14
                                },
                                bodyFont: {
                                    family: "'Source Sans Pro', sans-serif",
                                    size: 13
                                },
                                callbacks: {
                                    label: function(context) {
                                        var label = context.label || '';
                                        var value = context.parsed || 0;
                                        var total = context.dataset.data.reduce((a, b) => a + b, 0);
                                        var percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                        return label + ': ' + value + ' (' + percentage + '%)';
                                    }
                                }
                            }
                        }
                    }
                });
            }
        });
    </script>

</asp:Content>
