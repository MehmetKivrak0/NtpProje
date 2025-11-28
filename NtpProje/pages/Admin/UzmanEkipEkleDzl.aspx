<%@ Page Title="Ekip Üyesi Ekle/Düzenle" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="UzmanEkipEkleDzl.aspx.cs" Inherits="NtpProje_Web.Admin.UzmanEkipEkleDzl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .editor-wrapper {
            background: #f5f7fa;
            min-height: calc(100vh - 60px);
            padding: 30px;
        }

        .editor-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 25px 30px;
            border-radius: 4px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .editor-header-left h1 {
            margin: 0;
            font-size: 24px;
            font-weight: 700;
            color: white;
        }

        .editor-subtitle {
            margin: 5px 0 0 0;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 10px;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: white;
        }

        .editor-header-actions {
            display: flex;
            gap: 10px;
        }

        .alert-message {
            padding: 15px 20px;
            border-radius: 4px;
            margin-bottom: 20px;
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
            max-width: 1200px;
            margin: 0 auto;
        }

        .form-card {
            background: #ffffff;
            border-radius: 4px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            margin-bottom: 30px;
            overflow: hidden;
        }

        .form-card-header {
            padding: 20px 25px;
            border-bottom: 1px solid #e3e6f0;
            background: #f8f9fc;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-card-header h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            color: #5a5c69;
        }

        .form-card-badge {
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            background: #e3f2fd;
            color: #1976d2;
        }

        .form-card-body {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
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
            font-weight: 400;
        }

        .form-input,
        .form-textarea,
        .form-select {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #d1d3e2;
            border-radius: 4px;
            font-size: 14px;
            font-family: 'Source Sans Pro', sans-serif;
            transition: border-color 0.2s;
        }

        .form-input:focus,
        .form-textarea:focus,
        .form-select:focus {
            outline: none;
            border-color: #4e73df;
        }

        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-error {
            color: #e74a3b;
            font-size: 13px;
            margin-top: 5px;
            display: block;
        }

        .form-error.success-message {
            color: #155724;
            background: #d4edda;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #c3e6cb;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            border: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-primary {
            background: #4e73df;
            color: white;
        }

        .btn-primary:hover {
            background: #375a7f;
        }

        .btn-outline {
            background: transparent;
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.5);
        }

        .btn-outline:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: white;
        }

        .upload-wrapper {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .file-upload-input {
            padding: 10px;
            border: 1px solid #d1d3e2;
            border-radius: 4px;
        }

        .image-preview {
            margin-top: 15px;
            padding: 15px;
            background: #f8f9fc;
            border-radius: 4px;
            text-align: center;
        }

        .image-preview img {
            max-width: 200px;
            max-height: 200px;
            border-radius: 4px;
            object-fit: cover;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .editor-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="editor-wrapper">
        <div class="editor-header">
            <div class="editor-header-left">
                <a href="uzmanekp.aspx" class="back-link">
                    <span>←</span> Geri Dön
                </a>
                <h1><asp:Literal ID="ltrPageTitle" runat="server" Text="Ekip Üyesi" /> Ekle/Düzenle</h1>
                <p class="editor-subtitle">Ekip üyesi bilgilerini girin</p>
            </div>
            <div class="editor-header-actions">
                <asp:Button ID="btnKaydet" runat="server" Text="💾 Kaydet" CssClass="btn btn-primary" OnClick="btnKaydet_Click" ValidationGroup="MainForm" />
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert-message" Visible="false"></asp:Label>
        
        <asp:HiddenField ID="hfMemberId" runat="server" />

        <div class="editor-content">
            <!-- Genel Bilgiler -->
            <div class="form-card">
                <div class="form-card-header">
                    <h2>👤 Genel Bilgiler</h2>
                    <span class="form-card-badge">Zorunlu</span>
                </div>
                <div class="form-card-body">
                    <div class="form-group">
                        <label class="form-label">
                            Ad Soyad <span class="required">*</span>
                            <span class="form-hint">Tam ad ve soyad</span>
                        </label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Örn: Mehmet Yılmaz" MaxLength="100"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="Ad Soyad zorunludur" Display="Dynamic" CssClass="form-error" ValidationGroup="MainForm" />
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                Unvan
                                <span class="form-hint">Örn: Yazılım Geliştirici</span>
                            </label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-input" placeholder="Unvan" MaxLength="100"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Pozisyon
                                <span class="form-hint">Örn: Senior Developer</span>
                            </label>
                            <asp:TextBox ID="txtPosition" runat="server" CssClass="form-input" placeholder="Pozisyon" MaxLength="100"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Biyografi
                            <span class="form-hint">Ekip üyesi hakkında kısa bilgi</span>
                        </label>
                        <asp:TextBox ID="txtBio" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="5" placeholder="Biyografi bilgisi..."></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- İletişim Bilgileri -->
            <div class="form-card">
                <div class="form-card-header">
                    <h2>📞 İletişim Bilgileri</h2>
                    <span class="form-card-badge">Opsiyonel</span>
                </div>
                <div class="form-card-body">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                E-posta
                            </label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email" placeholder="ornek@email.com" MaxLength="100"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Telefon
                            </label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-input" TextMode="Phone" placeholder="+90 555 123 45 67" MaxLength="50"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sosyal Medya -->
            <div class="form-card">
                <div class="form-card-header">
                    <h2>🌐 Sosyal Medya</h2>
                    <span class="form-card-badge">Opsiyonel</span>
                </div>
                <div class="form-card-body">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fab fa-linkedin" style="color: #0077b5; margin-right: 8px;"></i> LinkedIn URL
                            </label>
                            <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="form-input" placeholder="https://linkedin.com/in/username" MaxLength="500"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fab fa-x-twitter" style="color: #000000; margin-right: 8px;"></i> X (Twitter) URL
                            </label>
                            <asp:TextBox ID="txtTwitter" runat="server" CssClass="form-input" placeholder="https://twitter.com/username" MaxLength="500"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fab fa-github" style="color: #333333; margin-right: 8px;"></i> GitHub URL
                        </label>
                        <asp:TextBox ID="txtGithub" runat="server" CssClass="form-input" placeholder="https://github.com/username" MaxLength="500"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Medya ve Ayarlar -->
            <div class="form-card">
                <div class="form-card-header">
                    <h2>🖼️ Medya ve Ayarlar</h2>
                </div>
                <div class="form-card-body">
                    <div class="form-group">
                        <label class="form-label">
                            Resim Yükle
                            <span class="form-hint">JPG, PNG, GIF veya WEBP formatında (Max: 5MB)</span>
                        </label>
                        <div class="upload-wrapper">
                            <asp:FileUpload ID="fileImageUpload" runat="server" CssClass="file-upload-input" accept="image/*" />
                            <asp:Button ID="btnUploadImage" runat="server" Text="📤 Resmi Yükle" CssClass="btn btn-secondary" OnClick="btnUploadImage_Click" CausesValidation="false" />
                            <asp:Label ID="lblUploadError" runat="server" CssClass="form-error" Visible="false"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">
                            Fotoğraf URL (Alternatif)
                            <span class="form-hint">Veya görselin tam URL'sini girin (opsiyonel)</span>
                        </label>
                        <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-input" placeholder="uploads/team/mehmet-yilmaz.jpg" MaxLength="500"></asp:TextBox>
                        <div class="image-preview" id="imagePreview" style="display: none; margin-top: 15px;">
                            <img id="previewImg" src="#" alt="Önizleme" />
                            <div style="margin-top: 10px;">
                                <button type="button" class="btn btn-outline" onclick="removeImage(); return false;" style="background: #e74a3b; color: white; border-color: #e74a3b;">🗑️ Resmi Kaldır</button>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                Durum
                            </label>
                            <asp:DropDownList ID="ddlIsActive" runat="server" CssClass="form-select">
                                <asp:ListItem Value="true" Text="✅ Aktif" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="false" Text="🚫 Pasif"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                Sıralama
                                <span class="form-hint">Düşük sayı önce gösterilir</span>
                            </label>
                            <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-input" TextMode="Number" Text="0"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var imageUrlInput = document.getElementById('<%= txtImageUrl.ClientID %>');
            var preview = document.getElementById('imagePreview');
            var previewImg = document.getElementById('previewImg');

            // Sayfa yüklendiğinde mevcut görsel varsa göster
            if (imageUrlInput && imageUrlInput.value.trim()) {
                updateImagePreview();
            }

            if (imageUrlInput) {
                imageUrlInput.addEventListener('input', function() {
                    updateImagePreview();
                });

                imageUrlInput.addEventListener('change', function() {
                    updateImagePreview();
                });
            }

            function updateImagePreview() {
                var url = imageUrlInput.value.trim();
                if (url && preview && previewImg) {
                    // URL çözümleme
                    var resolvedUrl = url;
                    if (!url.startsWith('http://') && !url.startsWith('https://')) {
                        // Relative path ise başına / ekle
                        if (!url.startsWith('/') && !url.startsWith('~/')) {
                            resolvedUrl = '/' + url;
                        } else if (url.startsWith('~/')) {
                            resolvedUrl = url.replace('~/', '/');
                        }
                    }
                    
                    previewImg.src = resolvedUrl;
                    preview.style.display = 'block';
                    
                    // Hata durumunda gizle
                    previewImg.onerror = function() {
                        preview.style.display = 'none';
                    };
                } else if (preview) {
                    preview.style.display = 'none';
                }
            }

            // Global fonksiyon - resmi kaldır
            window.removeImage = function() {
                if (imageUrlInput) {
                    imageUrlInput.value = '';
                }
                if (preview) {
                    preview.style.display = 'none';
                }
                return false;
            };

            // FileUpload için önizleme
            var fileUpload = document.getElementById('<%= fileImageUpload.ClientID %>');
            if (fileUpload) {
                fileUpload.addEventListener('change', function(e) {
                    var file = e.target.files[0];
                    if (file && file.type.startsWith('image/')) {
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            if (previewImg) {
                                previewImg.src = e.target.result;
                            }
                            if (preview) {
                                preview.style.display = 'block';
                            }
                        };
                        reader.readAsDataURL(file);
                    }
                });
            }
        });
    </script>

</asp:Content>
