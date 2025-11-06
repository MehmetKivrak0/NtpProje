<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KategoriYonetimi.aspx.cs" Inherits="NtpProje.pages.Admin.KategoriYonetimi" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Kategori Yönetimi - Admin Panel</title>
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
                <div class="menu-section-title">Ayarlar</div>
                <a href="KategoriYonetimi.html" class="menu-item active">
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
                <h1>Kategori Yönetimi</h1>
                <p>Sitenizdeki kategorileri yönetin</p>
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

        <!-- Category Type Tabs -->
        <div class="content-tabs">
            <button class="tab-button active" onclick="switchCategoryType('blog')">Blog Kategorileri</button>
            <button class="tab-button" onclick="switchCategoryType('project')">Proje Kategorileri</button>
            <button class="tab-button" onclick="switchCategoryType('service')">Hizmet Kategorileri</button>
        </div>

        <!-- Add Category Form -->
        <div class="add-category-form">
            <h3>Yeni Kategori Ekle</h3>
            <form id="addCategoryForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="categoryName">Kategori Adı *</label>
                        <input type="text" id="categoryName" name="categoryName" placeholder="Kategori adını girin" required>
                    </div>
                    <div class="form-group">
                        <label for="categorySlug">URL Slug</label>
                        <input type="text" id="categorySlug" name="categorySlug" placeholder="kategori-adi">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="categoryDescription">Açıklama</label>
                        <textarea id="categoryDescription" name="categoryDescription" rows="2" placeholder="Kategori açıklaması (opsiyonel)"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="categoryColor">Renk</label>
                        <input type="color" id="categoryColor" name="categoryColor" value="#667eea">
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Kategori Ekle</button>
                </div>
            </form>
        </div>

        <!-- Blog Categories -->
        <div id="blogCategories" class="categories-section">
            <div class="section-header">
                <h2>Blog Kategorileri</h2>
                <span class="category-count">Toplam: <strong>5</strong> kategori</span>
            </div>
            
            <div class="categories-grid">
                <div class="category-card" data-id="1">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #667eea;"></div>
                        <div class="category-info">
                            <h3>Mimarlık</h3>
                            <p>Mimari tasarım ve projeler</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">12 yazı</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(1, 'blog')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(1, 'blog')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="2">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #f093fb;"></div>
                        <div class="category-info">
                            <h3>İnşaat</h3>
                            <p>İnşaat teknikleri ve malzemeler</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">8 yazı</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(2, 'blog')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(2, 'blog')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="3">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #4facfe;"></div>
                        <div class="category-info">
                            <h3>Teknoloji</h3>
                            <p>Mimarlıkta teknoloji kullanımı</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">6 yazı</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(3, 'blog')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(3, 'blog')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="4">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #43e97b;"></div>
                        <div class="category-info">
                            <h3>İç Mimarlık</h3>
                            <p>İç mekan tasarımı</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">10 yazı</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(4, 'blog')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(4, 'blog')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="5">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #fa709a;"></div>
                        <div class="category-info">
                            <h3>Çevre</h3>
                            <p>Sürdürülebilir mimarlık</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">7 yazı</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(5, 'blog')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(5, 'blog')" title="Sil">🗑️</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Project Categories -->
        <div id="projectCategories" class="categories-section" style="display: none;">
            <div class="section-header">
                <h2>Proje Kategorileri</h2>
                <span class="category-count">Toplam: <strong>4</strong> kategori</span>
            </div>
            
            <div class="categories-grid">
                <div class="category-card" data-id="1">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #667eea;"></div>
                        <div class="category-info">
                            <h3>Konut Projeleri</h3>
                            <p>Residential projeler</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">5 proje</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(1, 'project')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(1, 'project')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="2">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #f093fb;"></div>
                        <div class="category-info">
                            <h3>Ticari Projeler</h3>
                            <p>Commercial projeler</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">3 proje</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(2, 'project')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(2, 'project')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="3">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #4facfe;"></div>
                        <div class="category-info">
                            <h3>Endüstriyel Projeler</h3>
                            <p>Industrial projeler</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">2 proje</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(3, 'project')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(3, 'project')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="4">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #43e97b;"></div>
                        <div class="category-info">
                            <h3>Kamu Projeleri</h3>
                            <p>Public projeler</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">2 proje</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(4, 'project')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(4, 'project')" title="Sil">🗑️</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Service Categories -->
        <div id="serviceCategories" class="categories-section" style="display: none;">
            <div class="section-header">
                <h2>Hizmet Kategorileri</h2>
                <span class="category-count">Toplam: <strong>6</strong> kategori</span>
            </div>
            
            <div class="categories-grid">
                <div class="category-card" data-id="1">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #667eea;"></div>
                        <div class="category-info">
                            <h3>Mimari Tasarım</h3>
                            <p>Mimari proje tasarımı</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">Aktif</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(1, 'service')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(1, 'service')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="2">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #f093fb;"></div>
                        <div class="category-info">
                            <h3>İç Mimarlık</h3>
                            <p>İç mekan tasarım hizmetleri</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">Aktif</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(2, 'service')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(2, 'service')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="3">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #4facfe;"></div>
                        <div class="category-info">
                            <h3>3D Modelleme</h3>
                            <p>3D görselleştirme hizmetleri</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">Aktif</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(3, 'service')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(3, 'service')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="4">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #43e97b;"></div>
                        <div class="category-info">
                            <h3>Proje Yönetimi</h3>
                            <p>İnşaat proje yönetimi</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">Aktif</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(4, 'service')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(4, 'service')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="5">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #fa709a;"></div>
                        <div class="category-info">
                            <h3>Danışmanlık</h3>
                            <p>Mimarlık danışmanlık hizmetleri</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">Aktif</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(5, 'service')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(5, 'service')" title="Sil">🗑️</button>
                    </div>
                </div>

                <div class="category-card" data-id="6">
                    <div class="category-header">
                        <div class="category-color" style="background-color: #ffecd2;"></div>
                        <div class="category-info">
                            <h3>Eğitim</h3>
                            <p>Mimarlık eğitim programları</p>
                        </div>
                        <div class="category-stats">
                            <span class="stat">Aktif</span>
                        </div>
                    </div>
                    <div class="category-actions">
                        <button class="btn-icon btn-edit" onclick="editCategory(6, 'service')" title="Düzenle">✏️</button>
                        <button class="btn-icon btn-delete" onclick="deleteCategory(6, 'service')" title="Sil">🗑️</button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Edit Category Modal -->
    <div id="editCategoryModal" class="modal" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Kategori Düzenle</h3>
                <button class="modal-close" onclick="closeEditModal()">×</button>
            </div>
            <form id="editCategoryForm">
                <input type="hidden" id="editCategoryId" name="categoryId">
                <input type="hidden" id="editCategoryType" name="categoryType">
                
                <div class="form-group">
                    <label for="editCategoryName">Kategori Adı *</label>
                    <input type="text" id="editCategoryName" name="categoryName" required>
                </div>
                
                <div class="form-group">
                    <label for="editCategorySlug">URL Slug</label>
                    <input type="text" id="editCategorySlug" name="categorySlug">
                </div>
                
                <div class="form-group">
                    <label for="editCategoryDescription">Açıklama</label>
                    <textarea id="editCategoryDescription" name="categoryDescription" rows="2"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="editCategoryColor">Renk</label>
                    <input type="color" id="editCategoryColor" name="categoryColor">
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeEditModal()">İptal</button>
                    <button type="submit" class="btn btn-primary">Güncelle</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let currentCategoryType = 'blog';

        // Sayfa yüklendiğinde
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

        // Kategori tipi değiştirme
        function switchCategoryType(type) {
            currentCategoryType = type;
            
            // Tab butonlarını güncelle
            document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            // Bölümleri göster/gizle
            document.querySelectorAll('.categories-section').forEach(section => {
                section.style.display = 'none';
            });
            
            document.getElementById(type + 'Categories').style.display = 'block';
        }

        // Kategori ekleme formu
        document.getElementById('addCategoryForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const categoryName = formData.get('categoryName');
            const categorySlug = formData.get('categorySlug') || generateSlug(categoryName);
            const categoryDescription = formData.get('categoryDescription');
            const categoryColor = formData.get('categoryColor');
            
            if (!categoryName) {
                showNotification('Kategori adı zorunludur!', 'error');
                return;
            }
            
            // Demo ekleme
            showNotification('Kategori başarıyla eklendi!', 'success');
            this.reset();
        });

        // Kategori düzenle
        function editCategory(id, type) {
            // Demo veri
            const categoryData = {
                name: 'Mimarlık',
                slug: 'mimarlik',
                description: 'Mimari tasarım ve projeler',
                color: '#667eea'
            };
            
            document.getElementById('editCategoryId').value = id;
            document.getElementById('editCategoryType').value = type;
            document.getElementById('editCategoryName').value = categoryData.name;
            document.getElementById('editCategorySlug').value = categoryData.slug;
            document.getElementById('editCategoryDescription').value = categoryData.description;
            document.getElementById('editCategoryColor').value = categoryData.color;
            
            document.getElementById('editCategoryModal').style.display = 'block';
        }

        // Kategori sil
        function deleteCategory(id, type) {
            if (confirm('Bu kategoriyi silmek istediğinize emin misiniz?')) {
                showNotification('Kategori silindi!', 'success');
            }
        }

        // Düzenleme modalını kapat
        function closeEditModal() {
            document.getElementById('editCategoryModal').style.display = 'none';
        }

        // Düzenleme formu
        document.getElementById('editCategoryForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const categoryName = formData.get('categoryName');
            
            if (!categoryName) {
                showNotification('Kategori adı zorunludur!', 'error');
                return;
            }
            
            showNotification('Kategori güncellendi!', 'success');
            closeEditModal();
        });

        // Slug oluştur
        function generateSlug(text) {
            return text
                .toLowerCase()
                .replace(/[^a-z0-9\s-]/g, '')
                .replace(/\s+/g, '-')
                .replace(/-+/g, '-')
                .trim('-');
        }

        // Kategori adı değiştiğinde slug oluştur
        document.getElementById('categoryName').addEventListener('input', function(e) {
            const slug = generateSlug(e.target.value);
            document.getElementById('categorySlug').value = slug;
        });

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

        // Modal dışına tıklandığında kapat
        window.addEventListener('click', function(e) {
            const modal = document.getElementById('editCategoryModal');
            if (e.target === modal) {
                closeEditModal();
            }
        });
    </script>
</body>
</html>
