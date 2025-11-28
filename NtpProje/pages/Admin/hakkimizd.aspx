<%@ Page Title="Hakkımızda Sayfası Yönetimi" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="hakkimizd.aspx.cs" Inherits="NtpProje_Web.Admin.hakkimizd" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.tiny.cloud/1/9gxedwrxprvwnxucm3y2ror96j6c1d5jet6mt1izz6hdx7m7/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
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

        .editor-content {
            display: grid;
            gap: 25px;
        }

        .form-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .form-card-header {
            background: #f8f9fa;
            padding: 20px 25px;
            border-bottom: 2px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-card-header h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        .form-card-body {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-hint {
            display: block;
            font-size: 12px;
            color: #6c757d;
            font-weight: normal;
            margin-top: 4px;
        }

        .form-textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: inherit;
            font-size: 14px;
            resize: vertical;
        }

        .alert-message {
            padding: 15px 20px;
            border-radius: 4px;
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

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5568d3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="editor-wrapper">
        <div class="editor-header">
            <div class="editor-header-left">
                <h1>📄 Hakkımızda Sayfası Yönetimi</h1>
                <p class="editor-subtitle">Hakkımızda sayfasındaki içerikleri düzenleyin</p>
            </div>
            <div class="editor-header-actions">
                <asp:Button ID="btnKaydet" runat="server" Text="💾 Kaydet" CssClass="btn btn-primary" OnClick="btnKaydet_Click" ValidationGroup="AboutForm" />
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert-message" Visible="false"></asp:Label>

        <div class="editor-content">
            <!-- Biz Kimiz? -->
            <div class="form-card">
                <div class="form-card-header">
                    <h2>👥 Biz Kimiz?</h2>
                </div>
                <div class="form-card-body">
                    <div class="form-group">
                        <label class="form-label">
                            Şirket Kimliği İçeriği
                            <span class="form-hint">Şirketiniz hakkında detaylı bilgiler</span>
                        </label>
                        <asp:TextBox ID="txtKimlik" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="10" ClientIDMode="Static"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Vizyonumuz -->
            <div class="form-card">
                <div class="form-card-header">
                    <h2>🎯 Vizyonumuz</h2>
                </div>
                <div class="form-card-body">
                    <div class="form-group">
                        <label class="form-label">
                            Vizyon İçeriği
                            <span class="form-hint">Şirketinizin uzun vadeli hedefleri ve vizyonu</span>
                        </label>
                        <asp:TextBox ID="txtVizyon" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="8" ClientIDMode="Static"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Misyonumuz -->
            <div class="form-card">
                <div class="form-card-header">
                    <h2>🎖️ Misyonumuz</h2>
                </div>
                <div class="form-card-body">
                    <div class="form-group">
                        <label class="form-label">
                            Misyon İçeriği
                            <span class="form-hint">Şirketinizin misyon bildirisi</span>
                        </label>
                        <asp:TextBox ID="txtMisyon" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="8" ClientIDMode="Static"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // TinyMCE Editor Yapılandırması
        tinymce.init({
            selector: '#txtKimlik',
            height: 400,
            menubar: false,
            plugins: [
                'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                'insertdatetime', 'media', 'table', 'code', 'help', 'wordcount'
            ],
            toolbar: 'undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help | code',
            content_style: 'body { font-family: Arial, sans-serif; font-size: 14px; }',
            language: 'tr',
            promotion: false
        });

        tinymce.init({
            selector: '#txtVizyon',
            height: 300,
            menubar: false,
            plugins: [
                'advlist', 'autolink', 'lists', 'link', 'charmap', 'preview',
                'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                'insertdatetime', 'media', 'table', 'code', 'help', 'wordcount'
            ],
            toolbar: 'undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help',
            content_style: 'body { font-family: Arial, sans-serif; font-size: 14px; }',
            language: 'tr',
            promotion: false
        });

        tinymce.init({
            selector: '#txtMisyon',
            height: 300,
            menubar: false,
            plugins: [
                'advlist', 'autolink', 'lists', 'link', 'charmap', 'preview',
                'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                'insertdatetime', 'media', 'table', 'code', 'help', 'wordcount'
            ],
            toolbar: 'undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help',
            content_style: 'body { font-family: Arial, sans-serif; font-size: 14px; }',
            language: 'tr',
            promotion: false
        });
    </script>
</asp:Content>
