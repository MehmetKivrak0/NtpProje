<%@ Page Title="Hizmet Ekle/Düzenle" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="hizmetekle.aspx.cs" Inherits="NtpProje.pages.Admin.hizmetekle" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
    <style>
        .editor-wrapper {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }

        .editor-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e3e6f0;
            flex-wrap: wrap;
            gap: 20px;
        }

        .editor-header-left {
            flex: 1;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #4e73df;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 10px;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: #2e59d9;
        }

        .editor-header h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 700;
            color: #5a5c69;
        }

        .editor-subtitle {
            margin: 5px 0 0 0;
            color: #858796;
            font-size: 14px;
        }

        .editor-header-actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: #4e73df;
            color: white;
        }

        .btn-primary:hover {
            background: #2e59d9;
        }

        .btn-outline {
            background: transparent;
            color: #4e73df;
            border: 2px solid #4e73df;
        }

        .btn-outline:hover {
            background: #4e73df;
            color: white;
        }

        .alert-message {
            padding: 12px 20px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: block;
        }

        .alert-message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .editor-content {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 30px;
        }

        .editor-main {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-card {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            overflow: hidden;
        }

        .form-card-header {
            padding: 20px;
            background: #f8f9fc;
            border-bottom: 1px solid #e3e6f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-card-header h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #5a5c69;
        }

        .form-card-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            background: #e3f2fd;
            color: #1976d2;
        }

        .form-card-body {
            padding: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #5a5c69;
            font-size: 14px;
        }

        .required {
            color: #e74a3b;
        }

        .form-hint {
            display: block;
            margin-top: 4px;
            font-size: 12px;
            color: #858796;
            font-weight: normal;
        }

        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #e3e6f0;
            border-radius: 6px;
            font-size: 14px;
            font-family: inherit;
            transition: border-color 0.2s;
            box-sizing: border-box;
        }

        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #4e73df;
            box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
        }

        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-error {
            display: block;
            color: #e74a3b;
            font-size: 12px;
            margin-top: 5px;
        }

        .upload-wrapper {
            display: flex;
            gap: 10px;
            align-items: flex-start;
        }

        .file-upload-input {
            flex: 1;
        }

        .image-preview {
            margin-top: 15px;
            padding: 15px;
            background: #f8f9fc;
            border-radius: 6px;
            border: 1px dashed #e3e6f0;
        }

        .image-preview img {
            max-width: 100%;
            max-height: 200px;
            border-radius: 6px;
        }

        .icon-preview {
            font-size: 48px;
            text-align: center;
            padding: 20px;
            background: #f8f9fc;
            border-radius: 6px;
            margin-top: 10px;
        }

        .icon-selector {
            margin-top: 15px;
            padding: 15px;
            background: #f8f9fc;
            border-radius: 6px;
            border: 1px solid #e3e6f0;
        }

        .icon-selector-title {
            font-size: 13px;
            font-weight: 600;
            color: #5a5c69;
            margin-bottom: 12px;
        }

        .icon-grid {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            gap: 8px;
            max-height: 200px;
            overflow-y: auto;
            padding: 5px;
        }

        .icon-option {
            font-size: 28px;
            padding: 12px;
            background: #ffffff;
            border: 2px solid #e3e6f0;
            border-radius: 6px;
            cursor: pointer;
            text-align: center;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .icon-option:hover {
            background: #e3f2fd;
            border-color: #4e73df;
            transform: scale(1.1);
        }

        .icon-option.selected {
            background: #4e73df;
            border-color: #4e73df;
            color: white;
        }

        .icon-categories {
            display: flex;
            gap: 8px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }

        .icon-category-btn {
            padding: 6px 12px;
            background: #ffffff;
            border: 1px solid #e3e6f0;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .icon-category-btn:hover,
        .icon-category-btn.active {
            background: #4e73df;
            color: white;
            border-color: #4e73df;
        }

        @media (max-width: 1024px) {
            .editor-content {
                grid-template-columns: 1fr;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="editor-wrapper">
        <div class="editor-header">
            <div class="editor-header-left">
                <a href="hizmetynt.aspx" class="back-link">
                    <span>←</span> Geri Dön
                </a>
                <h1><asp:Literal ID="ltrPageTitle" runat="server" Text="Hizmet" /> Ekle/Düzenle</h1>
                <p class="editor-subtitle">Hizmet bilgilerinizi oluşturun ve yönetin</p>
            </div>
            <div class="editor-header-actions">
                <asp:Button ID="btnKaydet" runat="server" Text="💾 Kaydet" CssClass="btn btn-primary" OnClick="btnKaydet_Click" ValidationGroup="MainForm" />
            </div>
        </div>

        <asp:Label ID="lblDurumMesaj" runat="server" CssClass="alert-message" Visible="false"></asp:Label>
        
        <asp:HiddenField ID="hfServiceId" runat="server" />

        <div class="editor-content">
            <div class="editor-main">
                <!-- Genel Bilgiler -->
                <div class="form-card">
                    <div class="form-card-header">
                        <h2>📋 Genel Bilgiler</h2>
                        <span class="form-card-badge">Zorunlu</span>
                    </div>
                    <div class="form-card-body">
                        <div class="form-group">
                            <label class="form-label">
                                Hizmet Adı <span class="required">*</span>
                                <span class="form-hint">Maksimum 100 karakter</span>
                            </label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Örn: Web Geliştirme, Mobil Uygulama" MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="Hizmet adı zorunludur" Display="Dynamic" CssClass="form-error" ValidationGroup="MainForm" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Kısa Açıklama
                                <span class="form-hint">Hizmetin kısa tanımı (liste görünümünde gösterilir)</span>
                            </label>
                            <asp:TextBox ID="txtShortDescription" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="3" placeholder="Hizmetin kısa bir açıklamasını girin..."></asp:TextBox>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">
                                    Sıralama (Display Order)
                                    <span class="form-hint">Düşük sayı önce gösterilir</span>
                                </label>
                                <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-input" TextMode="Number" Text="0"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Durum</label>
                                <asp:DropDownList ID="ddlIsActive" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="true" Text="✅ Aktif" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="false" Text="⏸️ Pasif"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Detaylı Açıklama -->
                <div class="form-card">
                    <div class="form-card-header">
                        <h2>✍️ Detaylı Açıklama</h2>
                        <span class="form-card-badge">Opsiyonel</span>
                    </div>
                    <div class="form-card-body">
                        <div class="form-group">
                            <label class="form-label">
                                Uzun Açıklama
                                <span class="form-hint">Hizmet hakkında detaylı bilgi</span>
                            </label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="10" ClientIDMode="Static" placeholder="Hizmet hakkında detaylı açıklama yazın..."></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- İkon ve Görsel -->
                <div class="form-card">
                    <div class="form-card-header">
                        <h2>🎨 İkon ve Görsel</h2>
                    </div>
                    <div class="form-card-body">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">
                                    İkon (Emoji)
                                    <span class="form-hint">Aşağıdan seçin veya manuel girin</span>
                                </label>
                                <asp:TextBox ID="txtIcon" runat="server" CssClass="form-input" placeholder="💻" MaxLength="10" ClientIDMode="Static"></asp:TextBox>
                                <div class="icon-preview" id="iconPreview">
                                    <span id="previewIcon">💻</span>
                                </div>
                                
                                <!-- İkon Seçici -->
                                <div class="icon-selector">
                                    <div class="icon-selector-title">📋 Popüler İkonlar</div>
                                    
                                    <!-- Kategori Butonları -->
                                    <div class="icon-categories">
                                        <button type="button" class="icon-category-btn active" data-category="all">Tümü</button>
                                        <button type="button" class="icon-category-btn" data-category="tech">💻 Teknoloji</button>
                                        <button type="button" class="icon-category-btn" data-category="design">🎨 Tasarım</button>
                                        <button type="button" class="icon-category-btn" data-category="business">💼 İş</button>
                                        <button type="button" class="icon-category-btn" data-category="mobile">📱 Mobil</button>
                                        <button type="button" class="icon-category-btn" data-category="other">⭐ Diğer</button>
                                    </div>
                                    
                                    <!-- İkon Grid -->
                                    <div class="icon-grid" id="iconGrid">
                                        <!-- İkonlar JavaScript ile eklenecek -->
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">
                                    İkon CSS Class
                                    <span class="form-hint">Örn: fa fa-code, icon-web</span>
                                </label>
                                <asp:TextBox ID="txtIconClass" runat="server" CssClass="form-input" placeholder="fa fa-code" MaxLength="50"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Resim Yükle
                                <span class="form-hint">JPG, PNG veya GIF formatında (Max: 5MB)</span>
                            </label>
                            <div class="upload-wrapper">
                                <asp:FileUpload ID="fileImageUpload" runat="server" CssClass="file-upload-input" accept="image/*" />
                                <asp:Button ID="btnUploadImage" runat="server" Text="📤 Yükle" CssClass="btn btn-outline" OnClick="btnUploadImage_Click" />
                            </div>
                            <asp:Label ID="lblUploadError" runat="server" CssClass="form-error" Visible="false"></asp:Label>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                Resim URL
                                <span class="form-hint">Veya görselin tam URL'sini girin</span>
                            </label>
                            <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-input" placeholder="Örn: service-image.jpg (sadece dosya adı) veya https://..."></asp:TextBox>
                            <div class="image-preview" id="imagePreview" style="display: none;">
                                <img id="previewImg" src="" alt="Önizleme" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Detay Sayfası Ek Bilgileri -->
                <div class="form-card">
                    <div class="form-card-header">
                        <h2>📄 Detay Sayfası Ek Bilgileri</h2>
                        <span class="form-card-badge">Opsiyonel</span>
                    </div>
                    <div class="form-card-body">
                        <div class="form-group">
                            <label class="form-label">
                                Özellikler (Features)
                                <span class="form-hint">Her satırda bir özellik: Icon|Başlık|Açıklama (örn: 🏢|Kurumsal Web Siteleri|Profesyonel web siteleri)</span>
                            </label>
                            <asp:TextBox ID="txtFeatures" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="6" placeholder="🏢|Kurumsal Web Siteleri|Profesyonel web siteleri&#10;🛒|E-Ticaret Platformları|Tam kapsamlı e-ticaret çözümleri"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Teknolojiler
                                <span class="form-hint">Kategori: Teknoloji1, Teknoloji2, Teknoloji3 (örn: Frontend: HTML5, CSS3, JavaScript)</span>
                            </label>
                            <asp:TextBox ID="txtTechnologies" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="4" placeholder="Frontend: HTML5, CSS3, JavaScript, React&#10;Backend: ASP.NET Core, Node.js, Python"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Süreç Adımları (Process Steps)
                                <span class="form-hint">Her satırda bir adım: Başlık|Açıklama (örn: Analiz & Planlama|İhtiyaç analizi ve proje planı)</span>
                            </label>
                            <asp:TextBox ID="txtProcessSteps" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="6" placeholder="Analiz & Planlama|İhtiyaç analizi ve proje planı&#10;Tasarım (UI/UX)|Wireframe ve prototip hazırlama"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Öne Çıkan Özellikler
                                <span class="form-hint">Her satırda bir özellik: Başlık|Açıklama (örn: SEO Optimizasyonu|Arama motorlarında üst sıralarda yer almanız için)</span>
                            </label>
                            <asp:TextBox ID="txtHighlightFeatures" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="5" placeholder="SEO Optimizasyonu|Arama motorlarında üst sıralarda yer almanız için&#10;Performans|Hızlı yükleme süreleri ve optimize edilmiş kod"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Neden Bizi Tercih Etmelisiniz?
                                <span class="form-hint">Her satırda bir neden: Başlık|Açıklama (örn: 10+ Yıl Deneyim|Yüzlerce başarılı proje)</span>
                            </label>
                            <asp:TextBox ID="txtWhyChooseUs" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="5" placeholder="10+ Yıl Deneyim|Yüzlerce başarılı proje&#10;Uzman Ekip|Sertifikalı ve deneyimli yazılımcılar"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- SEO Ayarları -->
                <div class="form-card">
                    <div class="form-card-header">
                        <h2>🔍 SEO Ayarları</h2>
                        <span class="form-card-badge">Opsiyonel</span>
                    </div>
                    <div class="form-card-body">
                        <div class="form-group">
                            <label class="form-label">
                                URL Slug
                                <span class="form-hint">Boş bırakılırsa otomatik oluşturulur</span>
                            </label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-input" placeholder="web-gelistirme"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="editor-sidebar">
                <div class="form-card">
                    <div class="form-card-header">
                        <h2>ℹ️ Bilgiler</h2>
                    </div>
                    <div class="form-card-body">
                        <div class="form-group">
                            <label class="form-label">Görüntülenme Sayısı</label>
                            <asp:TextBox ID="txtViewCount" runat="server" CssClass="form-input" TextMode="Number" Text="0" Enabled="false"></asp:TextBox>
                            <span class="form-hint">Otomatik hesaplanır</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // İkon veritabanı (kategorilere göre - sadece popüler olanlar)
        const iconDatabase = {
            all: ['💻', '📱', '🎨', '💼', '🌐', '⚙️', '🔧', '📊', '💡', '🚀', '🛡️', '📈', '🔐', '☁️', '📦', '📸', '📝', '💰', '⭐'],
            tech: ['💻', '📱', '🌐', '⚙️', '🔧', '📊', '💡', '🚀', '🛡️', '🔐', '☁️', '📦'],
            design: ['🎨', '🖼️', '📸', '✨', '🖌️', '✏️'],
            business: ['💼', '📊', '📈', '💰', '💳', '📋', '📝'],
            mobile: ['📱', '📲', '📞', '📧', '💬'],
            other: ['⭐', '❤️', '👍', '🔥', '✨', '🎉', '🏆']
        };

        // İkon önizleme ve seçici
        document.addEventListener('DOMContentLoaded', function() {
            var txtIcon = document.getElementById('txtIcon');
            var previewIcon = document.getElementById('previewIcon');
            var iconGrid = document.getElementById('iconGrid');
            var categoryButtons = document.querySelectorAll('.icon-category-btn');
            
            // İkon önizleme güncelleme
            if (txtIcon && previewIcon) {
                txtIcon.addEventListener('input', function() {
                    previewIcon.textContent = this.value || '💻';
                    // İkon değiştiğinde grid'i güncelle
                    highlightSelectedIcon();
                });
                
                // Sayfa yüklendiğinde mevcut değeri göster
                if (txtIcon.value) {
                    previewIcon.textContent = txtIcon.value;
                }
            }

            // Seçili ikonu bul ve işaretle
            function highlightSelectedIcon() {
                if (!txtIcon || !iconGrid) return;
                var selectedIcon = txtIcon.value.trim();
                if (!selectedIcon) return;
                
                // Tüm ikon seçeneklerini kontrol et
                var iconOptions = iconGrid.querySelectorAll('.icon-option');
                iconOptions.forEach(function(option) {
                    if (option.getAttribute('data-icon') === selectedIcon) {
                        // Önceki seçiliyi kaldır
                        var prevSelected = iconGrid.querySelector('.icon-option.selected');
                        if (prevSelected) {
                            prevSelected.classList.remove('selected');
                        }
                        // Yeni seçiliyi işaretle
                        option.classList.add('selected');
                    }
                });
            }

            // İkonun hangi kategoride olduğunu bul
            function findIconCategory(icon) {
                for (var category in iconDatabase) {
                    if (iconDatabase[category].indexOf(icon) !== -1) {
                        return category;
                    }
                }
                return 'all';
            }

            // İkon grid'i oluştur
            function renderIcons(category, highlightIcon) {
                if (!iconGrid) return;
                
                iconGrid.innerHTML = '';
                const icons = category === 'all' ? iconDatabase.all : iconDatabase[category] || [];
                
                icons.forEach(function(icon) {
                    var iconDiv = document.createElement('div');
                    iconDiv.className = 'icon-option';
                    iconDiv.textContent = icon;
                    iconDiv.setAttribute('data-icon', icon);
                    
                    // Seçili ikonu işaretle
                    if (txtIcon && txtIcon.value === icon) {
                        iconDiv.classList.add('selected');
                    }
                    
                    // Tıklama olayı
                    iconDiv.addEventListener('click', function() {
                        // Önceki seçiliyi kaldır
                        var selected = iconGrid.querySelector('.icon-option.selected');
                        if (selected) {
                            selected.classList.remove('selected');
                        }
                        
                        // Yeni seçiliyi işaretle
                        this.classList.add('selected');
                        
                        // TextBox'a yaz
                        if (txtIcon) {
                            txtIcon.value = icon;
                            previewIcon.textContent = icon;
                        }
                    });
                    
                    iconGrid.appendChild(iconDiv);
                });
                
                // Render sonrası seçili ikonu işaretle
                if (highlightIcon) {
                    setTimeout(highlightSelectedIcon, 10);
                }
            }

            // Kategori butonları
            categoryButtons.forEach(function(btn) {
                btn.addEventListener('click', function() {
                    // Aktif butonu değiştir
                    categoryButtons.forEach(function(b) {
                        b.classList.remove('active');
                    });
                    this.classList.add('active');
                    
                    // İlgili kategorinin ikonlarını göster
                    var category = this.getAttribute('data-category');
                    renderIcons(category, true);
                });
            });

            // İlk yüklemede: Veritabanından gelen ikonu bul ve göster
            var initialIcon = txtIcon ? txtIcon.value.trim() : '';
            if (initialIcon) {
                // İkonun kategorisini bul
                var iconCategory = findIconCategory(initialIcon);
                
                // İlgili kategori butonunu aktif yap
                categoryButtons.forEach(function(btn) {
                    if (btn.getAttribute('data-category') === iconCategory) {
                        btn.classList.add('active');
                    } else {
                        btn.classList.remove('active');
                    }
                });
                
                // İlgili kategorinin ikonlarını göster
                renderIcons(iconCategory, true);
            } else {
                // İkon yoksa tüm ikonları göster
                renderIcons('all', false);
            }

            // Resim URL önizleme
            var txtImageUrl = document.getElementById('<%= txtImageUrl.ClientID %>');
            var imagePreview = document.getElementById('imagePreview');
            var previewImg = document.getElementById('previewImg');
            
            if (txtImageUrl && imagePreview && previewImg) {
                txtImageUrl.addEventListener('blur', function() {
                    var url = this.value.trim();
                    if (url) {
                        // Eğer tam URL değilse, images klasörüne ekle
                        if (!url.startsWith('http://') && !url.startsWith('https://') && !url.startsWith('/')) {
                            url = '/images/' + url;
                        }
                        previewImg.src = url;
                        imagePreview.style.display = 'block';
                    } else {
                        imagePreview.style.display = 'none';
                    }
                });
            }
        });
    </script>

</asp:Content>
