<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YaziEkleDuzenle.aspx.cs" Inherits="NtpProje.pages.Admin.YaziEkleDuzenle" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Yazı Ekle/Düzenle - Admin Panel</title>
    <link rel="stylesheet" href="../../css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- TinyMCE CDN -->
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
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
                <h1 id="pageTitle">Yeni Yazı Ekle</h1>
                <p id="pageSubtitle">Blog yazısı veya proje bilgilerini girin</p>
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

        <!-- Form Container -->
        <div class="form-container">
            <form id="contentForm" class="content-form">
                <!-- Basic Information -->
                <div class="form-section">
                    <h3>Genel Bilgiler</h3>
                    
                    <div class="form-row">
                        <div class="form-group full-width">
                            <label for="title">Başlık *</label>
                            <input type="text" id="title" name="title" placeholder="Yazı veya proje başlığını girin" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="category">Kategori *</label>
                            <select id="category" name="category" required>
                                <option value="">Kategori seçin</option>
                                <option value="mimarlik">Mimarlık</option>
                                <option value="insaat">İnşaat</option>
                                <option value="teknoloji">Teknoloji</option>
                                <option value="ic-mimarlik">İç Mimarlık</option>
                                <option value="cevre">Çevre</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="status">Durum</label>
                            <select id="status" name="status">
                                <option value="draft">Taslak</option>
                                <option value="published">Yayında</option>
                                <option value="archived">Arşiv</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="author">Yazar</label>
                            <input type="text" id="author" name="author" placeholder="Yazar adı" value="Admin">
                        </div>

                        <div class="form-group">
                            <label for="publishDate">Yayın Tarihi</label>
                            <input type="datetime-local" id="publishDate" name="publishDate">
                        </div>
                    </div>
                </div>

                <!-- Content Section -->
                <div class="form-section">
                    <h3>İçerik</h3>
                    
                    <div class="form-group full-width">
                        <label for="excerpt">Özet</label>
                        <textarea id="excerpt" name="excerpt" rows="3" placeholder="Kısa özet (opsiyonel)"></textarea>
                    </div>

                    <div class="form-group full-width">
                        <label for="content">İçerik *</label>
                        <textarea id="content" name="content" rows="15" placeholder="Ana içerik buraya yazılacak"></textarea>
                    </div>
                </div>

                <!-- Media Section -->
                <div class="form-section">
                    <h3>Medya</h3>
                    
                    <div class="form-group full-width">
                        <label for="featuredImage">Öne Çıkan Görsel</label>
                        <div class="image-upload-area" id="imageUploadArea">
                            <div class="upload-placeholder">
                                <i>📷</i>
                                <p>Görsel yüklemek için tıklayın veya sürükleyip bırakın</p>
                                <input type="file" id="featuredImage" name="featuredImage" accept="image/*" style="display: none;">
                            </div>
                            <div class="image-preview" id="imagePreview" style="display: none;">
                                <img id="previewImg" src="" alt="Önizleme">
                                <button type="button" class="remove-image" onclick="removeImage()">×</button>
                            </div>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label for="gallery">Galeri (Çoklu Seçim)</label>
                        <div class="gallery-upload-area" id="galleryUploadArea">
                            <div class="upload-placeholder">
                                <i>🖼️</i>
                                <p>Galeri görselleri yüklemek için tıklayın</p>
                                <input type="file" id="gallery" name="gallery" accept="image/*" multiple style="display: none;">
                            </div>
                            <div class="gallery-preview" id="galleryPreview"></div>
                        </div>
                    </div>
                </div>

                <!-- SEO Section -->
                <div class="form-section">
                    <h3>SEO Ayarları</h3>
                    
                    <div class="form-group full-width">
                        <label for="metaTitle">Meta Başlık</label>
                        <input type="text" id="metaTitle" name="metaTitle" placeholder="SEO için başlık">
                    </div>

                    <div class="form-group full-width">
                        <label for="metaDescription">Meta Açıklama</label>
                        <textarea id="metaDescription" name="metaDescription" rows="3" placeholder="SEO için açıklama"></textarea>
                    </div>

                    <div class="form-group full-width">
                        <label for="slug">URL Slug</label>
                        <input type="text" id="slug" name="slug" placeholder="url-slug">
                    </div>
                </div>

                <!-- Project Specific Fields -->
                <div class="form-section" id="projectFields" style="display: none;">
                    <h3>Proje Bilgileri</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="client">Müşteri</label>
                            <input type="text" id="client" name="client" placeholder="Müşteri adı">
                        </div>

                        <div class="form-group">
                            <label for="projectType">Proje Tipi</label>
                            <select id="projectType" name="projectType">
                                <option value="">Proje tipi seçin</option>
                                <option value="residential">Konut</option>
                                <option value="commercial">Ticari</option>
                                <option value="industrial">Endüstriyel</option>
                                <option value="public">Kamu</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="startDate">Başlangıç Tarihi</label>
                            <input type="date" id="startDate" name="startDate">
                        </div>

                        <div class="form-group">
                            <label for="endDate">Bitiş Tarihi</label>
                            <input type="date" id="endDate" name="endDate">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="budget">Bütçe</label>
                            <input type="text" id="budget" name="budget" placeholder="₺ 0.000">
                        </div>

                        <div class="form-group">
                            <label for="area">Alan (m²)</label>
                            <input type="number" id="area" name="area" placeholder="0">
                        </div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="goBack()">Geri Dön</button>
                    <button type="button" class="btn btn-warning" onclick="saveDraft()">Taslak Kaydet</button>
                    <button type="submit" class="btn btn-primary">Kaydet ve Yayınla</button>
                </div>
            </form>
        </div>
    </main>

    <script>
        let currentType = 'post';
        let currentAction = 'add';
        let currentId = null;

        // Sayfa yüklendiğinde
        window.addEventListener('load', function() {
            checkAuth();
            loadUserInfo();
            initializePage();
            initializeTinyMCE();
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

        // Sayfa başlatma
        function initializePage() {
            const urlParams = new URLSearchParams(window.location.search);
            currentType = urlParams.get('type') || 'post';
            currentAction = urlParams.get('action') || 'add';
            currentId = urlParams.get('id');

            updatePageTitle();
            toggleProjectFields();
            setDefaultPublishDate();

            if (currentAction === 'edit' && currentId) {
                loadContentData();
            }
        }

        // Sayfa başlığını güncelle
        function updatePageTitle() {
            const titleElement = document.getElementById('pageTitle');
            const subtitleElement = document.getElementById('pageSubtitle');
            
            if (currentAction === 'edit') {
                titleElement.textContent = currentType === 'post' ? 'Yazı Düzenle' : 'Proje Düzenle';
                subtitleElement.textContent = currentType === 'post' ? 'Blog yazısını düzenleyin' : 'Proje bilgilerini düzenleyin';
            } else {
                titleElement.textContent = currentType === 'post' ? 'Yeni Yazı Ekle' : 'Yeni Proje Ekle';
                subtitleElement.textContent = currentType === 'post' ? 'Blog yazısı bilgilerini girin' : 'Proje bilgilerini girin';
            }
        }

        // Proje alanlarını göster/gizle
        function toggleProjectFields() {
            const projectFields = document.getElementById('projectFields');
            if (currentType === 'project') {
                projectFields.style.display = 'block';
            } else {
                projectFields.style.display = 'none';
            }
        }

        // Varsayılan yayın tarihini ayarla
        function setDefaultPublishDate() {
            const now = new Date();
            const publishDate = document.getElementById('publishDate');
            publishDate.value = now.toISOString().slice(0, 16);
        }

        // TinyMCE editörü başlat
        function initializeTinyMCE() {
            tinymce.init({
                selector: '#content',
                height: 400,
                menubar: false,
                plugins: [
                    'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                    'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                    'insertdatetime', 'media', 'table', 'help', 'wordcount'
                ],
                toolbar: 'undo redo | blocks | ' +
                    'bold italic forecolor | alignleft aligncenter ' +
                    'alignright alignjustify | bullist numlist outdent indent | ' +
                    'removeformat | help',
                content_style: 'body { font-family: -apple-system, BlinkMacSystemFont, San Francisco, Segoe UI, Roboto, Helvetica Neue, sans-serif; font-size: 14px; }'
            });
        }

        // İçerik verilerini yükle (düzenleme için)
        function loadContentData() {
            // Demo veri - gerçek uygulamada API'den gelecek
            const sampleData = {
                title: 'Yeni Nesil Mimari Tasarım Trendleri',
                category: 'mimarlik',
                status: 'published',
                author: 'Ahmet Yılmaz',
                excerpt: 'Modern mimarlıkta öne çıkan yenilikçi yaklaşımlar ve tasarım trendleri.',
                content: '<p>Modern mimarlık, sürekli gelişen teknoloji ve değişen yaşam tarzları ile birlikte yeni trendler ortaya çıkarıyor...</p>',
                client: 'ABC İnşaat A.Ş.',
                projectType: 'residential',
                startDate: '2025-01-01',
                endDate: '2025-12-31',
                budget: '₺ 2.500.000',
                area: '1500'
            };

            // Form alanlarını doldur
            document.getElementById('title').value = sampleData.title;
            document.getElementById('category').value = sampleData.category;
            document.getElementById('status').value = sampleData.status;
            document.getElementById('author').value = sampleData.author;
            document.getElementById('excerpt').value = sampleData.excerpt;
            
            if (currentType === 'project') {
                document.getElementById('client').value = sampleData.client;
                document.getElementById('projectType').value = sampleData.projectType;
                document.getElementById('startDate').value = sampleData.startDate;
                document.getElementById('endDate').value = sampleData.endDate;
                document.getElementById('budget').value = sampleData.budget;
                document.getElementById('area').value = sampleData.area;
            }

            // TinyMCE içeriğini ayarla
            setTimeout(() => {
                tinymce.get('content').setContent(sampleData.content);
            }, 1000);
        }

        // Görsel yükleme
        document.getElementById('imageUploadArea').addEventListener('click', function() {
            document.getElementById('featuredImage').click();
        });

        document.getElementById('featuredImage').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('imagePreview');
                    const img = document.getElementById('previewImg');
                    const placeholder = document.querySelector('.upload-placeholder');
                    
                    img.src = e.target.result;
                    preview.style.display = 'block';
                    placeholder.style.display = 'none';
                };
                reader.readAsDataURL(file);
            }
        });

        // Galeri yükleme
        document.getElementById('galleryUploadArea').addEventListener('click', function() {
            document.getElementById('gallery').click();
        });

        document.getElementById('gallery').addEventListener('change', function(e) {
            const files = e.target.files;
            const preview = document.getElementById('galleryPreview');
            
            preview.innerHTML = '';
            
            Array.from(files).forEach(file => {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.className = 'gallery-item';
                    preview.appendChild(img);
                };
                reader.readAsDataURL(file);
            });
        });

        // Görsel kaldır
        function removeImage() {
            const preview = document.getElementById('imagePreview');
            const placeholder = document.querySelector('.upload-placeholder');
            const input = document.getElementById('featuredImage');
            
            preview.style.display = 'none';
            placeholder.style.display = 'block';
            input.value = '';
        }

        // Form gönderimi
        document.getElementById('contentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const content = tinymce.get('content').getContent();
            formData.set('content', content);
            
            // Validasyon
            if (!formData.get('title')) {
                showNotification('Başlık alanı zorunludur!', 'error');
                return;
            }
            
            if (!formData.get('category')) {
                showNotification('Kategori seçimi zorunludur!', 'error');
                return;
            }
            
            if (!content.trim()) {
                showNotification('İçerik alanı zorunludur!', 'error');
                return;
            }

            // Demo kaydetme
            showNotification('İçerik başarıyla kaydedildi!', 'success');
            
            setTimeout(() => {
                window.location.href = 'YaziYonetimi.html';
            }, 1500);
        });

        // Taslak kaydet
        function saveDraft() {
            document.getElementById('status').value = 'draft';
            document.getElementById('contentForm').dispatchEvent(new Event('submit'));
        }

        // Geri dön
        function goBack() {
            window.location.href = 'YaziYonetimi.html';
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

        // Başlık değiştiğinde slug oluştur
        document.getElementById('title').addEventListener('input', function(e) {
            const slug = e.target.value
                .toLowerCase()
                .replace(/[^a-z0-9\s-]/g, '')
                .replace(/\s+/g, '-')
                .replace(/-+/g, '-')
                .trim('-');
            
            document.getElementById('slug').value = slug;
        });
    </script>
</body>
</html>
