<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_dashboard.aspx.cs" Inherits="NtpProje.pages.Admin.WebForm1" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/admin.css") %>" />
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
</head>
<body class="dashboard">
    <form id="form1" runat="server">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">GB</div>
                <h2>Genç Birey</h2>
            </div>

            <nav class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-section-title">ANA MENÜ</div>
                    <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="~/pages/Admin/admin_dashboard.aspx" CssClass="menu-item active"><i>📊</i> <span>Dashboard</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkBlogYazilari" runat="server" NavigateUrl="~/pages/Admin/YaziYonetimi.aspx" CssClass="menu-item"><i>📝</i> <span>Blog Yazıları</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkProjeler" runat="server" NavigateUrl="~/pages/Admin/ProjeYonetimi.aspx" CssClass="menu-item"><i>🖼️</i> <span>Projeler</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkHizmetler" runat="server" NavigateUrl="#" CssClass="menu-item"><i>⚙️</i> <span>Hizmetler</span></asp:HyperLink>
                </div>

                <div class="menu-section">
                    <div class="menu-section-title">RAPORLAMA</div>
                    <asp:HyperLink ID="lnkRaporlar" runat="server" NavigateUrl="~/pages/Admin/Raporlar.aspx" CssClass="menu-item"><i>📈</i> <span>Raporlar</span></asp:HyperLink>
                </div>

                <div class="menu-section">
                    <div class="menu-section-title">AYARLAR</div>
                   
                    <asp:LinkButton ID="lnkCikisYap" runat="server" CssClass="menu-item" OnClick="lnkCikisYap_Click"><i>🚪</i> <span>Çıkış Yap</span></asp:LinkButton>
                </div>
            </nav>
        </aside>     
        <main class="main-content">
            <asp:Literal ID="ltrMesaj" runat="server" Visible="false"></asp:Literal>
            <div class="topbar">
                <div class="topbar-left">
                    <h1>Dashboard</h1>
                </div>
                <div class="topbar-right">
                    <div class="search-container">
                        <input type="text" class="search-input" placeholder="Search for..." />
                        <button class="search-btn" type="button">🔍</button>
                    </div>
                    <div class="user-icon">
                        <asp:Literal ID="ltrUserAvatar" runat="server">👤</asp:Literal>
                    </div>
                </div>
            </div>

            <div class="dashboard-content">
                <div class="page-header">
                    <h2>Dashboard</h2>
                    <nav class="breadcrumb">Dashboard</nav>
                </div>

                <div class="dashboard-cards">
                    <div class="info-card card-primary">
                        <div class="card-content">
                            <span class="card-label">Blog Sayısı</span>
                            <span class="card-value">
                                <asp:Literal ID="ltrBlogSayisi" runat="server">0</asp:Literal>
                            </span>
                        </div>
                    </div>
                    <div class="info-card card-warning">
                        <div class="card-content">
                            <span class="card-label">Yeni Mesaj</span>
                            <span class="card-value">
                                <asp:Literal ID="ltrYeniMesajSayisi" runat="server">0</asp:Literal>
                            </span>
                        </div>
                    </div>
                    <div class="info-card card-success">
                        <div class="card-content">
                            <span class="card-label">Hizmet Sayısı</span>
                            <span class="card-value">
                                <asp:Literal ID="ltrHizmetSayisi" runat="server">0</asp:Literal>
                            </span>
                        </div>
                    </div>
                    <div class="info-card card-danger">
                        <div class="card-content">
                            <span class="card-label">Proje Sayısı</span>
                            <span class="card-value">
                                <asp:Literal ID="ltrProjeSayisi" runat="server">0</asp:Literal>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="charts-container">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h3>📊 Area Chart Example</h3>
                        </div>
                        <div class="chart-body">
                            <canvas id="areaChart"></canvas>
                        </div>
                    </div>
                    <div class="chart-card">
                        <div class="chart-header">
                            <h3>📊 Bar Chart Example</h3>
                        </div>
                        <div class="chart-body">
                            <canvas id="barChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="datatable-container">
                    <div class="datatable-header">
                        <h3>📋 DataTable Example</h3>
                        <div class="datatable-controls">
                            <label>
                                Show 
                                <select class="entries-select">
                                    <option>10</option>
                                    <option>25</option>
                                    <option>50</option>
                                    <option>100</option>
                                </select>
                                entries
                            </label>
                            <input type="text" class="datatable-search" placeholder="Search:" />
                        </div>
                    </div>
                    <div class="datatable-wrapper">
                        <table class="datatable">
                            <thead>
                                <tr>
                                    <th>Name <span class="sort-icon">⇅</span></th>
                                    <th>Position <span class="sort-icon">⇅</span></th>
                                    <th>Office <span class="sort-icon">⇅</span></th>
                                    <th>Age <span class="sort-icon">⇅</span></th>
                                    <th>Start date <span class="sort-icon">⇅</span></th>
                                    <th>Salary <span class="sort-icon">⇅</span></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Airi Satou</td>
                                    <td>Accountant</td>
                                    <td>Tokyo</td>
                                    <td>33</td>
                                    <td>2008/11/28</td>
                                    <td>$162,700</td>
                                </tr>
                                <tr>
                                    <td>Angelica Ramos</td>
                                    <td>Chief Executive Officer (CEO)</td>
                                    <td>London</td>
                                    <td>47</td>
                                    <td>2009/10/09</td>
                                    <td>$1,200,000</td>
                                </tr>
                                <tr>
                                    <td>Ashton Cox</td>
                                    <td>Junior Technical Author</td>
                                    <td>San Francisco</td>
                                    <td>66</td>
                                    <td>2009/01/12</td>
                                    <td>$86,000</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </main>
    </form>

    <script>
        // Bildirim göster (C# tarafından çağrılabilir)
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = 'alert alert-' + type;
            notification.textContent = message;
            notification.style.position = 'fixed';
            notification.style.top = '20px';
            notification.style.right = '20px';
            notification.style.zIndex = '10000';
            notification.style.padding = '15px 20px';
            notification.style.borderRadius = '8px';
            notification.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';
            document.body.appendChild(notification);

            setTimeout(function () {
                notification.style.opacity = '0';
                notification.style.transition = 'opacity 0.3s';
                setTimeout(function () {
                    notification.remove();
                }, 300);
            }, 3000);
        }

        // Area Chart
        const areaCtx = document.getElementById('areaChart');
        if (areaCtx) {
            new Chart(areaCtx, {
                type: 'line',
                data: {
                    labels: ['Mar 1', 'Mar 2', 'Mar 3', 'Mar 4', 'Mar 5', 'Mar 6', 'Mar 7', 'Mar 8', 'Mar 9', 'Mar 10', 'Mar 11', 'Mar 12', 'Mar 13'],
                    datasets: [{
                        label: 'Area Chart',
                        data: [10000, 15000, 20000, 25000, 30000, 28000, 22000, 18000, 20000, 25000, 30000, 32000, 35000],
                        borderColor: 'rgb(75, 192, 192)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 40000,
                            ticks: {
                                stepSize: 10000
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
                    labels: ['January', 'February', 'March', 'April', 'May', 'June'],
                    datasets: [{
                        label: 'Bar Chart',
                        data: [5000, 7000, 9000, 11000, 13000, 15000],
                        backgroundColor: 'rgba(54, 162, 235, 0.8)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 15000,
                            ticks: {
                                stepSize: 5000
                            }
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>
