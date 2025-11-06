<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_dashboard.aspx.cs" Inherits="NtpProje.pages.Admin.WebForm1" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="/css/admin.css" />
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        .badge { /* Stiller admin.css içinde olmalı */
        }

        .badge-success { /* ... */
        }

        .badge-warning { /* ... */
        }

        .badge-danger { /* ... */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">GB</div>
                <h2>Genç Birey</h2>
            </div>

            <nav class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-section-title">Ana Menü</div>
                    <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="~/pages/Admin/admin_dashboard.aspx" CssClass="menu-item active"><i>📊</i> <span>Dashboard</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkSayfalar" runat="server" NavigateUrl="#" CssClass="menu-item"><i>📄</i> <span>Sayfalar</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkBlogYazilari" runat="server" NavigateUrl="~/pages/Admin/YaziYonetimi.aspx" CssClass="menu-item"><i>📝</i> <span>Blog Yazıları</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkProjeler" runat="server" NavigateUrl="~/pages/Admin/ProjeYonetimi.aspx" CssClass="menu-item"><i>🖼️</i> <span>Projeler</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkHizmetler" runat="server" NavigateUrl="#" CssClass="menu-item"><i>⚙️</i> <span>Hizmetler</span></asp:HyperLink>
                </div>


                <div class="menu-section">
                    <div class="menu-section-title">İçerik Yönetimi</div>
                    <asp:HyperLink ID="lnkMedya" runat="server" NavigateUrl="#" CssClass="menu-item"><i>🎨</i> <span>Medya</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkEkip" runat="server" NavigateUrl="#" CssClass="menu-item"><i>👥</i> <span>Ekip</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkYorumlar" runat="server" NavigateUrl="#" CssClass="menu-item"><i>💬</i> <span>Yorumlar</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkMesajlar" runat="server" NavigateUrl="~/pages/Admin/IletisimMesajlari.aspx" CssClass="menu-item"><i>📧</i> <span>Mesajlar</span></asp:HyperLink>
                </div>

                <div class="menu-section">
                    <div class="menu-section-title">Raporlama</div>
                    <asp:HyperLink ID="lnkRaporlar" runat="server" NavigateUrl="~/pages/Admin/Raporlar.aspx" CssClass="menu-item"><i>📈</i> <span>Raporlar</span></asp:HyperLink>
                </div>

                <div class="menu-section">
                    <div class="menu-section-title">Ayarlar</div>
                    <asp:HyperLink ID="lnkKategoriler" runat="server" NavigateUrl="~/pages/Admin/KategoriYonetimi.aspx" CssClass="menu-item"><i>🏷️</i> <span>Kategoriler</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkKullanicilar" runat="server" NavigateUrl="#" CssClass="menu-item"><i>👤</i> <span>Kullanıcılar</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkSiteAyarlari" runat="server" NavigateUrl="#" CssClass="menu-item"><i>🔧</i> <span>Site Ayarları</span></asp:HyperLink>
                    <asp:HyperLink ID="lnkGuvenlik" runat="server" NavigateUrl="#" CssClass="menu-item"><i>🔐</i> <span>Güvenlik</span></asp:HyperLink>

                    <%-- Güvenli Çıkış Butonu --%>
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
                    <div class="topbar-user">
                        <div class="user-avatar">
                            <asp:Literal ID="ltrUserAvatar" runat="server">A</asp:Literal>
                        </div>
                        <div class="user-info">
                            <div class="user-name">
                                <asp:Literal ID="ltrUserName" runat="server">Admin User</asp:Literal>
                            </div>
                            <div class="user-role">
                                <asp:Literal ID="ltrUserRole" runat="server">Yönetici</asp:Literal>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="stat-icon blue">📄</div>
                    <div class="stat-content">
                        <h3>
                            <asp:Literal ID="ltrToplamSayfa" runat="server">0</asp:Literal></h3>
                        <p>Toplam Sayfa</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green">📝</div>
                    <div class="stat-content">
                        <h3>
                            <asp:Literal ID="ltrBlogYazisi" runat="server">0</asp:Literal></h3>
                        <p>Blog Yazısı</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon orange">👥</div>
                    <div class="stat-content">
                        <h3>
                            <asp:Literal ID="ltrToplamZiyaretci" runat="server">0</asp:Literal></h3>
                        <p>Toplam Ziyaretçi</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon red">💬</div>
                    <div class="stat-content">
                        <h3>
                            <asp:Literal ID="ltrYeniMesaj" runat="server">0</asp:Literal></h3>
                        <p>Yeni Mesaj</p>
                    </div>
                </div>
            </div>

            <div class="dashboard-table">
                <div class="table-header">
                    <h2>Son Blog Yazıları</h2>
                    <div class="table-actions">
                        <%-- Yeni Ekle Butonu --%>
                        <asp:Button ID="btnYeniYaziEkle" runat="server" Text="+ Yeni Ekle" OnClick="btnYeniYaziEkle_Click" CssClass="btn-small btn-add" CausesValidation="false" />
                    </div>
                </div>

                <%-- Repeater Kullanımı (GridView'dan daha esnek) --%>
                <asp:Repeater ID="rptBlogYazilari" runat="server" OnItemCommand="rptBlogYazilari_ItemCommand">
                    <HeaderTemplate>
                        <table>
                            <thead>
                                <tr>
                                    <th>Başlık</th>
                                    <th>Yazar</th>
                                    <th>Kategori</th>
                                    <th>Tarih</th>
                                    <th>Durum</th>
                                    <th>İşlemler</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Title") %></td>
                            <td><%# Eval("AuthorName") %></td>
                            <td><%# Eval("CategoryName") %></td>
                            <td><%# Eval("PublishDate", "{0:dd Ekim yyyy}") %></td>
                            <td><span class='badge badge-<%# Eval("StatusCssClass") %>'><%# Eval("StatusName") %></span></td>
                            <td>
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnDuzenle" runat="server" CommandName="Duzenle" CommandArgument='<%# Eval("PostId") %>' CssClass="btn-icon btn-edit" ToolTip="Düzenle">✏️</asp:LinkButton>
                                    <asp:LinkButton ID="btnSil" runat="server" CommandName="Sil" CommandArgument='<%# Eval("PostId") %>' CssClass="btn-icon btn-delete" ToolTip="Sil" OnClientClick="return confirm('Bu yazıyı silmek istediğinize emin misiniz?');">🗑️</asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                        </table>
                       
                        <% if (rptBlogYazilari.Items.Count == 0)
                            { %>
                        <div style="text-align: center; padding: 40px;">Henüz blog yazısı bulunmamaktadır.</div>
                        <% } %>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <div class="dashboard-table">
                <div class="table-header">
                    <h2>Son Projeler</h2>
                    <div class="table-actions">
                        <asp:Button ID="btnYeniProjeEkle" runat="server" Text="+ Yeni Proje" OnClick="btnYeniProjeEkle_Click" CssClass="btn-small btn-add" CausesValidation="false" />
                    </div>
                </div>
                <%-- Buraya da Son Projeler için bir Repeater veya GridView gelecek --%>
                <asp:Repeater ID="rptProjeler" runat="server" OnItemCommand="rptProjeler_ItemCommand">
                    <HeaderTemplate>
                        <table>
                            <thead>
                                <tr>
                                    <th>Proje Adı</th>
                                    <th>Müşteri</th>
                                    <th>Başlangıç Tarihi</th>
                                    <th>Bitiş Tarihi</th>
                                    <th>Durum</th>
                                    <th>İşlemler</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("ProjectName") %></td>
                            <td><%# Eval("ClientName") %></td>
                            <td><%# Eval("StartDate", "{0:dd MMM yyyy}") %></td>
                            <td><%# Eval("EndDate", "{0:dd MMM yyyy}") %></td>
                            <td><span class='badge badge-<%# Eval("StatusCssClass") %>'><%# Eval("StatusName") %></span></td>
                            <td>
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnProjeDuzenle" runat="server" CommandName="Duzenle" CommandArgument='<%# Eval("ProjectId") %>' CssClass="btn-icon btn-edit" ToolTip="Düzenle">✏️</asp:LinkButton>
                                    <asp:LinkButton ID="btnProjeSil" runat="server" CommandName="Sil" CommandArgument='<%# Eval("ProjectId") %>' CssClass="btn-icon btn-delete" ToolTip="Sil" OnClientClick="return confirm('Bu projeyi silmek istediğinize emin misiniz?');">🗑️</asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                        </table>
                        
                        <% if (rptProjeler.Items.Count == 0)
                            { %>
                        <div style="text-align: center; padding: 40px;">Henüz proje bulunmamaktadır.</div>
                        <% } %>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </main>
    </form>

    <script>
        // Responsive sidebar toggle (mobil için)
        let sidebarOpen = true;
        function toggleSidebar() {
            // Bu fonksiyonun çalışması için Topbar'a bir toggle butonu eklenmeli
            const sidebar = document.querySelector('.sidebar');
            const mainContent = document.querySelector('.main-content');

            if (sidebarOpen) {
                sidebar.style.transform = 'translateX(-100%)';
                mainContent.style.marginLeft = '0';
            } else {
                sidebar.style.transform = 'translateX(0)';
                // mainContent.style.marginLeft = '260px'; // CSS dosyanızdaki değere göre ayarlayın
            }
            sidebarOpen = !sidebarOpen;
        }

        // Bildirim göster (C# tarafından çağrılabilir)
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = 'alert alert-' + type; // alert ve alert-success/error sınıfları CSS'te olmalı
            notification.textContent = message;
            notification.style.position = 'fixed';
            notification.style.top = '20px';
            notification.style.right = '20px';
            notification.style.zIndex = '10000';
            document.body.appendChild(notification);

            setTimeout(function () {
                notification.remove();
            }, 3000);
        }
    </script>
</body>
</html>
