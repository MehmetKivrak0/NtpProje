<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YaziYonetimi.aspx.cs" Inherits="NtpProje.pages.Admin.YaziYonetimi" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Yazı Yönetimi - Admin Panel</title>
    <link rel="stylesheet" href="../../css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">
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
                <a href="YaziYonetimi.html" class="menu-item active">
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
                <h1>Yazı Yönetimi</h1>
                <p>Blog yazılarını ve projeleri yönetin</p>
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

        <!-- Filters and Actions -->
        <div class="content-filters">
            <div class="filter-group">
                <select id="categoryFilter" class="filter-select">
                    <option value="">Tüm Kategoriler</option>
                    <option value="mimarlik">Mimarlık</option>
                    <option value="insaat">İnşaat</option>
                    <option value="teknoloji">Teknoloji</option>
                    <option value="ic-mimarlik">İç Mimarlık</option>
                    <option value="cevre">Çevre</option>
                </select>
                
                <select id="statusFilter" class="filter-select">
                    <option value="">Tüm Durumlar</option>
                    <option value="published">Yayında</option>
                    <option value="draft">Taslak</option>
                    <option value="archived">Arşiv</option>
                </select>

                <input type="text" id="searchInput" class="search-input" placeholder="Başlık veya içerik ara...">
            </div>

            <div class="action-buttons">
                <button class="btn btn-primary" onclick="addNewPost()">
                    <i>➕</i> Yeni Yazı Ekle
                </button>
                <button class="btn btn-secondary" onclick="addNewProject()">
                    <i>🖼️</i> Yeni Proje Ekle
                </button>
            </div>
        </div>

        <!-- Content Type Tabs -->
        <div class="content-tabs">
            <button class="tab-button active" onclick="switchTab('posts')">Blog Yazıları</button>
            <button class="tab-button" onclick="switchTab('projects')">Projeler</button>
        </div>

        <!-- Posts Table -->
        <div id="postsTable" class="dashboard-table">
            <div class="table-header">
                <h2>Blog Yazıları</h2>
                <div class="table-actions">
                    <span class="table-count">Toplam: <strong>48</strong> yazı</span>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAllPosts" onchange="toggleSelectAll('posts')">
                        </th>
                        <th>Başlık</th>
                        <th>Yazar</th>
                        <th>Kategori</th>
                        <th>Tarih</th>
                        <th>Durum</th>
                        <th>Görüntülenme</th>
                        <th>İşlemler</th>
                    </tr>
                </thead>
                <tbody id="postsTableBody">
                    <tr>
                        <td><input type="checkbox" class="row-checkbox" data-id="1"></td>
                        <td>
                            <div class="post-title">
                                <strong>Yeni Nesil Mimari Tasarım Trendleri</strong>
                                <small>Modern mimarlıkta öne çıkan yenilikçi yaklaşımlar...</small>
                            </div>
                        </td>
                        <td>Ahmet Yılmaz</td>
                        <td><span class="category-badge mimarlik">Mimarlık</span></td>
                        <td>15 Ekim 2025</td>
                        <td><span class="badge badge-success">Yayında</span></td>
                        <td>1,234</td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn-icon btn-view" title="Görüntüle" onclick="viewPost(1)">👁️</button>
                                <button class="btn-icon btn-edit" title="Düzenle" onclick="editPost(1)">✏️</button>
                                <button class="btn-icon btn-delete" title="Sil" onclick="deletePost(1)">🗑️</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="row-checkbox" data-id="2"></td>
                        <td>
                            <div class="post-title">
                                <strong>Sürdürülebilir İnşaat Malzemeleri</strong>
                                <small>Çevre dostu inşaat malzemeleri ve kullanım alanları...</small>
                            </div>
                        </td>
                        <td>Ayşe Demir</td>
                        <td><span class="category-badge insaat">İnşaat</span></td>
                        <td>12 Ekim 2025</td>
                        <td><span class="badge badge-success">Yayında</span></td>
                        <td>856</td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn-icon btn-view" title="Görüntüle" onclick="viewPost(2)">👁️</button>
                                <button class="btn-icon btn-edit" title="Düzenle" onclick="editPost(2)">✏️</button>
                                <button class="btn-icon btn-delete" title="Sil" onclick="deletePost(2)">🗑️</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="row-checkbox" data-id="3"></td>
                        <td>
                            <div class="post-title">
                                <strong>3D Modelleme ile Proje Sunumu</strong>
                                <small>Modern 3D modelleme teknikleri ve proje sunumları...</small>
                            </div>
                        </td>
                        <td>Mehmet Kaya</td>
                        <td><span class="category-badge teknoloji">Teknoloji</span></td>
                        <td>10 Ekim 2025</td>
                        <td><span class="badge badge-warning">Taslak</span></td>
                        <td>0</td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn-icon btn-view" title="Görüntüle" onclick="viewPost(3)">👁️</button>
                                <button class="btn-icon btn-edit" title="Düzenle" onclick="editPost(3)">✏️</button>
                                <button class="btn-icon btn-delete" title="Sil" onclick="deletePost(3)">🗑️</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="row-checkbox" data-id="4"></td>
                        <td>
                            <div class="post-title">
                                <strong>Ofis Tasarımında Yenilikçi Yaklaşımlar</strong>
                                <small>Modern ofis tasarımı trendleri ve uygulamaları...</small>
                            </div>
                        </td>
                        <td>Zeynep Şahin</td>
                        <td><span class="category-badge ic-mimarlik">İç Mimarlık</span></td>
                        <td>08 Ekim 2025</td>
                        <td><span class="badge badge-success">Yayında</span></td>
                        <td>2,145</td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn-icon btn-view" title="Görüntüle" onclick="viewPost(4)">👁️</button>
                                <button class="btn-icon btn-edit" title="Düzenle" onclick="editPost(4)">✏️</button>
                                <button class="btn-icon btn-delete" title="Sil" onclick="deletePost(4)">🗑️</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="row-checkbox" data-id="5"></td>
                        <td>
                            <div class="post-title">
                                <strong>Enerji Verimliliği ve Yeşil Binalar</strong>
                                <small>Sürdürülebilir mimarlık ve enerji verimliliği...</small>
                            </div>
                        </td>
                        <td>Can Özkan</td>
                        <td><span class="category-badge cevre">Çevre</span></td>
                        <td>05 Ekim 2025</td>
                        <td><span class="badge badge-danger">Arşiv</span></td>
                        <td>3,567</td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn-icon btn-view" title="Görüntüle" onclick="viewPost(5)">👁️</button>
                                <button class="btn-icon btn-edit" title="Düzenle" onclick="editPost(5)">✏️</button>
                                <button class="btn-icon btn-delete" title="Sil" onclick="deletePost(5)">🗑️</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Bulk Actions -->
            <div class="bulk-actions" id="bulkActionsPosts" style="display: none;">
                <span class="bulk-info">Seçili öğeler:</span>
                <button class="btn btn-sm btn-success" onclick="bulkAction('publish')">Yayınla</button>
                <button class="btn btn-sm btn-warning" onclick="bulkAction('draft')">Taslağa Al</button>
                <button class="btn btn-sm btn-danger" onclick="bulkAction('delete')">Sil</button>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <button class="btn btn-sm" disabled>« Önceki</button>
                <span class="pagination-info">Sayfa 1 / 5</span>
                <button class="btn btn-sm">Sonraki »</button>
            </div>
        </div>

        <!-- Projects Table -->
        <div id="projectsTable" class="dashboard-table" style="display: none;">
            <div class="table-header">
                <h2>Projeler</h2>
                <div class="table-actions">
                    <span class="table-count">Toplam: <strong>12</strong> proje</span>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAllProjects" onchange="toggleSelectAll('projects')">
                        </th>
                        <th>Proje Adı</th>
                        <th>Müşteri</th>
                        <th>Kategori</th>
                        <th>Başlangıç</th>
                        <th>Bitiş</th>
                        <th>Durum</th>
                        <th>İşlemler</th>
                    </tr>
                </thead>
                <tbody id="projectsTableBody">
                    <tr>
                        <td><input type="checkbox" class="row-checkbox" data-id="1"></td>
                        <td>
                            <div class="project-title">
                                <strong>Residence İstanbul Plaza</strong>
                                <small>Modern konut projesi</small>
                            </div>
                        </td>
                        <td>ABC İnşaat A.Ş.</td>
                        <td><span class="category-badge mimarlik">Mimarlık</span></td>
                        <td>01 Ocak 2025</td>
                        <td>31 Aralık 2025</td>
                        <td><span class="badge badge-warning">Devam Ediyor</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn-icon btn-view" title="Görüntüle" onclick="viewProject(1)">👁️</button>
                                <button class="btn-icon btn-edit" title="Düzenle" onclick="editProject(1)">✏️</button>
                                <button class="btn-icon btn-delete" title="Sil" onclick="deleteProject(1)">🗑️</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="row-checkbox" data-id="2"></td>
                        <td>
                            <div class="project-title">
                                <strong>Modern Ofis Kompleksi</strong>
                                <small>İş merkezi tasarım projesi</small>
                            </div>
                        </td>
                        <td>XYZ Gayrimenkul</td>
                        <td><span class="category-badge ic-mimarlik">İç Mimarlık</span></td>
                        <td>15 Mart 2024</td>
                        <td>15 Eylül 2024</td>
                        <td><span class="badge badge-success">Tamamlandı</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn-icon btn-view" title="Görüntüle" onclick="viewProject(2)">👁️</button>
                                <button class="btn-icon btn-edit" title="Düzenle" onclick="editProject(2)">✏️</button>
                                <button class="btn-icon btn-delete" title="Sil" onclick="deleteProject(2)">🗑️</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" class="row-checkbox" data-id="3"></td>
                        <td>
                            <div class="project-title">
                                <strong>Lüks Villa Projesi</strong>
                                <small>Özel konut tasarımı</small>
                            </div>
                        </td>
                        <td>Özel Müşteri</td>
                        <td><span class="category-badge mimarlik">Mimarlık</span></td>
                        <td>10 Haziran 2024</td>
                        <td>10 Haziran 2025</td>
                        <td><span class="badge badge-warning">Devam Ediyor</span></td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn-icon btn-view" title="Görüntüle" onclick="viewProject(3)">👁️</button>
                                <button class="btn-icon btn-edit" title="Düzenle" onclick="editProject(3)">✏️</button>
                                <button class="btn-icon btn-delete" title="Sil" onclick="deleteProject(3)">🗑️</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Bulk Actions -->
            <div class="bulk-actions" id="bulkActionsProjects" style="display: none;">
                <span class="bulk-info">Seçili öğeler:</span>
                <button class="btn btn-sm btn-success" onclick="bulkAction('complete')">Tamamlandı</button>
                <button class="btn btn-sm btn-warning" onclick="bulkAction('progress')">Devam Ediyor</button>
                <button class="btn btn-sm btn-danger" onclick="bulkAction('delete')">Sil</button>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <button class="btn btn-sm" disabled>« Önceki</button>
                <span class="pagination-info">Sayfa 1 / 2</span>
                <button class="btn btn-sm">Sonraki »</button>
            </div>
        </div>
    </main>

    <script>
        // Sayfa yüklendiğinde kullanıcı kontrolü
        window.addEventListener('load', function() {
            checkAuth();
            loadUserInfo();
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

        // Çıkış yap
        function logout() {
            if (confirm('Çıkış yapmak istediğinize emin misiniz?')) {
                localStorage.removeItem('adminUser');
                window.location.href = 'login.html';
            }
        }

        // Tab değiştirme
        function switchTab(tab) {
            const postsTable = document.getElementById('postsTable');
            const projectsTable = document.getElementById('projectsTable');
            const tabButtons = document.querySelectorAll('.tab-button');

            tabButtons.forEach(btn => btn.classList.remove('active'));

            if (tab === 'posts') {
                postsTable.style.display = 'block';
                projectsTable.style.display = 'none';
                document.querySelector('.tab-button:first-child').classList.add('active');
            } else {
                postsTable.style.display = 'none';
                projectsTable.style.display = 'block';
                document.querySelector('.tab-button:last-child').classList.add('active');
            }
        }

        // Yeni yazı ekle
        function addNewPost() {
            window.location.href = 'YaziEkleDuzenle.html?type=post&action=add';
        }

        // Yeni proje ekle
        function addNewProject() {
            window.location.href = 'YaziEkleDuzenle.html?type=project&action=add';
        }

        // Yazı düzenle
        function editPost(id) {
            window.location.href = 'YaziEkleDuzenle.html?type=post&action=edit&id=' + id;
        }

        // Proje düzenle
        function editProject(id) {
            window.location.href = 'YaziEkleDuzenle.html?type=project&action=edit&id=' + id;
        }

        // Yazı görüntüle
        function viewPost(id) {
            showNotification('Yazı görüntüleniyor...', 'info');
        }

        // Proje görüntüle
        function viewProject(id) {
            showNotification('Proje görüntüleniyor...', 'info');
        }

        // Yazı sil
        function deletePost(id) {
            if (confirm('Bu yazıyı silmek istediğinize emin misiniz?')) {
                showNotification('Yazı silindi!', 'success');
            }
        }

        // Proje sil
        function deleteProject(id) {
            if (confirm('Bu projeyi silmek istediğinize emin misiniz?')) {
                showNotification('Proje silindi!', 'success');
            }
        }

        // Tümünü seç/seçme
        function toggleSelectAll(type) {
            const selectAll = document.getElementById('selectAll' + (type === 'posts' ? 'Posts' : 'Projects'));
            const checkboxes = document.querySelectorAll('#' + type + 'TableBody .row-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
            
            updateBulkActions(type);
        }

        // Toplu işlemler güncelle
        function updateBulkActions(type) {
            const checkboxes = document.querySelectorAll('#' + type + 'TableBody .row-checkbox:checked');
            const bulkActions = document.getElementById('bulkActions' + (type === 'posts' ? 'Posts' : 'Projects'));
            
            if (checkboxes.length > 0) {
                bulkActions.style.display = 'block';
            } else {
                bulkActions.style.display = 'none';
            }
        }

        // Toplu işlem
        function bulkAction(action) {
            const checkedItems = document.querySelectorAll('.row-checkbox:checked');
            if (checkedItems.length === 0) {
                showNotification('Lütfen en az bir öğe seçin!', 'error');
                return;
            }

            let message = '';
            switch(action) {
                case 'publish':
                    message = 'Seçili yazılar yayınlandı!';
                    break;
                case 'draft':
                    message = 'Seçili yazılar taslağa alındı!';
                    break;
                case 'complete':
                    message = 'Seçili projeler tamamlandı!';
                    break;
                case 'progress':
                    message = 'Seçili projeler devam ediyor olarak işaretlendi!';
                    break;
                case 'delete':
                    message = 'Seçili öğeler silindi!';
                    break;
            }

            showNotification(message, 'success');
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

        // Checkbox değişikliklerini dinle
        document.addEventListener('change', function(e) {
            if (e.target.classList.contains('row-checkbox')) {
                const tableId = e.target.closest('table').id;
                const type = tableId.includes('posts') ? 'posts' : 'projects';
                updateBulkActions(type);
            }
        });

        // Arama fonksiyonu
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#postsTableBody tr, #projectsTableBody tr');
            
            rows.forEach(row => {
                const title = row.querySelector('.post-title, .project-title').textContent.toLowerCase();
                if (title.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>
