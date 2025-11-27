<%@ Page Title="Yazı Ekle/Düzenle" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="YaziEkleDuzenle.aspx.cs" Inherits="NtpProje_Web.Admin.YaziEkleDuzenle" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.tiny.cloud/1/9gxedwrxprvwnxucm3y2ror96j6c1d5jet6mt1izz6hdx7m7/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="editor-wrapper">
        <div class="editor-header">
            <div class="editor-header-left">
                <a href="YaziYonetimi.aspx" class="back-link">
                    <span>←</span> Geri Dön
                </a>
                <h1><asp:Literal ID="ltrPageTitle" runat="server" /> Ekle/Düzenle</h1>
                <p class="editor-subtitle">İçeriğinizi oluşturun ve yönetin</p>
            </div>
            <div class="editor-header-actions">
                <asp:Button ID="btnTaslakKaydet" runat="server" Text="📝 Taslak Kaydet" CssClass="btn btn-outline" OnClick="btnKaydet_Click" CommandName="draft" ValidationGroup="MainForm" />
                <asp:Button ID="btnKaydet" runat="server" Text="🚀 Yayınla" CssClass="btn btn-primary" OnClick="btnKaydet_Click" CommandName="publish" ValidationGroup="MainForm" />
            </div>
        </div>

        <asp:Label ID="lblDurumMesaj" runat="server" CssClass="alert-message" Visible="false"></asp:Label>
        
        <asp:HiddenField ID="hfItemId" runat="server" />

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
                                Başlık <span class="required">*</span>
                                <span class="form-hint">Maksimum 150 karakter</span>
                            </label>
                            <asp:TextBox ID="txtBaslik" runat="server" CssClass="form-input" placeholder="Yazı veya proje başlığını girin" MaxLength="150"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBaslik" ErrorMessage="Başlık alanı zorunludur" Display="Dynamic" CssClass="form-error" ValidationGroup="MainForm" />
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">
                                    Kategori <span class="required">*</span>
                                </label>
                                <div class="category-select-wrapper">
                                    <asp:DropDownList ID="ddlKategori" runat="server" CssClass="form-select"></asp:DropDownList>
                                    <button type="button" class="btn-quick-add" onclick="openQuickCategoryModal(event); return false;" title="Hızlı Kategori Ekle">
                                        <span>➕</span>
                                    </button>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Durum</label>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Draft" Text="📄 Taslak"></asp:ListItem>
                                    <asp:ListItem Value="Published" Text="✅ Yayında"></asp:ListItem>
                                    <asp:ListItem Value="Archived" Text="📦 Arşiv"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Yazar</label>
                                <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-input" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Yayın Tarihi</label>
                                <asp:TextBox ID="txtPublishDate" runat="server" CssClass="form-input" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- İçerik -->
                <div class="form-card">
                    <div class="form-card-header">
                        <h2>✍️ İçerik</h2>
                        <span class="form-card-badge">Zorunlu</span>
                    </div>
                    <div class="form-card-body">
                        <div class="form-group">
                            <label class="form-label">
                                Özet
                                <span class="form-hint">Kısa bir açıklama (opsiyonel)</span>
                            </label>
                            <asp:TextBox ID="txtOzet" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="3" placeholder="Yazınızın kısa bir özetini girin..."></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                İçerik <span class="required">*</span>
                            </label>
                            <asp:TextBox ID="txtIcerik" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="15" ClientIDMode="Static"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtIcerik" ErrorMessage="İçerik alanı zorunludur" Display="Dynamic" CssClass="form-error" ValidationGroup="MainForm" />
                        </div>
                    </div>
                </div>

                <!-- Medya -->
                <div class="form-card">
                    <div class="form-card-header">
                        <h2>🖼️ Medya</h2>
                    </div>
                    <div class="form-card-body">
                        <div class="form-group">
                            <label class="form-label">
                                Resim Yükle
                                <span class="form-hint">JPG, PNG veya GIF formatında (Max: 5MB)</span>
                            </label>
                            <div class="upload-wrapper">
                                <asp:FileUpload ID="fileImageUpload" runat="server" CssClass="file-upload-input" accept="image/*" />
                                <asp:Button ID="btnUploadImage" runat="server" Text="📤 Resmi Yükle" CssClass="btn btn-secondary" OnClick="btnUploadImage_Click" ValidationGroup="ImageUpload" />
                                <asp:Label ID="lblUploadError" runat="server" CssClass="form-error" Visible="false"></asp:Label>
                            </div>
                        </div>
                        
                        <div class="form-group" style="margin-top: 20px;">
                            <label class="form-label">
                                Öne Çıkan Görsel URL
                                <span class="form-hint">Veya görselin tam URL'sini girin</span>
                            </label>
                            <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-input" placeholder="Örn: post-gorseli.jpg (sadece dosya adı)"></asp:TextBox>
                            <div class="image-preview" id="imagePreview" style="display: none;">
                                <img id="previewImg" src="" alt="Önizleme" />
                            </div>
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
                            <label class="form-label">Meta Başlık</label>
                            <asp:TextBox ID="txtMetaTitle" runat="server" CssClass="form-input" placeholder="SEO için başlık"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Meta Açıklama</label>
                            <asp:TextBox ID="txtMetaDescription" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="3" placeholder="SEO için açıklama"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">URL Slug</label>
                            <asp:TextBox ID="txtSlug" runat="server" CssClass="form-input" placeholder="url-slug"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- Proje Bilgileri -->
                <asp:Panel ID="pnlProjectFields" runat="server" Visible="false">
                    <div class="form-card">
                        <div class="form-card-header">
                            <h2>💼 Proje Bilgileri</h2>
                        </div>
                        <div class="form-card-body">
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">Müşteri Adı</label>
                                    <asp:TextBox ID="txtClientName" runat="server" CssClass="form-input" placeholder="Müşteri adı"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Teknolojiler</label>
                                    <asp:TextBox ID="txtTechnologies" runat="server" CssClass="form-input" placeholder="Örn: ASP.NET, C#, SQL"></asp:TextBox>
                                    <span class="form-hint">Virgülle ayırın</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>

            <div class="editor-sidebar">
                <div class="sidebar-card">
                    <h3>💡 İpuçları</h3>
                    <ul class="tips-list">
                        <li>Başlık kısa ve açıklayıcı olmalı</li>
                        <li>Özet, içeriğinizi özetleyen 2-3 cümle olmalı</li>
                        <li>SEO ayarları arama motorları için önemli</li>
                        <li>Taslak olarak kaydedip sonra yayınlayabilirsiniz</li>
                    </ul>
                </div>

                <div class="sidebar-card">
                    <h3>📊 Hızlı İstatistikler</h3>
                    <div class="stats-grid">
                        <div class="stat-item">
                            <span class="stat-label">Karakter</span>
                            <span class="stat-value" id="charCount">0</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-label">Kelime</span>
                            <span class="stat-value" id="wordCount">0</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Hızlı Kategori Ekleme Modal -->
    <asp:Panel ID="quickCategoryModal" runat="server" CssClass="modal-overlay" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h3>➕ Hızlı Kategori Ekle</h3>
                <button type="button" class="modal-close" onclick="closeQuickCategoryModal(); return false;">&times;</button>
            </div>
            <div class="modal-body">
                <asp:Label ID="lblQuickCategoryError" runat="server" CssClass="form-error" Visible="false"></asp:Label>
                <div class="form-group">
                    <label class="form-label">Kategori Adı <span class="required">*</span></label>
                    <asp:TextBox ID="txtQuickCategoryName" runat="server" CssClass="form-input" placeholder="Örn: Teknoloji, Web Tasarım" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvQuickCategoryName" runat="server" 
                        ControlToValidate="txtQuickCategoryName" 
                        ErrorMessage="Kategori adı zorunludur!" 
                        Display="Dynamic" 
                        CssClass="form-error"
                        ValidationGroup="QuickCategory"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label class="form-label">Açıklama</label>
                    <asp:TextBox ID="txtQuickCategoryDesc" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="2" placeholder="Kategori hakkında kısa açıklama (opsiyonel)"></asp:TextBox>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline" onclick="closeQuickCategoryModal(); return false;">İptal</button>
                <asp:Button ID="btnSaveQuickCategory" runat="server" Text="Kaydet" CssClass="btn btn-primary" OnClick="btnSaveQuickCategory_Click" ValidationGroup="QuickCategory" CausesValidation="true" />
            </div>
        </div>
    </asp:Panel>

    <script>
        // TinyMCE Başlatma
        window.addEventListener('load', function() {
            tinymce.init({
                selector: '#txtIcerik',
                height: 450,
                menubar: false,
                plugins: ['lists', 'link', 'image', 'code', 'table'],
                toolbar: 'undo redo | bold italic underline | alignleft aligncenter alignright | bullist numlist | link image | code | removeformat',
                branding: false,
                content_style: 'body { font-family: "Source Sans Pro", sans-serif; font-size: 14px; }'
            });
        });

        // Görsel önizleme
        document.addEventListener('DOMContentLoaded', function() {
            var imageUrlInput = document.getElementById('<%= txtImageUrl.ClientID %>');
            var preview = document.getElementById('imagePreview');
            var previewImg = document.getElementById('previewImg');

            if (imageUrlInput) {
                imageUrlInput.addEventListener('input', function() {
                    var url = this.value.trim();
                    if (url) {
                        // Eğer sadece dosya adı ise /images/ prefix'i ekle
                        if (!url.startsWith('http://') && !url.startsWith('https://') && !url.startsWith('/')) {
                            url = '/images/' + url;
                        }
                        previewImg.src = url;
                        preview.style.display = 'block';
                    } else {
                        preview.style.display = 'none';
                    }
                });
            }

            // Karakter ve kelime sayacı
            var icerikInput = document.getElementById('txtIcerik');
            if (icerikInput) {
                icerikInput.addEventListener('input', function() {
                    var text = this.value;
                    var charCount = text.length;
                    var wordCount = text.trim() ? text.trim().split(/\s+/).length : 0;
                    
                    document.getElementById('charCount').textContent = charCount;
                    document.getElementById('wordCount').textContent = wordCount;
                });
            }
        });

        // Hızlı Kategori Ekleme Modal Fonksiyonları
        function openQuickCategoryModal(e) {
            // Form submit'i engelle
            if (e) {
                e.preventDefault();
                e.stopPropagation();
            }
            
            try {
                var modal = document.getElementById('<%= quickCategoryModal.ClientID %>');
                if (modal) {
                    modal.style.display = 'flex';
                    var txtName = document.getElementById('<%= txtQuickCategoryName.ClientID %>');
                    if (txtName) {
                        setTimeout(function() { 
                            try { txtName.focus(); } catch(err) { console.log('Focus error (ignored):', err); }
                        }, 100);
                    }
                }
            } catch(err) {
                console.error('Modal açma hatası:', err);
            }
            
            return false;
        }

        function closeQuickCategoryModal() {
            try {
                var modal = document.getElementById('<%= quickCategoryModal.ClientID %>');
                if (modal) modal.style.display = 'none';
            } catch(e) {
                console.error('Modal kapatma hatası:', e);
            }
        }

        // Modal dışına tıklanınca kapat
        if (document.addEventListener) {
            document.addEventListener('click', function(e) {
                try {
                    var modal = document.getElementById('<%= quickCategoryModal.ClientID %>');
                    if (modal && e.target === modal) {
                        closeQuickCategoryModal();
                    }
                } catch(e) {
                    // Hata yakalama - zararsız
                }
            });
        }

        // Runtime hatalarını yakala (browser extension hataları için)
        if (typeof chrome !== 'undefined' && chrome.runtime && chrome.runtime.lastError) {
            // Chrome extension hatalarını sessizce yakala
            try {
                chrome.runtime.lastError;
            } catch(e) {
                // Zararsız hata - görmezden gel
            }
        }
    </script>

</asp:Content>