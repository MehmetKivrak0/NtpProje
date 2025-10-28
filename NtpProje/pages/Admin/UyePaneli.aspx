<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UyePaneli.aspx.cs" Inherits="NtpProje.pages.Admin.UyePaneli" %>


<!DOCTYPE html>
<html lang="tr">
<head runat="server"> <%-- head etiketi C# ile yönetileceği için runat="server" kalmalı --%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Üye Paneli - Genç Birey</title>

    <%-- CSS yolu (Master Page olmadığı için doğrudan yazılır) --%>
    <link rel="stylesheet" href="/css/admin.css" />

    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">

    <%-- Sayfaya özel CSS stilleri --%>
    <style>
        .profile-info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
        .profile-info-item p:first-child { color: #666; margin-bottom: 5px; font-size: 13px; }
        .profile-info-item p:last-child { font-weight: 600; color: #2c3e50; margin: 0; }
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); align-items: center; justify-content: center; z-index: 1000; }
        .modal.is-visible { display: flex; }
        .modal-content { background-color: #fff; padding: 30px; border-radius: 8px; max-width: 600px; width: 90%; box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
        .modal-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 20px; }
        .modal-header h2 { margin: 0; font-size: 1.5em; }
        .modal-close { background: none; border: none; font-size: 1.8em; cursor: pointer; color: #aaa; padding: 0; line-height: 1; }
        .modal-close:hover { color: #333; }
        .modal-actions { text-align: right; margin-top: 25px; border-top: 1px solid #eee; padding-top: 15px; }
        .modal-actions .btn { margin-left: 10px; }
        .validation-summary ul { padding-left: 20px; margin-top: 10px; }
        /* Body için dashboard class'ı admin.css içinde olmalı */
    </style>
</head>
<body class="dashboard"> <%-- body etiketi normal HTML --%>
    <%-- Tüm ASP.NET kontrolleri BU formun içinde olmalı --%>
    <form id="form1" runat="server">

        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">GB</div>
                <h2>Genç Birey</h2>
            </div>
            <nav class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-section-title">Üye Menüsü</div>
                    <%-- Aktif menü mantığı C# ile yapılmalı (Page_Load'da linklere CssClass="active" ekleyerek) --%>
                    <asp:HyperLink ID="lnkMenuAnaSayfa" runat="server" NavigateUrl="~/pages/Admin/UyePaneli.aspx" CssClass="menu-item active"><i>🏠</i> <span>Ana Sayfa</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkMenuYazilarim" runat="server" NavigateUrl="#" CssClass="menu-item"><i>📄</i> <span>Yazılarım</span></asp:HyperLink>
                    <%-- Diğer Menü Linkleri --%>
                </div>
                <div class="menu-section">
                    <div class="menu-section-title">Ayarlar</div>
                     <asp:LinkButton ID="lnkMenuProfil" runat="server" OnClick="btnOpenProfileModal_Click" CssClass="menu-item" CausesValidation="false"><i>👤</i> <span>Profil Ayarları</span></asp:LinkButton>
                     <asp:HyperLink ID="lnkMenuSifre" runat="server" NavigateUrl="#" CssClass="menu-item"><i>🔒</i> <span>Şifre Değiştir</span></asp:HyperLink>
                    <%-- Güvenli Çıkış Butonu --%>
<asp:LinkButton ID="lnkCikisYap" runat="server" CssClass="menu-item" OnClick="lnkCikisYap_Click"><i>🚪</i> <span>Çıkış Yap</span></asp:LinkButton>                </div>
            </nav>
        </aside>

        <main class="main-content">
            <div class="topbar">
                 <div class="topbar-left">
                    <h1><asp:Literal ID="ltrPageTitle" runat="server" Text="Hoş Geldiniz!"></asp:Literal></h1>
                 </div>
                 <div class="topbar-right">
                     <div class="topbar-user">
                         <div class="user-avatar"><asp:Literal ID="ltrUserAvatar" runat="server">U</asp:Literal></div>
                         <div class="user-info">
                            <div class="user-name"><asp:Literal ID="ltrUserName" runat="server">Üye</asp:Literal></div>
                            <div class="user-role"><asp:Literal ID="ltrUserRole" runat="server">Üye</asp:Literal></div>
                         </div>
                     </div>
                 </div>
            </div>

            <%-- Hata/Başarı Mesaj Alanı --%>
            <asp:Literal ID="ltrMesaj" runat="server" EnableViewState="false"></asp:Literal>

            <div class="dashboard-stats">
                 <div class="stat-card"> <div class="stat-icon blue">📝</div> <div class="stat-content"><h3><asp:Literal ID="ltrTotalPosts" runat="server">0</asp:Literal></h3><p>Toplam Yazı</p></div> </div>
                 <div class="stat-card"> <div class="stat-icon green">❤️</div> <div class="stat-content"><h3><asp:Literal ID="ltrTotalFavorites" runat="server">0</asp:Literal></h3><p>Favoriler</p></div> </div>
                 <div class="stat-card"> <div class="stat-icon orange">💬</div> <div class="stat-content"><h3><asp:Literal ID="ltrTotalComments" runat="server">0</asp:Literal></h3><p>Yorumlarım</p></div> </div>
                 <div class="stat-card"> <div class="stat-icon red">📧</div> <div class="stat-content"><h3><asp:Literal ID="ltrTotalMessages" runat="server">0</asp:Literal></h3><p>Mesajlarım</p></div> </div>
            </div>

            <div class="dashboard-table">
                <div class="table-header"><h2>Profil Bilgilerim</h2> <asp:Button ID="btnOpenProfileModal" runat="server" Text="✏️ Düzenle" OnClick="btnOpenProfileModal_Click" CssClass="btn-small btn-add" CausesValidation="false"/></div>
                <div id="profileInfo" style="padding: 20px;" class="profile-info-grid">
                     <div class="profile-info-item"><p>Ad Soyad</p><p><asp:Literal ID="ltrProfileFullName" runat="server">-</asp:Literal></p></div>
                     <div class="profile-info-item"><p>E-posta</p><p><asp:Literal ID="ltrProfileEmail" runat="server">-</asp:Literal></p></div>
                     <div class="profile-info-item"><p>Telefon</p><p><asp:Literal ID="ltrProfilePhone" runat="server">-</asp:Literal></p></div>
                     <div class="profile-info-item"><p>Kayıt Tarihi</p><p><asp:Literal ID="ltrProfileRegisterDate" runat="server">-</asp:Literal></p></div>
                     <div class="profile-info-item" style="grid-column: 1 / -1;"><p>Hakkımda</p><p><asp:Literal ID="ltrProfileBio" runat="server">-</asp:Literal></p></div>
                </div>
            </div>

            <div class="dashboard-table">
                <div class="table-header"><h2>Son Yazılar</h2></div>
                <table>
                    <thead><tr><th>Başlık</th><th>Kategori</th><th>Tarih</th><th>Durum</th><th>İşlemler</th></tr></thead>
                    <tbody>
                        <asp:Repeater ID="rptUserPosts" runat="server">
                            <ItemTemplate><tr><td><%# Eval("Title") %></td><td><span class="badge badge-success"><%# Eval("CategoryName") %></span></td><td><%# Eval("PublishDate", "{0:dd MMMM yyyy}") %></td><td><span class="badge badge-success"><%# Eval("Status") %></span></td><td><div class="action-buttons"><asp:LinkButton ID="btnViewPost" runat="server" CommandArgument='<%# Eval("PostId") %>' OnClick="btnViewPost_Click" CssClass="btn-icon" ToolTip="Görüntüle">👁️</asp:LinkButton></div></td></tr></ItemTemplate>
                            <FooterTemplate><% if (rptUserPosts.Items.Count == 0) { %><tr><td colspan="5" style="text-align: center; padding: 40px;">Henüz yazınız bulunmamaktadır</td></tr><% } %></FooterTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <div class="dashboard-table">
                <div class="table-header"><h2>Son Aktivitelerim</h2></div>
                <div id="activitiesList" style="padding: 0;">
                     <asp:Repeater ID="rptActivities" runat="server">
                         <ItemTemplate><div style="padding: 15px; border-bottom: 1px solid #f0f0f0; display: flex; align-items: center; gap: 15px;"><div style="font-size: 24px;"><%# Eval("Icon") %></div><div style="flex: 1;"><p style="margin: 0; color: #2c3e50;"><%# Eval("Text") %></p><p style="margin: 5px 0 0; font-size: 12px; color: #7f8c8d;"><%# Eval("TimeAgo") %></p></div></div></ItemTemplate>
                         <FooterTemplate><% if (rptActivities.Items.Count == 0) { %><div style="padding: 20px; text-align: center;">Hiç aktiviteniz yok.</div><% } %></FooterTemplate>
                     </asp:Repeater>
                </div>
            </div>
        </main> <%-- Main Content Biter --%>

        <asp:Panel ID="profileModal" runat="server" CssClass="modal" Visible="false">
            <div class="modal-content">
                <div class="modal-header"><h2>Profil Bilgilerini Düzenle</h2><asp:LinkButton ID="btnCloseModal" runat="server" CssClass="modal-close" OnClick="btnCloseModal_Click" Text="✕" CausesValidation="false"></asp:LinkButton></div>
                <asp:Panel ID="pnlProfileForm" runat="server" DefaultButton="btnSaveProfile">
                    <asp:HiddenField ID="hfUserId" runat="server" />
                    <div class="form-group"><label for="<%= txtProfileName.ClientID %>">Ad Soyad</label><asp:TextBox ID="txtProfileName" runat="server" CssClass="form-control"></asp:TextBox><asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtProfileName" ErrorMessage="Ad Soyad gereklidir." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></div>
                    <div class="form-group"><label for="<%= txtProfileEmail.ClientID %>">E-posta</label><asp:TextBox ID="txtProfileEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox><asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtProfileEmail" ErrorMessage="E-posta gereklidir." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtProfileEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Geçerli bir e-posta girin." ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator></div>
                    <div class="form-group"><label for="<%= txtProfilePhone.ClientID %>">Telefon</label><asp:TextBox ID="txtProfilePhone" runat="server" CssClass="form-control" TextMode="Phone"></asp:TextBox></div>
                    <div class="form-group"><label for="<%= txtProfileBio.ClientID %>">Hakkımda</label><asp:TextBox ID="txtProfileBio" runat="server" TextMode="MultiLine" Rows="4" placeholder="Kendinizden bahsedin..." CssClass="form-control"></asp:TextBox></div>
                    <div class="modal-actions"><asp:Button ID="btnCancelModal" runat="server" Text="İptal" OnClick="btnCloseModal_Click" CssClass="btn btn-secondary" CausesValidation="false" /><asp:Button ID="btnSaveProfile" runat="server" Text="Kaydet" OnClick="btnSaveProfile_Click" CssClass="btn btn-primary" /></div>
                    <asp:ValidationSummary ID="vsProfile" runat="server" ForeColor="Red" HeaderText="Lütfen hataları düzeltin:" CssClass="validation-summary"/>
                </asp:Panel>
            </div>
        </asp:Panel>

    </form> <%-- Ana Form Biter --%>

    <%-- Gerekli JavaScript kodları (Modal Aç/Kapat vb.) --%>
    <script type="text/javascript">
        // Bu fonksiyonlar C# tarafından ClientScript.RegisterStartupScript ile çağrılabilir
        // veya butonlara OnClientClick="openModal('...'); return false;" eklenebilir.
        function openModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) modal.style.display = 'flex';
        }
        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) modal.style.display = 'none';
        }
    </script>
</body>
</html>