<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Raporlar.aspx.cs" Inherits="NtpProje.pages.Admin.Raporlar" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Raporlar - Admin Panel</title>
    <link rel="stylesheet" href="../../css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="dashboard">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">GB</div>
            <h2>Genç Birey</h2>
        </div>

        <nav class="sidebar-menu">
            <div class="menu-section">
                <div class="menu-section-title">Ana Menü</div>
                <a href="admin_dashboard.html" class="menu-item">
                    <i>📊</i> <span>Dashboard</span>
                </a>
                <a href="#" class="menu-item">
                    <i>📄</i> <span>Sayfalar</span>
                </a>
                <a href="YaziYonetimi.html" class="menu-item">
                    <i>📝</i> <span>Blog Yazıları</span>
                </a>
                <a href="#" class="menu-item">
                    <i>🖼️</i> <span>Projeler</span>
                </a>
                <a href="#" class="menu-item">
                    <i>⚙️</i> <span>Hizmetler</span>
                </a>
            </div>

            <div class="menu-section">
                <div class="menu-section-title">İçerik Yönetimi</div>
                <a href="#" class="menu-item">
                    <i>🎨</i> <span>Medya</span>
                </a>
                <a href="#" class="menu-item">
                    <i>👥</i> <span>Ekip</span>
                </a>
                <a href="#" class="menu-item">
                    <i>💬</i> <span>Yorumlar</span>
                </a>
                <a href="IletisimMesajlari.html" class="menu-item">
                    <i>📧</i> <span>Mesajlar</span>
                </a>
            </div>

            <div class="menu-section">
                <div class="menu-section-title">Raporlama</div>
                <a href="Raporlar.html" class="menu-item active">
                    <i>📈</i> <span>Raporlar</span>
                </a>
            </div>

            <div class="menu-section">
                <div class="menu-section-title">Ayarlar</div>
                <a href="KategoriYonetimi.html" class="menu-item">
                    <i>🏷️</i> <span>Kategoriler</span>
                </a>
                <a href="#" class="menu-item">
                    <i>👤</i> <span>Kullanıcılar</span>
                </a>
                <a href="#" class="menu-item">
                    <i>🔧</i> <span>Site Ayarları</span>
                </a>
                <a href="#" class="menu-item">
                    <i>🔐</i> <span>Güvenlik</span>
                </a>
                <a href="#" class="menu-item" onclick="logout()">
                    <i>🚪</i> <span>Çıkış Yap</span>
                </a>
            </div>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Topbar -->
        <div class="topbar">
            <div class="topbar-left">
                <h1>Raporlar</h1>
                <p>Site istatistikleri ve analiz raporları</p>
            </div>
            <div class="topbar-right">
                <div class="topbar-user">
                    <div class="user-avatar" id="userAvatar">A</div>
                    <div class="user-info">
                        <div class="user-name" id="userName">Admin User</div>
                        <div class="user-role" id="userRole">Yönetici</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Date Range Selector -->
        <div class="report-filters">
            <div class="filter-group">
                <label for="dateRange">Tarih Aralığı:</label>
                <select id="dateRange" class="filter-select" onchange="updateReports()">
                    <option value="7">Son 7 Gün</option>
                    <option value="30" selected>Son 30 Gün</option>
                    <option value="90">Son 3 Ay</option>
                    <option value="365">Son 1 Yıl</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="reportType">Rapor Tipi:</label>
                <select id="reportType" class="filter-select" onchange="switchReportType()">
                    <option value="overview">Genel Bakış</option>
                    <option value="content">İçerik Analizi</option>
                    <option value="traffic">Trafik Analizi</option>
                    <option value="engagement">Etkileşim</option>
                </select>
            </div>
            <div class="filter-actions">
                <button class="btn btn-primary" onclick="exportReport()">
                    <i>📤</i> Raporu Dışa Aktar
                </button>
            </div>
        </div>

        <!-- Overview Reports -->
        <div id="overviewReports" class="reports-section">
            <!-- Key Metrics -->
            <div class="metrics-grid">
                <div class="metric-card">
                    <div class="metric-icon blue">👥</div>
                    <div class="metric-content">
                        <h3>2,543</h3>
                        <p>Toplam Ziyaretçi</p>
                        <span class="metric-change positive">+12.5%</span>
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-icon green">📄</div>
                    <div class="metric-content">
                        <h3>48</h3>
                        <p>Blog Yazısı</p>
                        <span class="metric-change positive">+3</span>
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-icon orange">💬</div>
                    <div class="metric-content">
                        <h3>156</h3>
                        <p>Toplam Yorum</p>
                        <span class="metric-change positive">+8.2%</span>
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-icon red">📧</div>
                    <div class="metric-content">
                        <h3>24</h3>
                        <p>İletişim Mesajı</p>
                        <span class="metric-change negative">-2</span>
                    </div>
                </div>
            </div>

            <!-- Charts Row 1 -->
            <div class="charts-row">
                <div class="chart-container">
                    <h3>Aylık Yorum Sayısı</h3>
                    <canvas id="commentsChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>Kategorilere Göre Yazı Dağılımı</h3>
                    <canvas id="categoryChart"></canvas>
                </div>
            </div>

            <!-- Charts Row 2 -->
            <div class="charts-row">
                <div class="chart-container">
                    <h3>Haftalık Ziyaretçi Trendi</h3>
                    <canvas id="visitorsChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>En Popüler İçerikler</h3>
                    <canvas id="popularContentChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Content Reports -->
        <div id="contentReports" class="reports-section" style="display: none;">
            <div class="charts-row">
                <div class="chart-container">
                    <h3>İçerik Türü Dağılımı</h3>
                    <canvas id="contentTypeChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>Aylık İçerik Üretimi</h3>
                    <canvas id="contentProductionChart"></canvas>
                </div>
            </div>

            <div class="charts-row">
                <div class="chart-container">
                    <h3>Yazar Performansı</h3>
                    <canvas id="authorPerformanceChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>İçerik Durumu</h3>
                    <canvas id="contentStatusChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Traffic Reports -->
        <div id="trafficReports" class="reports-section" style="display: none;">
            <div class="charts-row">
                <div class="chart-container">
                    <h3>Günlük Ziyaretçi Sayısı</h3>
                    <canvas id="dailyVisitorsChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>Ziyaretçi Kaynakları</h3>
                    <canvas id="trafficSourceChart"></canvas>
                </div>
            </div>

            <div class="charts-row">
                <div class="chart-container">
                    <h3>Sayfa Görüntüleme Sayısı</h3>
                    <canvas id="pageViewsChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>Ortalama Oturum Süresi</h3>
                    <canvas id="sessionDurationChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Engagement Reports -->
        <div id="engagementReports" class="reports-section" style="display: none;">
            <div class="charts-row">
                <div class="chart-container">
                    <h3>Yorum Etkileşimi</h3>
                    <canvas id="commentEngagementChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>Sosyal Medya Paylaşımları</h3>
                    <canvas id="socialSharesChart"></canvas>
                </div>
            </div>

            <div class="charts-row">
                <div class="chart-container">
                    <h3>E-posta Bülteni Aboneleri</h3>
                    <canvas id="newsletterSubscribersChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>İletişim Formu Dönüşümleri</h3>
                    <canvas id="contactConversionsChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Data Tables -->
        <div class="data-tables">
            <div class="table-container">
                <h3>En Popüler Sayfalar</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Sayfa</th>
                            <th>Görüntüleme</th>
                            <th>Benzersiz Ziyaretçi</th>
                            <th>Ortalama Süre</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>/blog/yeni-nesil-mimari-tasarim</td>
                            <td>1,234</td>
                            <td>856</td>
                            <td>3:45</td>
                        </tr>
                        <tr>
                            <td>/projeler/residence-istanbul-plaza</td>
                            <td>987</td>
                            <td>654</td>
                            <td>2:30</td>
                        </tr>
                        <tr>
                            <td>/hakkimizda</td>
                            <td>756</td>
                            <td>543</td>
                            <td>1:20</td>
                        </tr>
                        <tr>
                            <td>/hizmetler</td>
                            <td>654</td>
                            <td>432</td>
                            <td>2:15</td>
                        </tr>
                        <tr>
                            <td>/iletisim</td>
                            <td>543</td>
                            <td>321</td>
                            <td>1:45</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="table-container">
                <h3>Son Yorumlar</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Yazar</th>
                            <th>İçerik</th>
                            <th>Yorum</th>
                            <th>Tarih</th>
                            <th>Durum</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Ahmet Y.</td>
                            <td>Yeni Nesil Mimari Tasarım</td>
                            <td>Çok faydalı bir yazı olmuş...</td>
                            <td>2 saat önce</td>
                            <td><span class="badge badge-success">Onaylı</span></td>
                        </tr>
                        <tr>
                            <td>Zeynep K.</td>
                            <td>Sürdürülebilir İnşaat</td>
                            <td>Bu konuda daha detaylı...</td>
                            <td>5 saat önce</td>
                            <td><span class="badge badge-warning">Beklemede</span></td>
                        </tr>
                        <tr>
                            <td>Mehmet D.</td>
                            <td>3D Modelleme Teknikleri</td>
                            <td>Harika bir proje!</td>
                            <td>1 gün önce</td>
                            <td><span class="badge badge-success">Onaylı</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        let charts = {};

        // Sayfa yüklendiğinde
        window.addEventListener('load', function() {
            checkAuth();
            loadUserInfo();
            initializeCharts();
        });

        // Kullanıcı girişi kontrolü
        function checkAuth() {
            const adminUser = localStorage.getItem('adminUser');
            if (!adminUser) {
                window.location.href = 'login.html';
                return;
            }
        }

        // Kullanıcı bilgilerini yükle
        function loadUserInfo() {
            const adminUser = localStorage.getItem('adminUser');
            if (adminUser) {
                const user = JSON.parse(adminUser);
                const initial = user.name ? user.name.charAt(0).toUpperCase() : 'A';
                document.getElementById('userAvatar').textContent = initial;
                document.getElementById('userName').textContent = user.name || 'Admin';
                document.getElementById('userRole').textContent = user.role || 'Yönetici';
            }
        }

        // Grafikleri başlat
        function initializeCharts() {
            createCommentsChart();
            createCategoryChart();
            createVisitorsChart();
            createPopularContentChart();
            createContentTypeChart();
            createContentProductionChart();
            createAuthorPerformanceChart();
            createContentStatusChart();
            createDailyVisitorsChart();
            createTrafficSourceChart();
            createPageViewsChart();
            createSessionDurationChart();
            createCommentEngagementChart();
            createSocialSharesChart();
            createNewsletterSubscribersChart();
            createContactConversionsChart();
        }

        // Aylık yorum sayısı grafiği
        function createCommentsChart() {
            const ctx = document.getElementById('commentsChart').getContext('2d');
            charts.comments = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
                    datasets: [{
                        label: 'Yorum Sayısı',
                        data: [12, 19, 8, 15, 22, 18],
                        borderColor: '#667eea',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        tension: 0.4,
                        fill: true
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Kategori dağılımı grafiği
        function createCategoryChart() {
            const ctx = document.getElementById('categoryChart').getContext('2d');
            charts.category = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Mimarlık', 'İnşaat', 'Teknoloji', 'İç Mimarlık', 'Çevre'],
                    datasets: [{
                        data: [12, 8, 6, 10, 7],
                        backgroundColor: [
                            '#667eea',
                            '#f093fb',
                            '#4facfe',
                            '#43e97b',
                            '#fa709a'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
        }

        // Ziyaretçi trendi grafiği
        function createVisitorsChart() {
            const ctx = document.getElementById('visitorsChart').getContext('2d');
            charts.visitors = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'],
                    datasets: [{
                        label: 'Ziyaretçi',
                        data: [65, 59, 80, 81, 56, 55, 40],
                        backgroundColor: '#43e97b',
                        borderRadius: 4
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Popüler içerik grafiği
        function createPopularContentChart() {
            const ctx = document.getElementById('popularContentChart').getContext('2d');
            charts.popularContent = new Chart(ctx, {
                type: 'horizontalBar',
                data: {
                    labels: ['Mimari Tasarım', 'Sürdürülebilir İnşaat', '3D Modelleme', 'Ofis Tasarımı', 'Yeşil Binalar'],
                    datasets: [{
                        label: 'Görüntüleme',
                        data: [1234, 987, 856, 654, 543],
                        backgroundColor: '#fa709a'
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
                        x: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // İçerik türü dağılımı
        function createContentTypeChart() {
            const ctx = document.getElementById('contentTypeChart').getContext('2d');
            charts.contentType = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Blog Yazıları', 'Projeler', 'Hizmetler', 'Sayfalar'],
                    datasets: [{
                        data: [48, 12, 8, 6],
                        backgroundColor: ['#667eea', '#f093fb', '#4facfe', '#43e97b']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
        }

        // İçerik üretimi
        function createContentProductionChart() {
            const ctx = document.getElementById('contentProductionChart').getContext('2d');
            charts.contentProduction = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
                    datasets: [{
                        label: 'Blog Yazıları',
                        data: [3, 5, 2, 4, 6, 3],
                        borderColor: '#667eea',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        tension: 0.4
                    }, {
                        label: 'Projeler',
                        data: [1, 2, 1, 3, 2, 1],
                        borderColor: '#f093fb',
                        backgroundColor: 'rgba(240, 147, 251, 0.1)',
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Yazar performansı
        function createAuthorPerformanceChart() {
            const ctx = document.getElementById('authorPerformanceChart').getContext('2d');
            charts.authorPerformance = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Ahmet Y.', 'Ayşe D.', 'Mehmet K.', 'Zeynep Ş.', 'Can Ö.'],
                    datasets: [{
                        label: 'Yazı Sayısı',
                        data: [12, 8, 6, 10, 7],
                        backgroundColor: '#4facfe'
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // İçerik durumu
        function createContentStatusChart() {
            const ctx = document.getElementById('contentStatusChart').getContext('2d');
            charts.contentStatus = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Yayında', 'Taslak', 'Arşiv'],
                    datasets: [{
                        data: [35, 8, 5],
                        backgroundColor: ['#43e97b', '#fa709a', '#ffecd2']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
        }

        // Günlük ziyaretçi
        function createDailyVisitorsChart() {
            const ctx = document.getElementById('dailyVisitorsChart').getContext('2d');
            charts.dailyVisitors = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: Array.from({length: 30}, (_, i) => `${i+1}`),
                    datasets: [{
                        label: 'Ziyaretçi',
                        data: Array.from({length: 30}, () => Math.floor(Math.random() * 100) + 50),
                        borderColor: '#667eea',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        tension: 0.4,
                        fill: true
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Trafik kaynakları
        function createTrafficSourceChart() {
            const ctx = document.getElementById('trafficSourceChart').getContext('2d');
            charts.trafficSource = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Organik Arama', 'Sosyal Medya', 'Direkt', 'Referans', 'E-posta'],
                    datasets: [{
                        data: [45, 25, 15, 10, 5],
                        backgroundColor: ['#667eea', '#f093fb', '#4facfe', '#43e97b', '#fa709a']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
        }

        // Sayfa görüntüleme
        function createPageViewsChart() {
            const ctx = document.getElementById('pageViewsChart').getContext('2d');
            charts.pageViews = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Ana Sayfa', 'Blog', 'Projeler', 'Hizmetler', 'İletişim'],
                    datasets: [{
                        label: 'Görüntüleme',
                        data: [2500, 1800, 1200, 800, 600],
                        backgroundColor: '#43e97b'
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Oturum süresi
        function createSessionDurationChart() {
            const ctx = document.getElementById('sessionDurationChart').getContext('2d');
            charts.sessionDuration = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'],
                    datasets: [{
                        label: 'Ortalama Süre (dakika)',
                        data: [3.2, 2.8, 4.1, 3.5, 2.9, 2.1, 1.8],
                        borderColor: '#fa709a',
                        backgroundColor: 'rgba(250, 112, 154, 0.1)',
                        tension: 0.4,
                        fill: true
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Yorum etkileşimi
        function createCommentEngagementChart() {
            const ctx = document.getElementById('commentEngagementChart').getContext('2d');
            charts.commentEngagement = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
                    datasets: [{
                        label: 'Yorum Sayısı',
                        data: [12, 19, 8, 15, 22, 18],
                        backgroundColor: '#667eea'
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Sosyal medya paylaşımları
        function createSocialSharesChart() {
            const ctx = document.getElementById('socialSharesChart').getContext('2d');
            charts.socialShares = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Facebook', 'Twitter', 'LinkedIn', 'Instagram'],
                    datasets: [{
                        data: [45, 30, 15, 10],
                        backgroundColor: ['#3b5998', '#1da1f2', '#0077b5', '#e4405f']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
        }

        // E-posta bülteni aboneleri
        function createNewsletterSubscribersChart() {
            const ctx = document.getElementById('newsletterSubscribersChart').getContext('2d');
            charts.newsletterSubscribers = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
                    datasets: [{
                        label: 'Abone Sayısı',
                        data: [120, 135, 142, 158, 165, 172],
                        borderColor: '#43e97b',
                        backgroundColor: 'rgba(67, 233, 123, 0.1)',
                        tension: 0.4,
                        fill: true
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // İletişim dönüşümleri
        function createContactConversionsChart() {
            const ctx = document.getElementById('contactConversionsChart').getContext('2d');
            charts.contactConversions = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran'],
                    datasets: [{
                        label: 'Form Gönderimi',
                        data: [8, 12, 6, 15, 10, 18],
                        backgroundColor: '#fa709a'
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
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // Rapor tipi değiştirme
        function switchReportType() {
            const reportType = document.getElementById('reportType').value;
            
            // Tüm rapor bölümlerini gizle
            document.querySelectorAll('.reports-section').forEach(section => {
                section.style.display = 'none';
            });
            
            // Seçilen rapor tipini göster
            document.getElementById(reportType + 'Reports').style.display = 'block';
        }

        // Raporları güncelle
        function updateReports() {
            const dateRange = document.getElementById('dateRange').value;
            showNotification('Raporlar güncelleniyor...', 'info');
            
            // Gerçek uygulamada burada API çağrısı yapılır
            setTimeout(() => {
                showNotification('Raporlar güncellendi!', 'success');
            }, 1000);
        }

        // Raporu dışa aktar
        function exportReport() {
            showNotification('Rapor dışa aktarılıyor...', 'info');
        }

        // Çıkış yap
        function logout() {
            if (confirm('Çıkış yapmak istediğinize emin misiniz?')) {
                localStorage.removeItem('adminUser');
                window.location.href = 'login.html';
            }
        }

        // Bildirim göster
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = 'alert alert-' + type;
            notification.textContent = message;
            notification.style.position = 'fixed';
            notification.style.top = '20px';
            notification.style.right = '20px';
            notification.style.zIndex = '10000';
            notification.style.minWidth = '300px';
            notification.style.animation = 'fadeIn 0.3s ease-in';
            
            document.body.appendChild(notification);
            
            setTimeout(function() {
                notification.style.animation = 'fadeOut 0.3s ease-out';
                setTimeout(function() {
                    notification.remove();
                }, 300);
            }, 3000);
        }
    </script>
</body>
</html>
